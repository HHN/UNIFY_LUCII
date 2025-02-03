import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:lucii/data/models/event_info_json.dart';
import 'package:lucii/ui/features/bottom_navigation/create_event/create_event_controller.dart';
import 'package:lucii/utils/alert_util.dart';
import 'package:lucii/utils/appbar_util.dart';
import 'package:lucii/utils/button_util.dart';
import 'package:lucii/utils/common_widgets.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_field_util.dart';

import '../../../../utils/common_utils.dart';
import '../../../helper/global_variables.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  CreateEventScreenState createState() => CreateEventScreenState();
}

class CreateEventScreenState extends State<CreateEventScreen> {
  bool _switchValueEventCategory = false;
  bool _switchValueEventType = false;
  bool _switchValueLocation = false;
  bool _switchValueSkillLevel = false;
  bool _switchValueKeywords = false;

  final eventNameController = TextEditingController();
  final eventDetailsController = TextEditingController();
  final _controller = Get.put(CreateEventController());

  late double _distanceToField = 20.0;
  late final GenerativeModel _model;
  static const _apiKey ="AIzaSyAoE5hYQCDbzPngaoLwfLzjIpiiNyMO-xw";
  //static const _apiKey ="AIzaSyCutrvwuUzgv1oK5zuYRk5Z8wJga9-1ZbA";

  List<String> eventCategory = [];
  List<String> eventType = [];
  List<String> locations = [];
  List<String> skillLevel = [];
  List<String> keywords = [];

  List<String> matchedList = [];
  Map<String, List<String>>? jsonData;
  String? title, details, matchStr;

  @override
  void initState() {
    super.initState();
    loadJsonData();
   /* eventDetailsController.addListener(() {
      classifyWords(eventDetailsController.text);
    });*/
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);
  }
  loadJsonData() async {
    // Load the JSON file from the assets
    String jsonString = await rootBundle.loadString('assets/event_details.json');

    // Decode the JSON string into a List
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    jsonData = {
      'event_categories': List<String>.from(jsonMap['event_categories']),
      'event_types': List<String>.from(jsonMap['event_types']),
      'locations': List<String>.from(jsonMap['locations']),
      'skill_levels': List<String>.from(jsonMap['skill_levels']),
      'event_keywords': List<String>.from(jsonMap['event_keywords']),
    };
  }
  final Map<String, List<String>> synonymDict = {
    "AI": ["artificial intelligence", "machine intelligence"],
    "Machine Learning": ["ML", "machine learning"],
    "Cycling": ["biking", "riding"],
    // Add more synonyms as needed
  };
  List<String> getSynonyms(String keyword) {
    // Convert the keyword to lowercase to ensure case insensitivity
    String lowercaseKeyword = keyword.toLowerCase();

    // Iterate through synonymDict to find a key that matches lowercaseKeyword
    String matchedKey = synonymDict.keys.firstWhere(
            (key) => key.toLowerCase() == lowercaseKeyword,
        orElse: () => lowercaseKeyword  // Use lowercaseKeyword if no match is found
    );

    // Return the corresponding list of synonyms for the matched key
    return synonymDict[matchedKey] ?? [keyword];
  }
  List<String> expandKeywords(List<String> keywords) {
    List<String> expandedKeywords = [];
    for (var keyword in keywords) {
      expandedKeywords.addAll(getSynonyms(keyword));
    }
    return expandedKeywords;
  }
  Future<void> classifyWords(String text) async {

  /*  List<String> eventCategoryKeywords = jsonData!['event_categories'] ?? [];
    List<String> eventTypeKeywords = jsonData!['event_types'] ?? [];
    List<String> locationKeywords = jsonData!['locations'] ?? [];
    List<String> skillLevelKeywords = jsonData!['skill_levels'] ?? [];
    List<String> keywordsList = jsonData!['event_keywords'] ?? [];*/

   /* List<String> expandedEventCategoryKeywords = expandKeywords(eventCategoryKeywords);
    List<String> expandedEventTypeKeywords = expandKeywords(eventTypeKeywords);
    List<String> expandedLocationKeywords = expandKeywords(locationKeywords);
    List<String> expandedSkillLevelKeywords = expandKeywords(skillLevelKeywords);
    List<String> expandedKeywordsList = expandKeywords(keywordsList);*/

    List<String> words = text.split(' ');


    final content = [
      Content.multi([
        TextPart("""
        Please extract the following information from the user input and format it as JSON:
{
  "Event Name": "Extract the event name from the input (e.g., 'Technology Workshop')",
  "Description": "Extract a concise description of the event (e.g., 'An event for intermediates interested in Machine Learning')",
  "Location": "Extract the location of the event (e.g., 'Heilbronn')",
  "Skill Level": "Extract the skill level required for the event (e.g., 'Intermediate')",
  "Event Category": "Extract the category of the event (e.g., 'Technology')",
  "Event Type": "Extract the type of the event (e.g., 'Workshop')",
  "Tags/Keywords": "Extract relevant keywords from the input (e.g., 'Technology', 'Workshop', 'Machine Learning', 'Intermediate')"
}
        """),
        TextPart("User Input:$text"),
      ])
    ];

    final response = await _model.generateContent(content);
    log("Response: ${response.text}");
    final EventInfo eventInfo = EventInfo.parsejson(response.text??"");
    log("Event Name: ${eventInfo.eventName}");
    log("Description: ${eventInfo.description}");
    log("Location: ${eventInfo.location}");
    log("Tags/Keywords: ${eventInfo.tagsKeywords}");

    List<String> expandedEventCategoryKeywords = expandKeywords([eventInfo.eventCategory]);
    List<String> expandedEventTypeKeywords = expandKeywords([eventInfo.eventType]);
    List<String> expandedLocationKeywords = expandKeywords([eventInfo.location]);
    List<String> expandedSkillLevelKeywords = expandKeywords([eventInfo.skillLevel]);
    List<String> expandedKeywordsList = expandKeywords(eventInfo.tagsKeywords);
    eventNameController.text=eventInfo.eventName;
    setState(() {
      eventCategory.clear();
      eventType.clear();
      locations.clear();
      skillLevel.clear();
      keywords.clear();

      for (var word in words) {
        String lowercaseWord = word.toLowerCase();

        // Check for event category
        for (String keyword in expandedEventCategoryKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!eventCategory.contains(word)) {
              eventCategory.add(keyword);
            }
            break;
          }
        }

        // Check for event type
        for (String keyword in expandedEventTypeKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!eventType.contains(word)) {
              eventType.add(keyword);
            }
            break;
          }
        }

        // Check for locations
        for (String keyword in expandedLocationKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!locations.contains(word)) {
              locations.add(keyword);
            }
            break;
          }
        }

        // Check for skill level
        for (String keyword in expandedSkillLevelKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!skillLevel.contains(word)) {
              skillLevel.add(keyword);
            }
            break;
          }
        }

        // Check for keywords
        for (String keyword in expandedKeywordsList) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!keywords.contains(word)) {
              keywords.add(keyword);
            }
            break;
          }
        }
      }
    });
  }
  List<String> getCommonElements(String str1, String str2) {
    List<String> list1 = str1.split(",").toList();
    List<String> list2 = str2.split(",").toList();
    final lowerCaseList2 = list2.map((e) => e.toLowerCase()).toList();
    return list1.where((element) => lowerCaseList2.contains(element.toLowerCase())).toList();
  }
  bool isSimilar(String keyword, String userInput) {
    keyword = keyword.toLowerCase();
    userInput = userInput.toLowerCase();

    // Check if the user input contains the keyword or is similar to it
    bool flag = false;
    if(userInput.contains(keyword)) {
      flag = true;
    }
    else if(userInput.similarityTo(keyword) > 0.6){
      flag = true;
    } else if(keyword.similarityTo(userInput) > 0.6){
      flag = true;
    } else {
      flag = false;
    }
    return flag;
  }

  void createEvent() {
    // Placeholder function to store event in database
    // Implement your database storage logic here

    hideKeyboard();

    String eventName = eventNameController.text;
    String eventDetails = eventDetailsController.text;

    // Clear the fields after creating the event
    eventName.isNotEmpty
        // ? Get.snackbar('Success', 'Event created successfully!',
        //     snackPosition: SnackPosition.BOTTOM)
        ? alertForSuccessful(context,
            title: "Successful!".tr,
            subTitle: "Event created successfully".tr,
            buttonYesTitle: "Ok".tr, onYesAction: () {
          _controller.createEvent(
              title!,
              details!,
              matchedList.join(","),
              false,
              GlobalVariables.profileBox?.get("email")
          );
          Get.back();
          }, yesButtonColor: context.theme.focusColor)
        : Get.snackbar('Warning', 'Event Description or Title is Empty!',
            snackPosition: SnackPosition.BOTTOM);
    if(eventCategory.isNotEmpty || eventType.isNotEmpty || locations.isNotEmpty || skillLevel.isNotEmpty || keywords.isNotEmpty){
      //save to hive
      log("data save to hive");
      GlobalVariables.profileBox?.put("eventName", eventNameController.text);
      GlobalVariables.profileBox?.put("eventDetails", eventDetailsController.text);
      GlobalVariables.profileBox?.put("eventCategory", eventCategory.join(""));
      GlobalVariables.profileBox?.put("eventType", eventType.join(""));
      GlobalVariables.profileBox?.put("eventLocations", locations.join(""));
      GlobalVariables.profileBox?.put("skillLevel", skillLevel.join(""));
      GlobalVariables.profileBox?.put("keywords", keywords.join(""));

      matchedList.clear();
      if(eventCategory.isNotEmpty) matchedList.addAll(eventCategory);
      if(eventType.isNotEmpty) matchedList.addAll(eventType);
      if(locations.isNotEmpty) matchedList.addAll(locations);
      if(skillLevel.isNotEmpty) matchedList.addAll(skillLevel);
      if(keywords.isNotEmpty) matchedList.addAll(keywords);
      GlobalVariables.profileBox?.put("matchedList", matchedList.join(","));

      setState(() {
        matchStr = matchedList.join(",");
      });
    }
    setState(() {
      title = eventNameController.text.trim();
      details = eventDetailsController.text.trim();
    });
    eventNameController.clear();
    eventDetailsController.clear();
    setState(() {
      eventCategory.clear();
      eventType.clear();
      locations.clear();
      skillLevel.clear();
      keywords.clear();
    });

    // Show a confirmation message
  }

  @override
  Widget build(BuildContext context) {
    final _stringTagEventCategoryController = StringTagController();
    final _stringTagEventTypeController = StringTagController();
    final _stringTagLocationController = StringTagController();
    final _stringTagSkillLevelController = StringTagController();
    final _stringTagKeywordsController = StringTagController();


    TextEditingController _textController = TextEditingController();
    List<String> _tags = [];

    void _addTag(String tag) {
      setState(() {
        _tags.add(tag);
      });
      // Update Hive DB with the new tag
      // profileBox.put('tags', _tags);
    }

    return Scaffold(
      backgroundColor: context.theme.primaryColorLight,
      body: SafeArea(
        child: Column(
          children: [
            // AppBarMain(contextMain: context, title: "Add Event".tr),
            // AppBarMain(contextMain: context, title: "Create Post".tr),
            AppBarWithBack(title: "Create Post".tr),
            vSpacer20(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          TextFieldView(
                            controller: eventNameController,
                            hint: "Enter event name".tr,
                            inputType: TextInputType.text,
                            onTextChange: (string) {},
                          ),
                          Positioned(
                            bottom: 1,
                            right: 5,
                            child: ButtonOnlyCircleIcon(
                              iconData: Icons.mic_none_rounded,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      vSpacer20(),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          TextFieldView(
                            controller: eventDetailsController,
                            hint: "Enter event details".tr,
                            inputType: TextInputType.text,
                            maxLines: 3,
                            /*onTextChange: (string) {
                              classifyWords(string);
                            },*/
                            onTextcomplete: () {
                              classifyWords(eventDetailsController.text);
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, bottom: 2),
                            child: ButtonOnlyCircleIcon(
                              iconData: Icons.mic_none_rounded,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueEventCategory,
                        onChange: (value) {
                          setState(() {
                            _switchValueEventCategory = value;
                          });
                        },
                        titleText: "Event Category".tr,
                        stringTagController: _stringTagEventCategoryController,
                        distanceToField: _distanceToField,
                        text1: eventCategory.isNotEmpty ? eventCategory[0] : '',
                        text2: eventCategory.length > 1 ? eventCategory[1] : '',
                        text3: eventCategory.length > 2 ? eventCategory[2] : '',
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueEventType,
                        onChange: (value) {
                          setState(() {
                            _switchValueEventType = value;
                          });
                        },
                        titleText: "Event Type".tr,
                        stringTagController: _stringTagEventTypeController,
                        distanceToField: _distanceToField,
                        text1: eventType.isNotEmpty ? eventType[0] : '',
                        text2: eventType.length > 1 ? eventType[1] : '',
                        text3: eventType.length > 2 ? eventType[2] : '',
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueLocation,
                        onChange: (value) {
                          setState(() {
                            _switchValueLocation = value;
                          });
                        },
                        titleText: "Location".tr,
                        stringTagController: _stringTagLocationController,
                        distanceToField: _distanceToField,
                        text1: locations.isNotEmpty ? locations[0] : '',
                        text2: locations.length > 1 ? locations[1] : '',
                        text3: locations.length > 2 ? locations[2] : '',
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueSkillLevel,
                        onChange: (value) {
                          setState(() {
                            _switchValueSkillLevel = value;
                          });
                        },
                        titleText: "Skill Level".tr,
                        stringTagController: _stringTagSkillLevelController,
                        distanceToField: _distanceToField,
                        text1: skillLevel.isNotEmpty ? skillLevel[0] : '',
                        text2: skillLevel.length > 1 ? skillLevel[1] : '',
                        text3: skillLevel.length > 2 ? skillLevel[2] : '',
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueKeywords,
                        onChange: (value) {
                          setState(() {
                            _switchValueKeywords = value;
                          });
                        },
                        titleText: "Keywords".tr,
                        stringTagController: _stringTagKeywordsController,
                        distanceToField: _distanceToField,
                        text1: keywords.isNotEmpty ? keywords[0] : '',
                        text2: keywords.length > 1 ? keywords[1] : '',
                        text3: keywords.length > 2 ? keywords[2] : '',
                      ),
                      vSpacer20(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: createEvent,
                          child: Container(
                          padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: context.theme.focusColor,
                                border: Border.all(
                                  color: context.theme.focusColor,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(50))
                            ),
                            child: Icon(Icons.send,color: context.theme.primaryColorLight,),
                          ),
                        ),
                      ),
                      vSpacer20(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

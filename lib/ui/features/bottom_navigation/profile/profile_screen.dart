import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:lucii/ui/features/bottom_navigation/create_event/create_event_screen.dart';
import 'package:lucii/ui/helper/global_variables.dart';
import 'package:lucii/utils/appbar_util.dart';
import 'package:lucii/data/local/constants.dart';
import 'package:lucii/utils/button_util.dart';
import 'package:lucii/utils/colors.dart';
import 'package:lucii/utils/common_widgets.dart';
import 'package:lucii/utils/spacers.dart';
import 'package:lucii/utils/text_field_util.dart';
import 'package:lucii/utils/text_util.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../../../data/models/profilemodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool _switchValueInterest = false;
  bool _switchValueProfessionalBackground = false;
  bool _switchValueLocation = false;
  bool _switchValueEventPreferences = false;
  bool _switchValueSocialPreferences = false;
  bool _switchValueOthers = false;

  static const apiKey =
      'AIzaSyDqxKc8Z_s2KbGQSYj3KJqlpfIC-rk1gjQ';
  final textEditController = TextEditingController();
  late final GenerativeModel model;
  late double _distanceToField = 20.0;

  List<String> interests = [];
  List<String> professionalBackground = [];
  List<String> locations = [];
  List<String> eventPreferences = [];
  List<String> socialPreferences = [];
  List<String> others = [];

  List<String> profileList = [];

  Map<String, List<String>>? jsonData;

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
  loadJsonData() async {
    // Load the JSON file from the assets
    String jsonString = await rootBundle.loadString('assets/keywords.json');

    // Decode the JSON string into a List
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    jsonData = {
      'interests': List<String>.from(jsonMap['interests']),
      'professional_background': List<String>.from(jsonMap['professional_background']),
      'locations': List<String>.from(jsonMap['locations']),
      'event_preferences': List<String>.from(jsonMap['event_preferences']),
      'social_preferences': List<String>.from(jsonMap['social_preferences']),
    };
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    loadJsonData();
    model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);

    setState(() {
      if(GlobalVariables.profileBox!.containsKey("profileDetails")){
        textEditController.text = GlobalVariables.profileBox!.get("profileDetails");
      }
      if(GlobalVariables.profileBox!.containsKey("interests")){
        interests = GlobalVariables.profileBox!.get("interests").split(",").toList();
      }
      if(GlobalVariables.profileBox!.containsKey("professionalBackground")){
        professionalBackground = GlobalVariables.profileBox!.get("professionalBackground").split(",").toList();
      }
      if(GlobalVariables.profileBox!.containsKey("locations")){
        locations = GlobalVariables.profileBox!.get("locations").split(",").toList();
      }
      if(GlobalVariables.profileBox!.containsKey("eventPreferences")){
        eventPreferences = GlobalVariables.profileBox!.get("eventPreferences").split(",").toList();
      }
      if(GlobalVariables.profileBox!.containsKey("socialPreferences")){
        socialPreferences = GlobalVariables.profileBox!.get("socialPreferences").split(",").toList();
      }
      if(GlobalVariables.profileBox!.containsKey("others")){
        others = GlobalVariables.profileBox!.get("others").split(",").toList();
      }
      if(GlobalVariables.profileBox!.containsKey("profileKeywords")){
        profileList = GlobalVariables.profileBox!.get("profileKeywords").split(",").toList();
      }
    });
    /*textEditController.addListener(() {
      classifyWords(textEditController.text);
    });*/
  }

  Future<void> classifyWords(String text) async {
    /*List<String> otherKeywords = ["Miscellaneous", "Other", "roof", "grass"];

    List<String> interestKeywords = jsonData!['interests'] ?? [];
    List<String> professionalKeywords = jsonData!['professional_background'] ?? [];
    List<String> locationKeywords = jsonData!['locations'] ?? [];
    List<String> eventPreferenceKeywords = jsonData!['event_preferences'] ?? [];
    List<String> socialPreferenceKeywords = jsonData!['social_preferences'] ?? [];*/


    List<String> words = text.split(' ');

    // Create a list of Part objects from the strings
    final promptParts = [
      Content.text(
          "Given a short paragraph having information about the user, give output in JSON format containing:"),

      Content.text(
          "Basic Information: User ID, name, age, gender, location."),
      Content.text("Interests: Extract a concise user interests in list."),
      Content.text(
          "Professional Background: Extract a concise user professional background in list."),
      Content.text(
          "Event Preferences: Extract a concise user event preferences in list."),
      Content.text(
          "Social Preferences: Extract a concise user social preferences in list."),
      Content.text(
          "Notification Preferences: Notification settings, preferences, etc in list."),
      Content.text(
          "Behavioral Data: User behavior, preferences, etc in list."),
      Content.text("User Information: $text"),
      Content.text(
          "Output shall only be a JSON string in expected format, no explanations needed.")
    ];

    // Pass the list of Part objects to Content.multi
    final response = await model.generateContent(promptParts);
    log(response.text ?? 'no response');
    final UserProfile profilemodel =UserProfile.fromJson(jsonDecode(response.text ?? ''));
    //profileModel.parseJson(response.text ?? '');

    log("Interest: ${profilemodel.interests}");
    log("Professional Background: ${profilemodel.professionalBackground}");
    log("Location: ${profilemodel.basicInformation.location}");
    log("Event preferences: ${profilemodel.eventPreferences}");
    log("Social preferences: ${profilemodel.socialPreferences}");

    List<String> expandedInterestKeywords =
    expandKeywords(profilemodel.interests);
    List<String> expandedProfessionalKeywords =
    expandKeywords(profilemodel.professionalBackground);
    List<String> expandedLocationKeywords =
    expandKeywords([profilemodel.basicInformation.location]);
    List<String> expandedEventPreferenceKeywords =
    expandKeywords(profilemodel.eventPreferences);
    List<String> expandedSocialPreferenceKeywords =
    expandKeywords(profilemodel.socialPreferences);

    List<String> otherKeywords = expandKeywords(profilemodel.behavioralData);


    setState(() {
      interests.clear();
      professionalBackground.clear();
      locations.clear();
      eventPreferences.clear();
      socialPreferences.clear();
      others.clear();

      for (var word in words) {
        // Convert word to lowercase for case-insensitive comparison
        String lowercaseWord = word.toLowerCase();

        // Check for interests
        for (String keyword in expandedInterestKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!interests.contains(word)) {
              interests.add(keyword);
            }
            break;
          }
        }

// Check for professional background
        for (String keyword in expandedProfessionalKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!professionalBackground.contains(word)) {
              professionalBackground.add(keyword);
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

// Check for event preferences
        for (String keyword in expandedEventPreferenceKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!eventPreferences.contains(word)) {
              eventPreferences.add(keyword);
            }
            break;
          }
        }

// Check for social preferences
        for (String keyword in expandedSocialPreferenceKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!socialPreferences.contains(word)) {
              socialPreferences.add(keyword);
            }
            break;
          }
        }

// Check for others
        for (String keyword in otherKeywords) {
          if (isSimilar(keyword, lowercaseWord)) {
            if (!others.contains(word)) {
              others.add(keyword);
            }
            break;
          }
        }
      }
      profileList.clear();
      profileList.addAll(interests);
      profileList.addAll(professionalBackground);
      profileList.addAll(locations);
      profileList.addAll(eventPreferences);
      profileList.addAll(socialPreferences);
      profileList.addAll(others);
      print(profileList);
      //save to hive
      GlobalVariables.profileBox?.put("profileDetails", textEditController.text);
      GlobalVariables.profileBox?.put("interests", interests.join(","));
      GlobalVariables.profileBox?.put("professionalBackground", professionalBackground.join(","));
      GlobalVariables.profileBox?.put("locations", locations.join(","));
      GlobalVariables.profileBox?.put("eventPreferences", eventPreferences.join(","));
      GlobalVariables.profileBox?.put("socialPreferences", socialPreferences.join(","));
      GlobalVariables.profileBox?.put("others", others.join(","));
      GlobalVariables.profileBox?.put("profileKeywords", profileList.join(","));
    });
  }

  bool isSimilar(String keyword, String userInput) {
    // Convert both the keyword and user input to lowercase for case-insensitive comparison
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

  @override
  Widget build(BuildContext context) {
    final _stringTagInterestController = StringTagController();
    final _stringTagProfessionalBackgroundController = StringTagController();
    final _stringTagLocationController = StringTagController();
    final _stringTagEventPreferencesController = StringTagController();
    final _stringTagSocialPreferencesController = StringTagController();
    final _stringTagOthersController = StringTagController();

    return Scaffold(
      backgroundColor: context.theme.primaryColorLight,
      appBar: AppBarMain(title: "Profile".tr,context: context),
      body: SafeArea(
        child: Column(
          children: [
            vSpacer20(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: cLight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                AssetConstants.imageProfileHamza,
                                height: 205,
                              ),
                            ),
                          ),
                          ButtonOnlyCircleIcon(
                            iconData: Icons.add_photo_alternate_outlined,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const TextAutoMetropolis("Hamza"),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          TextFieldView(
                            controller: textEditController,
                            hint: "Use AI Chat to fill your profile".tr,
                            inputType: TextInputType.text,
                            maxLines: 3,
                            /*onTextChange: (string) {
                              classifyWords(string);
                            },*/
                            onTextcomplete: (){
                              classifyWords(textEditController.text);
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, bottom: 2),
                            child: ButtonOnlyCircleIcon(
                              iconData: Icons.mic_none_rounded,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CreateEventScreen()));
                              },
                            ),
                          ),
                        ],
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueInterest,
                        onChange: (value) {
                          setState(() {
                            _switchValueInterest = value;
                          });
                        },
                        titleText: "Interest".tr,
                        stringTagController: _stringTagInterestController,
                        distanceToField: _distanceToField,
                        text1: interests.isNotEmpty ? interests[0] : '',
                        text2: interests.length > 1 ? interests[1] : '',
                        text3: interests.length > 2 ? interests[2] : '',
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueProfessionalBackground,
                        onChange: (value) {
                          setState(() {
                            _switchValueProfessionalBackground = value;
                          });
                        },
                        titleText: "Professional Background".tr,
                        stringTagController:
                            _stringTagProfessionalBackgroundController,
                        distanceToField: _distanceToField,
                        text1: professionalBackground.isNotEmpty
                            ? professionalBackground[0]
                            : '',
                        text2: professionalBackground.length > 1
                            ? professionalBackground[1]
                            : '',
                        text3: professionalBackground.length > 2
                            ? professionalBackground[2]
                            : '',
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
                        switchValue: _switchValueEventPreferences,
                        onChange: (value) {
                          setState(() {
                            _switchValueEventPreferences = value;
                          });
                        },
                        titleText: "Event Preferences".tr,
                        stringTagController: _stringTagEventPreferencesController,
                        distanceToField: _distanceToField,
                        text1: eventPreferences.isNotEmpty
                            ? eventPreferences[0]
                            : '',
                        text2: eventPreferences.length > 1
                            ? eventPreferences[1]
                            : '',
                        text3: eventPreferences.length > 2
                            ? eventPreferences[2]
                            : '',
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueSocialPreferences,
                        onChange: (value) {
                          setState(() {
                            _switchValueSocialPreferences = value;
                          });
                        },
                        titleText: "Social Preferences".tr,
                        stringTagController:
                            _stringTagSocialPreferencesController,
                        distanceToField: _distanceToField,
                        text1: socialPreferences.isNotEmpty
                            ? socialPreferences[0]
                            : '',
                        text2: socialPreferences.length > 1
                            ? socialPreferences[1]
                            : '',
                        text3: socialPreferences.length > 2
                            ? socialPreferences[2]
                            : '',
                      ),
                      vSpacer20(),
                      TextFieldCustomTagsWithManualAddText(
                        switchValue: _switchValueOthers,
                        onChange: (value) {
                          setState(() {
                            _switchValueOthers = value;
                          });
                        },
                        titleText: "Others".tr,
                        stringTagController: _stringTagOthersController,
                        distanceToField: _distanceToField,
                        text1: others.isNotEmpty ? others[0] : '',
                        text2: others.length > 1 ? others[1] : '',
                        text3: others.length > 2 ? others[2] : '',
                      ),
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

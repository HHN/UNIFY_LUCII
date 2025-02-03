import 'dart:convert';

class EventInfo {
  final String eventName;
  final String description;
  final String location;
  final List<String> tagsKeywords;
  final String skillLevel;
  final String eventType;
  final String eventCategory;

  EventInfo({
    required this.eventName,
    required this.description,
    required this.location,
    required this.tagsKeywords,
    required this.skillLevel,
    required this.eventType,
    required this.eventCategory,
  });

  // Factory method to create an Event instance from JSON
  factory EventInfo.fromJson(Map<String, dynamic> json) {
    return EventInfo(
      eventName: json['Event Name'],
      description: json['Description'],
      location: json['Location'],
      tagsKeywords: List<String>.from(json['Tags/Keywords']),
      eventCategory: json['Event Category'],
      eventType: json['Event Type'],
      skillLevel: json['Skill Level'],
    );
  }

  factory EventInfo.parsejson(String responseBody) {
    var res = responseBody.split("```json")[1].split("```")[0];
    final parsed = json.decode(res);
    return EventInfo.fromJson(parsed);
  }
  // Method to convert an Event instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'Event Name': eventName,
      'Description': description,
      'Location': location,
      'Tags/Keywords': tagsKeywords,
    };
  }
}
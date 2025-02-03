class UserProfile {
  final BasicInformation basicInformation;
  final List<String> interests;
  final List<String> professionalBackground;
  final List<String> eventPreferences;
  final List<String> socialPreferences;
  final List<String> notificationPreferences;
  final List<String> behavioralData;

  UserProfile({
    required this.basicInformation,
    required this.interests,
    required this.professionalBackground,
    required this.eventPreferences,
    required this.socialPreferences,
    required this.notificationPreferences,
    required this.behavioralData,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      basicInformation: BasicInformation.fromJson(json['Basic Information']),
      interests: List<String>.from(json['Interests']),
      professionalBackground: List<String>.from(json['Professional Background']),
      eventPreferences: List<String>.from(json['Event Preferences']),
      socialPreferences: List<String>.from(json['Social Preferences']),
      notificationPreferences: List<String>.from(json['Notification Preferences']),
      behavioralData: List<String>.from(json['Behavioral Data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Basic Information': basicInformation.toJson(),
      'Interests': interests,
      'Professional Background': professionalBackground,
      'Event Preferences': eventPreferences,
      'Social Preferences': socialPreferences,
      'Notification Preferences': notificationPreferences,
      'Behavioral Data': behavioralData,
    };
  }
}

class BasicInformation {
  final String? userId;
  final String name;
  final int? age;
  final String? gender;
  final String location;

  BasicInformation({
    required this.userId,
    required this.name,
    required this.age,
    required this.gender,
    required this.location,
  });

  factory BasicInformation.fromJson(Map<String, dynamic> json) {
    return BasicInformation(
      userId: json['User ID'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'User ID': userId,
      'name': name,
      'age': age,
      'gender': gender,
      'location': location,
    };
  }
}
import 'dart:convert';
class Event {
  EventBody body;
  String roomId;
  String sender;

  Event({
    required this.body,
    required this.roomId,
    required this.sender,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      body: EventBody.fromJson(json['body']),
      roomId: json['room_id'] as String,
      sender: json['sender'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'body': body.toJson(),
      'room_id': roomId,
      'sender': sender,
    };
  }
}

List<Event> parseEvents(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}

class EventBody {
  String eventName;
  String eventDetails;
  List<String> keywords;
  String eventId;

  EventBody({
    required this.eventName,
    required this.eventDetails,
    required this.keywords,
    required this.eventId,
  });

  factory EventBody.fromJson(String body) {
    final Map<String, dynamic> json = parseBody(body);
    return EventBody(
      eventName: json['Event Name'] ?? "",
      eventDetails: json['Event Details'] ?? "",
      keywords: List<String>.from(json['Keywords'] ?? []) ,
      eventId: json['Event ID'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Event Name': eventName,
      'Event Details': eventDetails,
      'Keywords': keywords,
      'Event ID': eventId,
    };
  }

  static Map<String, dynamic> parseBody(String body) {
    final lines = body.split('\n');
    final Map<String, dynamic> json = {};
    if(lines[0].contains("Event Name")){
      for (var line in lines) {
        final splitLine = line.split(': ');
        final key = splitLine[0].trim();
        final value = splitLine[1].trim();
        if (key == 'Keywords') {
          if(value.isNotEmpty){
            json[key] = value.split(',').map((e) => e.substring(0, e.length )).toList();
          }
        } else {
          json[key] = value;
        }
      }
    } else {

    }
    return json;
  }
}
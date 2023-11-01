class Message {
  String? name;
  String message;
  String sentByMe;
  bool notification;

  Message(
      {this.name,
      required this.message,
      required this.sentByMe,
      required this.notification});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      name: json["name"],
      message: json["message"],
      sentByMe: json["sentByMe"],
      notification: json["notification"],
    );
  }
}

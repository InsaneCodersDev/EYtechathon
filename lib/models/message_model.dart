class Message {
  bool response;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message({
    this.response,
    this.time,
    this.text,
    this.unread,
  });
}

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [];

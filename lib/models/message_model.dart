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
List<Message> messages = [
  Message(
    response: true,
    time: '4:30 PM',
    text:
        "Hello, \nI am Immunnobot\nYour Assistant in this pandemic.\nI can resolve all your queries and give you tips. \nTell me how can I help you?",
  )
];

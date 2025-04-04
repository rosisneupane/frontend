class Message {
  final String id;
  final String conversationId;
  final String content;
  final DateTime timestamp;
  final Sender sender;

  Message({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.timestamp,
    required this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversation_id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      sender: Sender.fromJson(json['sender']),
    );
  }
}

class Sender {
  final String id;
  final String username;
  final String email;

  Sender({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }
}

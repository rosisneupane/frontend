import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    // Starting conversation
    messages.add({"fromBot": true, "text": "Hello! I am EaseTalk. How can I assist you today?"});
  }

  void handleSubmission(String text) {
    setState(() {
      messages.add({"fromBot": false, "text": text});
      _controller.clear();

      if (text.toLowerCase().contains("distressed")) {
        messages.add({
          "fromBot": true,
          "text": "It sounds like you're having a tough time. Have you tried using our relaxation techniques in the Leisure domain?"
        });
      } else if (text.toLowerCase().contains("hurt myself")) {
        messages.add({
          "fromBot": true,
          "text": "I'm really concerned about what you're feeling. It’s important to talk to someone who can provide immediate help."
        });
        showDistressAlert(context);
      } else {
        messages.add({"fromBot": true, "text": "I'm here to listen. Tell me more about how you're feeling."});
      }
    });
  }

  void showDistressAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Urgent Alert'),
          content: Text('A distress message has been sent to your guardian. Help is on the way.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot Support'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['fromBot'] ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: message['fromBot'] ? Colors.blue[100] : Colors.green[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(message['text']),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Send a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: handleSubmission,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => handleSubmission(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

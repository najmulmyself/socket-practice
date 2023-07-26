import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

void main() => runApp(const SocketIOChatApp());

class SocketIOChatApp extends StatelessWidget {
  const SocketIOChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  String? _username; // Store the username here
  io.Socket? socket;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Your Username'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _connectToSocket();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _connectToSocket() {
    print("connect func");
    socket = io.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket!.on('connect', (_) {
      print('Connected');
      if (_username != null) {
        socket!.emit('set_username', _username);
      }
    });

    socket!.on('chat_message', (data) {
      setState(() {
        _messages.add(data['message']);
      });
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      socket!.emit('chat_message', _messageController.text);
      _messageController
          .clear(); // Clear the text field after sending the message
      print("message sent");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket.IO Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Enter your message',
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          ElevatedButton(
            onPressed: _sendMessage,
            child: const Text('Send Message'),
          ),
        ],
      ),
    );
  }
}

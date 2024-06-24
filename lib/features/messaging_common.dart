import 'package:clubhub/features/message_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:clubhub/models/message.dart';
import 'package:clubhub/constants/colors.dart';

class MessagingScreen extends StatefulWidget {
  final String clubId;

  static const String routeName = '/chat';

  MessagingScreen({
    Key? key,
    required this.clubId,

  }) : super(key: key);

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final MessageServices _messageServices = MessageServices();
  late Future<List<Message>> _messagesFuture;
  

  @override
  void initState() {
    super.initState();
    _messagesFuture = _messageServices.fetchMessages(
      context: context,
      clubId: widget.clubId,
    );
  }

    void _sendMessage(String name) {
    if (_messageController.text.trim().isEmpty) return;

    _messageServices.sendMessage(
      context: context,
      name: name,
      clubId: widget.clubId,
      message: _messageController.text.trim(),
    );

    setState(() {
      _messagesFuture = _messageServices.fetchMessages(
        context: context,
        clubId: widget.clubId,
      );
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider=Provider.of<UserProvider>(context,listen:false);
    return Scaffold(
     
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: _messagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching messages'));
                } else {
                  final messages = snapshot.data ?? [];
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Text(message.name),
                        subtitle: Text(message.message),
                        trailing: Text(
                          message.createdAt.toLocal().toString().split(' ')[1],
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  color: AppColors.primary,
                  onPressed: () {_sendMessage( userProvider.user.name);},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

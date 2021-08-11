import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key}) : super(key: key);

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() {
    print('Sending message');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Type your message...',
                labelStyle: TextStyle(
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(86, 13, 13, 0.7),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    message = newValue;
                  });
                } else {
                  setState(() {
                    message = '';
                  });
                }
              },
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

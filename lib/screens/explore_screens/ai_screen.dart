import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AIScreen extends StatefulWidget {
  const AIScreen({Key? key}) : super(key: key);

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  ChatUser myself = ChatUser(id: '1', firstName: "Karan");
  ChatUser bot = ChatUser(id: '2', firstName: "Gemini");

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = []; 

  final url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCqTKYLAt6qvt1ZTzYT17ySqX2Ei-jNbrk";

  final header = {
    'Content-Type': 'application/json',
  };

  getdata(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);
    setState(() {});

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    await http
        .post(Uri.parse(url), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var res = jsonDecode(value.body);
        print(res['candidates'][0]['content']['parts'][0]['text']);

        ChatMessage m1 = ChatMessage(
            user: bot,
            createdAt: DateTime.now(),
            text: res['candidates'][0]['content']['parts'][0]['text']);

        allMessages.insert(0, m1);
        
      } else {
        print("error");
      }
    });
    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 246, 249),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 243, 246, 249),
          elevation: 0,
          title: Text(
            "Chat with AI",
            style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.blue[900]),
          ),
        ),
        body: DashChat(
          typingUsers: typing,
          currentUser: myself,
          onSend: (ChatMessage m) {
            getdata(m);
          },
          messages: allMessages,
        ));
  }
}

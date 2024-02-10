// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:myfit/bloc/chat_bloc.dart';
import 'package:myfit/models/chat_message_models.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => AIScreenState();
}

class AIScreenState extends State<AIScreen> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  String userName = "";
    User? user = FirebaseAuth.instance.currentUser;

    void fetchUser() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .snapshots()
          .listen((DocumentSnapshot userDoc) {
        setState(() {
          userName = userDoc['name']; 
        });
      });
    }

    String caps(String username) {
      return username[0].toUpperCase()+username.substring(1);
    }

  @override
  void initState() {
    // TODO: implement initState
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 246, 249)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chat with AI",
                            style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue[900]),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 12, left: 16, right: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(
                                          messages[index].role == "user"
                                              ? 0xffd8e8ff
                                              : 0xffE0F4FF)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messages[index].role == "user"
                                            ? caps(userName)
                                            : "Gemini",
                                        style: GoogleFonts.poppins(
                                            color:
                                                messages[index].role == "user"
                                                    ? Colors.blue[900]
                                                    : Colors.blue[800],
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(messages[index].parts.first.text,
                                          style: messages[index].role == "user"
                                              ? GoogleFonts.poppins(
                                                  height: 1.2,
                                                  color:Color(0xff39A7FF),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18)
                                              : GoogleFonts.poppins(
                                                  // height: 1.2,
                                                  color: Color(0xff1176B87),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18)),
                                    ],
                                  ));
                            })),
                    if (chatBloc.generating)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Loading...", style: GoogleFonts.poppins(
                                            color:
                                                 Colors.blue[900],
                                                 
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20))
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: textEditingController,
                            style:GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[600]),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                fillColor: Colors.white,
                                hintText: "Your query goes here...",
                                hintStyle:
                                    GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[600]),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color:
                                            Colors.blue))),
                          )),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGenerateNewTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              foregroundColor: Colors.white,
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue[900],
                                child: Center(
                                  child: Icon(Icons.send, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}

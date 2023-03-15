import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controllers/question_provider.dart';
import '../core/constants.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final TextEditingController questionController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  scrollAnimate() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1),
          curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppConstants.logo),
        ),
        title: const Text("ChatGPT"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          var provider = ref.watch(questionProvider);
          List<dynamic> chatMessages = provider.chatMessages;
          bool isTyping = provider.isTyping;

          return Column(children: [
            Flexible(
              child: ListView.builder(
                  itemCount: chatMessages.length,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatMessages[index]["msg"].toString(),
                      chatIndex: int.parse(
                          chatMessages[index]["chatIndex"].toString()),
                    );
                  }),
            ),
            if (isTyping) ...[
              const SizedBox(
                height: 15,
              ),
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: questionController,
                        decoration: const InputDecoration.collapsed(
                            hintText: "How can I help you",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          ref.read(questionProvider).chatMessages.add({
                            "chatIndex": 0,
                            "msg": questionController.text,
                          });
                          scrollAnimate();
                          await ref
                              .read(questionProvider)
                              .postQuestion(questionController.text);
                          questionController.clear();
                          scrollAnimate();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}

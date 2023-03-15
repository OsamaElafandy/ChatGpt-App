import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'text_widget.dart';

class ChatWidget extends StatelessWidget {
  final String msg;
  final int chatIndex;
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: chatIndex == 0
                // Me Widget
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          child: MeTextWidget(
                        label: msg,
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        AppConstants.userImage,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox.shrink()
                    ],
                  )
                // Bot Widget
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppConstants.botImage,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TypewriterAnimatedText(msg,
                                  cursor: ".",
                                  speed: const Duration(milliseconds: 20)),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.thumb_down_alt_outlined,
                              color: Colors.white)
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

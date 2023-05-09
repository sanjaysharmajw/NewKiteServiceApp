import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'Messages.dart';
import 'UpperCaseTextFormatter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatBot(),
    );
  }
}

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<ChatBot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const SizedBox(height: 25),
                 InkWell( onTap: (){
                   Get.back();
                 },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
                 const SizedBox(height: 25),
                 const MyText(text: 'Chat', fontName: 'Gilroy',
                     fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
                 const SizedBox(height: 25),
               ],
             ),
           ),
            const Divider(
              color: appBlack,
            ),
            Expanded(child: MessagesScreen(messages: messages)),
            const SizedBox(
              width: 5,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: appBlack
                      ),
                      child: TextField(
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        controller: _controller,
                        style: const TextStyle(color: appWhiteColor,fontFamily: 'Gilroy'),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: appWhiteColor),
                          hintText: 'Enter Something',
                          contentPadding: EdgeInsets.only(right: 20,left: 20),
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: appBlack
                    ),
                    child: IconButton(
                        onPressed: () {
                          sendMessage(_controller.text);
                          _controller.clear();
                        },
                        icon: const Icon(Icons.send,color: appWhiteColor)),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      debugPrint('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }
  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}




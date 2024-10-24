import 'package:flutter/material.dart';
import 'package:star_talk_ai/Models/chat_models.dart';
import 'package:star_talk_ai/Repository/chat_http_repo.dart';
import 'package:star_talk_ai/Screens/Components/Message_Bubble.dart';
import 'package:star_talk_ai/Screens/Image_Generator_screen.dart';
import 'package:star_talk_ai/Utiles/enums.dart';
import 'package:star_talk_ai/bloc/chat_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  ChatBloc chatBloc = ChatBloc();

  @override
  void initState() {
    super.initState();
    chatBloc = ChatBloc();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ChatBloc(),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case ChatSuccess:
                List<ChatModels> messages = (state as ChatSuccess).messages;
                return Stack(
                  children: [
                    // Background Gradient Container
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withBlue(40),
                            Colors.blue[900]!,
                          ],
                          stops: [0.4, 1.0],
                        ),
                      ),
                    ),
                    // Foreground Column with the input bar
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              ChatModels message = messages[index];
                              bool isUserMessage = message.role == 'user';

                              return MessageBubble(
                                message: message.parts.first.text,
                                isUserMessage: isUserMessage,
                              );
                            },
                          ),
                        ),
                        // Bottom Input Bar Container
                        Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 2, 43, 77),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ImageGeneratorScreen()),
                                  );
                                },
                                child: const Icon(Icons.image,
                                    color: Colors.white, size: 35),
                              ),
                              const SizedBox(width: 20),
                              const Icon(Icons.mic,
                                  color: Colors.white, size: 35),
                              const SizedBox(width: 20),
                              // Text Field
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextFormField(
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Ask me anything...",
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              InkWell(
                                onTap: () {
                                  if (textEditingController.text.isNotEmpty) {
                                    context.read<ChatBloc>().add(ChatGenerate(
                                        textEditingController.text));
                                    textEditingController.clear();
                                  }
                                },
                                child: const Icon(Icons.send,
                                    color: Colors.white, size: 35),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              default:
                return const Center(child: Text('Unhandled status'));
            }
          },
        ),
      ),
    );
  }
}

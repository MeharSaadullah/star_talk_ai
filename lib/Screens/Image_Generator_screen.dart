import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_talk_ai/bloc/bloc/image_generator_bloc.dart';

class ImageGeneratorScreen extends StatefulWidget {
  const ImageGeneratorScreen({super.key});

  @override
  State<ImageGeneratorScreen> createState() => _ImageGeneratorScreenState();
}

class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
  ImageGeneratorBloc imageGeneratorBloc = ImageGeneratorBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    imageGeneratorBloc.add(PromptInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "G E N E R A T E     I M A G E",
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
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
          BlocProvider(
            create: (context) => imageGeneratorBloc,
            child: BlocBuilder<ImageGeneratorBloc, ImageGeneratorState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case PromptGeneratingImageLoadState:
                    return Center(child: CircularProgressIndicator());

                  case PromptGeneratingImageErrorState:
                    return Text(" SOMETHING WENT Wrong");

                  case PromptGeneratingImageSuccessState:
                    final successState =
                        state as PromptGeneratingImageSuccessState;

                    // // Clear the previous cache before displaying the new image
                    // final image = FileImage(successState.file);
                    // image.evict(); // Clear the previous cache

                    return Column(
                      children: [
                        Container(
                          height: 450,
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            image: DecorationImage(
                                image: FileImage(successState.file)),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: textEditingController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Enter Your Prompt Here!",
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            // Add event handling here
                            if (textEditingController.text.isNotEmpty) {
                              imageGeneratorBloc.add(PromptEnterEvent(
                                  promptmessage: textEditingController.text));
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 420,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                "G e n e r a t e ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

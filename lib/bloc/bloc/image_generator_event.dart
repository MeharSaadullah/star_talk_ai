part of 'image_generator_bloc.dart';

@immutable
sealed class ImageGeneratorEvent {}

class PromptInitialEvent extends ImageGeneratorEvent {}

class PromptEnterEvent extends ImageGeneratorEvent {
  final String promptmessage;
  PromptEnterEvent({
    required this.promptmessage,
  });
}

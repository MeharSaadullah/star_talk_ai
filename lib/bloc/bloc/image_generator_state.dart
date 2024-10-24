part of 'image_generator_bloc.dart';

@immutable
sealed class ImageGeneratorState {}

final class ImageGeneratorInitial extends ImageGeneratorState {}

final class PromptGeneratingImageLoadState
    extends ImageGeneratorState {} // for loading

final class PromptGeneratingImageErrorState
    extends ImageGeneratorState {} // for error

final class PromptGeneratingImageSuccessState extends ImageGeneratorState {
  final file;

  PromptGeneratingImageSuccessState(this.file);
}

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:star_talk_ai/Repository/Image_generator_repo.dart';

part 'image_generator_event.dart';
part 'image_generator_state.dart';

class ImageGeneratorBloc
    extends Bloc<ImageGeneratorEvent, ImageGeneratorState> {
  ImageGeneratorBloc() : super(ImageGeneratorInitial()) {
    // on<ImageGeneratorEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<PromptEnterEvent>(promptEnterEvent);
    on<PromptInitialEvent>(promptInitialEvent);
  }

  FutureOr<void> promptEnterEvent(
      PromptEnterEvent event, Emitter<ImageGeneratorState> emit) async {
    emit(PromptGeneratingImageLoadState());
    File? file = await ImageGeneratorRepo.generateImage(event.promptmessage);
    if (file != null) {
      emit(PromptGeneratingImageSuccessState(file));
    } else {
      emit(PromptGeneratingImageErrorState());
    }
  }

  FutureOr<void> promptInitialEvent(
      PromptInitialEvent event, Emitter<ImageGeneratorState> emit) {
    emit(PromptGeneratingImageSuccessState(File(
        '/Users/app/Desktop/flutter_projects/star_talk_ai/assets/imageGenration.jpeg')));
  }
}

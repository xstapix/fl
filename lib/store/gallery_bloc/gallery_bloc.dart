import 'package:flutter_bloc/flutter_bloc.dart';

import './gallery_event.dart';
import 'gallery_state.dart';

import '../../shared/api.dart';

class GalleryBloc extends Bloc<GalleryEvents, GalleryState>{
  GalleryBloc() : super(GalleryInitial()) {
    on<GalleryInitEvent>(_onInit);
  }

  _onInit(GalleryInitEvent event, Emitter<GalleryState> emit) async {
    emit(GalleryLoadingState());

    emit(GalleryLoadedState(event.images));
  }
}
import './gallery_bloc.dart';

abstract class GalleryState {}

class GalleryInitial extends GalleryState {}
class GalleryLoadingState extends GalleryState {}
class GalleryLoadedState extends GalleryState {
 final List images;

  GalleryLoadedState(this.images);
}
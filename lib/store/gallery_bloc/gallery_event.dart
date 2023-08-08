abstract class GalleryEvents {

}

class GalleryInitEvent extends GalleryEvents {
  List images;

  GalleryInitEvent(this.images);
}
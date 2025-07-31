import 'package:flutter/cupertino.dart';

class PhotoUploadController {
  final VoidCallback clearImage; // Callback to clear the image

  PhotoUploadController({
    required this.clearImage,
  });

  void clear() => clearImage(); // Calls the clear function
}

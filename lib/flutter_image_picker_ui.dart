import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

/// A customizable Flutter widget for picking images from camera or gallery.
///
/// This widget provides a UI for users to either take a photo using the device's
/// camera or upload an image from their gallery. It supports custom styling
/// for buttons, text, and icons, and includes a preview of the selected image.
///
/// The widget uses `image_picker` for image selection and `dotted_border`
/// for a visually distinct border.
class PhotoUploadWidget extends StatefulWidget {
  /// Callback function that is called when an image is picked or cleared.
  /// It provides the [File] object of the picked image, or `null` if no image
  /// is picked or if the picked image is cleared.
  final ValueChanged<File?> onImagePicked;

  /// The [ButtonStyle] for the camera button.
  final ButtonStyle cameraBtnDecoration;

  /// The [ButtonStyle] for the gallery button.
  final ButtonStyle galleryBtnDecoration;

  /// The widget to display as the icon for the camera button.
  /// Defaults to a camera icon asset from the package.
  final Widget cameraIcon;

  /// The widget to display as the icon for the gallery button.
  /// Defaults to a gallery icon asset from the package.
  final Widget galleryIcon;

  /// An optional widget to display as the main icon when no image is picked.
  /// If null, a default camera-fill icon is displayed.
  final Widget? icon;

  /// The main title text displayed when no image is picked.
  final String title;

  /// The subtitle text displayed when no image is picked, usually providing
  /// information about allowed file types and sizes.
  final String subtitle;

  /// The [TextStyle] for the [title].
  final TextStyle titleStyle;

  /// The [TextStyle] for the [subtitle].
  final TextStyle subtitleStyle;

  /// The padding around the content of the widget.
  final EdgeInsetsGeometry padding;

  /// Private internal constructor for `PhotoUploadWidget`.
  /// This constructor is used by the factory constructors to initialize
  /// the widget with all its required properties.
  const PhotoUploadWidget._internal({
    super.key,
    required this.onImagePicked,
    required this.title,
    required this.subtitle,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.cameraBtnDecoration,
    required this.galleryBtnDecoration,
    required this.padding,
    required this.cameraIcon,
    required this.galleryIcon,
    this.icon,
  });

  /// Default factory constructor for `PhotoUploadWidget`.
  ///
  /// This constructor provides default values for most parameters, allowing
  /// for quick setup with sensible defaults. It also allows for custom
  /// [TextStyle] for button texts which are then used to create default
  /// [ButtonStyle] if `cameraBtnDecoration` or `galleryBtnDecoration` are not provided.
  factory PhotoUploadWidget({
    Key? key,
    required ValueChanged<File?> onImagePicked,
    String title = 'Take photo or upload',
    String subtitle = 'PNG, JPG, up to 10MB',
    TextStyle titleStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff35403E)),
    TextStyle subtitleStyle = const TextStyle(
        fontSize: 14, color: Color(0x66173d34), fontWeight: FontWeight.w400),
    TextStyle galleryBtnTextStyle = const TextStyle(
        fontWeight: FontWeight.bold, color: Color(0xff35403E), fontSize: 14),
    TextStyle cameraBtnTextStyle = const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
    ButtonStyle? cameraBtnDecoration,
    ButtonStyle? galleryBtnDecoration,
    Widget? cameraIcon,
    Widget? galleryIcon,
    Widget? icon,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20),
  }) {
    // Define default camera button style
    final defaultCameraBtnDecoration = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: const Color(0xff22574A),
      foregroundColor: cameraBtnTextStyle.color,
      textStyle: cameraBtnTextStyle,
    );

    // Define default gallery button style
    final defaultGalleryBtnDecoration = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: const BorderSide(color: Color(0xffCAD7DF), width: 2),
      foregroundColor: galleryBtnTextStyle.color,
      textStyle: galleryBtnTextStyle,
    );

    return PhotoUploadWidget._internal(
      key: key,
      onImagePicked: onImagePicked,
      title: title,
      subtitle: subtitle,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      cameraBtnDecoration: cameraBtnDecoration ?? defaultCameraBtnDecoration,
      galleryBtnDecoration: galleryBtnDecoration ?? defaultGalleryBtnDecoration,
      cameraIcon: cameraIcon ??
          Image.asset(
            "assets/camera_outline.png",
            package: 'flutter_image_picker_ui',
            width: 20,
          ),
      galleryIcon: galleryIcon ??
          Image.asset(
            "assets/gallery_upload.png",
            package: 'flutter_image_picker_ui',
            width: 20,
          ),
      icon: icon,
      padding: padding,
    );
  }

  /// Fully custom constructor for `PhotoUploadWidget`.
  ///
  /// This constructor requires all parameters to be explicitly provided,
  /// offering maximum control over the widget's appearance and behavior.
  const PhotoUploadWidget.custom({
    super.key,
    required this.onImagePicked,
    required this.title,
    required this.subtitle,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.cameraBtnDecoration,
    required this.galleryBtnDecoration,
    required this.cameraIcon,
    required this.galleryIcon,
    required this.padding,
    this.icon,
  });

  @override
  State<PhotoUploadWidget> createState() => _PhotoUploadWidgetState();
}

class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {
  /// The currently picked image file. Null if no image has been picked.
  File? _pickedImage;

  /// Instance of `ImagePicker` used to pick images.
  final ImagePicker _picker = ImagePicker();

  /// A boolean flag to indicate if an image picking operation is currently in progress.
  bool _isPicking = false;

  /// Handles the image picking process from a specified [ImageSource].
  ///
  /// Sets `_isPicking` to true, attempts to pick an image, updates `_pickedImage`,
  /// and calls `widget.onImagePicked`. Ensures `_isPicking` is reset in `finally` block.
  Future<void> _pickImage(ImageSource source) async {
    if (_isPicking) return; // Prevent multiple simultaneous picks

    setState(() {
      _isPicking = true;
      _pickedImage = null; // Clear previous image while picking
    });

    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        final File pickedFile = File(image.path);
        setState(() {
          _pickedImage = pickedFile;
        });
        widget.onImagePicked(_pickedImage);
      } else {
        // User cancelled image picking
        widget.onImagePicked(null);
      }
    } catch (e) {
      // Log the error for debugging purposes. In a real app, consider
      // displaying a user-friendly message (e.g., using a SnackBar).
      debugPrint('Error picking image: $e');
      widget.onImagePicked(null);
    } finally {
      setState(() {
        _isPicking = false;
      });
    }
  }

  /// Clears the currently picked image.
  ///
  /// Sets `_pickedImage` to null and triggers the `onImagePicked` callback
  /// with a null value.
  void _clearImage() {
    setState(() {
      _pickedImage = null;
    });
    widget.onImagePicked(null);
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RectDottedBorderOptions(
        dashPattern: const [6, 6],
        color: Color(0xffCAD7DF),
        strokeWidth: 1.2,
      ),
      child: Stack(
        children: [
          Container(
            padding: widget.padding,
            width: double.infinity, // Ensure it takes full width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display picked image or default icon/text
                if (_pickedImage != null)
                  Image.file(
                    _pickedImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit
                        .cover, // Use BoxFit.cover for better image scaling
                  )
                else ...[
                  // Default icon or custom icon when no image is picked
                  if (widget.icon != null)
                    widget.icon!
                  else
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0x4dcad7df),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/camera_fill.png",
                        height: 30,
                        width: 30,
                        package: 'flutter_image_picker_ui',
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(widget.title, style: widget.titleStyle),
                  const SizedBox(height: 4),
                  Text(widget.subtitle, style: widget.subtitleStyle),
                ],
                const SizedBox(height: 20),
                // Show CircularProgressIndicator while picking
                _isPicking
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _pickImage(ImageSource.camera),
                              icon: widget.cameraIcon,
                              label: const Text('Camera'),
                              style: widget.cameraBtnDecoration,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              icon: widget.galleryIcon,
                              label: const Text('Upload'),
                              style: widget.galleryBtnDecoration,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          // Clear image button
          if (_pickedImage != null)
            Positioned(
              top: 6,
              right: 6,
              child: Material(
                color: Colors.transparent, // Make Material transparent
                child: InkWell(
                  onTap: _clearImage,
                  borderRadius:
                      BorderRadius.circular(20), // Match container's radius
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueGrey.withAlpha(30),
                      border: Border.all(color: Colors.blueGrey, width: 2),
                    ),
                    child: const Icon(Icons.close,
                        size: 18, color: Colors.blueGrey),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

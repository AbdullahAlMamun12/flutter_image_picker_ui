import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_picker_ui/controller.dart';
import 'package:flutter_image_picker_ui/flutter_image_picker_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      theme: _buildAppTheme(),
      title: 'Photo Upload Widget Example',
      debugShowCheckedModeBanner: false,
      home: const PhotoUploadExampleScreen(),
    );
  }

  /// Builds the theme data for the app.
  ThemeData _buildAppTheme() {
    return ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: const Color(0xffF0F4F3),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff22574A),
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 22,
        ),
      ),
    );
  }
}

// Global key for the ScaffoldMessengerState to show SnackBars.
final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();

/// Displays a SnackBar with the provided message.
void _showSnackBar(String message) {
  _scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
}

class PhotoUploadExampleScreen extends StatefulWidget {
  const PhotoUploadExampleScreen({super.key});

  @override
  State<PhotoUploadExampleScreen> createState() =>
      _PhotoUploadExampleScreenState();
}

class _PhotoUploadExampleScreenState extends State<PhotoUploadExampleScreen> {
  File? _defaultWidgetImage;
  File? _customWidgetImage;
  PhotoUploadController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker UI Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Default Usage'),
            const SizedBox(height: 8),
            const Text(
              'This example shows the widget with its default styling. Just provide the onImagePicked callback.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildDefaultWidget(),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            _buildClearImageButton(),
            const Divider(height: 60, thickness: 1),
            _buildSectionTitle('Custom Usage'),
            const SizedBox(height: 8),
            const Text(
              'This example uses the PhotoUploadWidget.custom constructor to override styles, icons, and text.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildCustomWidget(),
            const SizedBox(height: 16),
            _buildFeedbackText('Custom widget image path:', _customWidgetImage),
          ],
        ),
      ),
    );
  }

  /// Builds a section title widget.
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  /// Builds the default widget with the callback to handle image picking.
  Widget _buildDefaultWidget() {
    return PhotoUploadWidget(
      onCreate: (controller) => _controller = controller,
      onImagePicked: (File? image) {
        setState(() {
          _defaultWidgetImage = image;
        });
        _showSnackBar(image != null
            ? 'Default Widget: Image picked!'
            : 'Default Widget: Image selection cleared or cancelled.');
      },
    );
  }

  /// Builds a custom widget with custom styles, icons, and text.
  Widget _buildCustomWidget() {
    return PhotoUploadWidget.custom(
      onImagePicked: (File? image) {
        setState(() {
          _customWidgetImage = image;
        });
        _showSnackBar(image != null
            ? 'Custom Widget: Image picked!'
            : 'Custom Widget: Image cleared or cancelled.');
      },
      icon: _buildCustomIcon(),
      title: 'Upload your profile photo',
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      subtitle: 'PNG or JPG, up to 5MB',
      subtitleStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      padding: const EdgeInsets.all(24),
      cameraBtnDecoration: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      galleryBtnDecoration: OutlinedButton.styleFrom(
        foregroundColor: Colors.green.shade700,
        side: BorderSide(color: Colors.green.shade700, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      cameraIcon: const Icon(Icons.photo_camera, size: 20),
      galleryIcon: const Icon(Icons.photo_library, size: 20),
    );
  }

  /// Builds a custom icon for the PhotoUploadWidget.
  Widget _buildCustomIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blueGrey[50],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: const Icon(
        Icons.add_a_photo_outlined,
        size: 32,
        color: Colors.blueGrey,
      ),
    );
  }

  /// A helper method to build the feedback text for the selected image.
  Widget _buildFeedbackText(String label, File? imageFile) {
    return Text(
      imageFile == null
          ? 'No image selected.'
          : '$label ${imageFile.path.split('/').last}',
      style: const TextStyle(fontSize: 12, color: Colors.blueGrey, fontStyle: FontStyle.italic),
      textAlign: TextAlign.center,
    );
  }

  /// Builds the button to clear the image preview.
  Widget _buildClearImageButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        _controller?.clear();
      },
      child: const Text('Clear Image Preview'),
    );
  }
}
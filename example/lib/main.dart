import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_picker_ui/flutter_image_picker_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The scaffoldMessengerKey is used to show SnackBars.
      scaffoldMessengerKey: _scaffoldMessengerKey,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xffF0F4F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff22574A),
          foregroundColor: Colors.white,
        ),
        // Define a consistent text theme for section headers.
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 22,
          ),
        ),
      ),
      title: 'Photo Upload Widget Example',
      debugShowCheckedModeBanner: false,
      home: const PhotoUploadExampleScreen(),
    );
  }
}

// A global key for the ScaffoldMessengerState to show SnackBars.
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
  State<PhotoUploadExampleScreen> createState() => _PhotoUploadExampleScreenState();
}

class _PhotoUploadExampleScreenState extends State<PhotoUploadExampleScreen> {
  // To hold the image picked by the 'Default Widget Usage' PhotoUploadWidget.
  File? _defaultWidgetImage;
  // To hold the image picked by the 'Custom Widget Usage' PhotoUploadWidget.
  File? _customWidgetImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker UI Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children to fill width
          children: [
            // --- 1. Default Widget Usage Section ---
            Text(
              'Default Usage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'This example shows the widget with its default styling. Just provide the onImagePicked callback.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            PhotoUploadWidget(
              onImagePicked: (File? image) {
                setState(() {
                  _defaultWidgetImage = image;
                });
                if (image != null) {
                  _showSnackBar('Default Widget: Image picked!');
                } else {
                  _showSnackBar('Default Widget: Image selection cleared or cancelled.');
                }
              },
            ),
            const SizedBox(height: 16),
            _buildFeedbackText(
              'Default widget image path:',
              _defaultWidgetImage,
            ),

            const Divider(height: 60, thickness: 1),

            // --- 2. Custom Widget Usage Section ---
            Text(
              'Custom Usage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'This example uses the PhotoUploadWidget.custom constructor to override styles, icons, and text.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            PhotoUploadWidget.custom(
              onImagePicked: (File? image) {
                setState(() {
                  _customWidgetImage = image;
                });
                if (image != null) {
                  _showSnackBar('Custom Widget: Image picked!');
                } else {
                  _showSnackBar('Custom Widget: Image cleared or cancelled.');
                }
              },
              // A custom icon when no image is selected.
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blueGrey[50],
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: const Icon(Icons.add_a_photo_outlined, size: 32, color: Colors.blueGrey),
              ),
              title: 'Upload your profile photo',
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              subtitle: 'PNG or JPG, up to 5MB',
              subtitleStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              padding: const EdgeInsets.all(24),
              // Custom button styles.
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
              // Custom icons for buttons.
              cameraIcon: const Icon(Icons.photo_camera, size: 20),
              galleryIcon: const Icon(Icons.photo_library, size: 20),
            ),
            const SizedBox(height: 16),
            _buildFeedbackText(
              'Custom widget image path:',
              _customWidgetImage,
            ),
          ],
        ),
      ),
    );
  }

  /// A helper method to build the feedback text for the selected image.
  Widget _buildFeedbackText(String label, File? imageFile) {
    return Text(
      imageFile == null
          ? 'No image selected.'
      // Displaying only the last part of the path for cleaner UI.
          : '$label ${imageFile.path.split('/').last}',
      style: const TextStyle(fontSize: 12, color: Colors.blueGrey, fontStyle: FontStyle.italic),
      textAlign: TextAlign.center,
    );
  }
}
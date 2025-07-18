import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_picker_ui/flutter_image_picker_ui.dart'; // Import your package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // To hold the image picked by the 'Default Widget Usage' PhotoUploadWidget
  File? _defaultWidgetImage;
  // To hold the image picked by the 'Custom Widget Usage' PhotoUploadWidget
  File? _customWidgetImage;

  // GlobalKey for ScaffoldMessengerState to show SnackBars
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Displays a SnackBar with the provided message.
  void _showSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Assign the GlobalKey to scaffoldMessengerKey for showing SnackBars
      scaffoldMessengerKey: _scaffoldMessengerKey,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xffF0F4F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff22574A), // Consistent AppBar color
          foregroundColor: Colors.white, // Text color for AppBar
        ),
      ),
      title: 'Photo Upload Widget Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Image Picker UI Demo')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Default Widget Usage Section ---
              Text(
                'Default Widget Usage:',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
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
                    _showSnackBar(
                      'Default Widget: Image cleared or cancelled.',
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              // Display feedback for the default widget's selection
              Text(
                _defaultWidgetImage == null
                    ? 'No image selected for default widget.'
                    : 'Default widget image path: ${_defaultWidgetImage!.path}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 40), // More space between sections
              // --- Custom Widget Usage Section ---
              Text(
                'Custom Widget Usage:',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
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
                icon: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blueGrey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 32,
                    color: Color(0xFF8B949B),
                  ),
                ),
                title: 'Upload your profile photo',
                titleStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                subtitle: 'PNG, JPG — max 5MB',
                subtitleStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                cameraBtnDecoration: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
                galleryBtnDecoration: OutlinedButton.styleFrom(
                  foregroundColor: Colors.green.shade700,
                  side: BorderSide(
                    color: Colors.green.shade700,
                    width: 2,
                  ), // Added width for consistency
                ),
                cameraIcon: const Icon(
                  Icons.photo_camera,
                  size: 20,
                ), // Added size for consistency
                galleryIcon: const Icon(
                  Icons.photo_library_outlined,
                  size: 20,
                ), // Added size for consistency
              ),
              const SizedBox(height: 16),
              // Display feedback for the custom widget's selection
              Text(
                _customWidgetImage == null
                    ? 'No image selected for custom widget.'
                    : 'Custom widget image path: ${_customWidgetImage!.path}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

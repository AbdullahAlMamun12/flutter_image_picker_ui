# 📸 flutter\_image\_picker\_ui

A modern and customizable image picker UI for Flutter, built on top of the popular `image_picker` plugin.

This widget provides a clean, user-friendly interface for selecting images from the camera or gallery — with support for previews, icons, and styling options.

---

## ✨ Features

* Pick image from camera or gallery
* Show image preview with clear (X) button
* Fully customizable styles, icons, and text
* Dotted border with optional icon or title
* Designed to be **developer-friendly**

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_image_picker_ui: 1.0.0 # or use the latest version
```

Run:

```bash
flutter pub get
```

---

## 📦 Assets Required

Make sure to include these in your `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/camera_fill.png
    - assets/camera_outline.png
    - assets/gallery_upload.png
```

---

## 🧪 Example Usage (Default)

```dart
PhotoUploadWidget(
  onImagePicked: (File? image) {
    if (image != null) {
      print("Image picked: \${image.path}");
    } else {
      print("Image cleared");
    }
  },
)
```

You can optionally customize the button text styles, icons, and paddings through the default constructor.

---

## 🎨 Fully Custom Widget Example

```dart
PhotoUploadWidget.custom(
  onImagePicked: (image) {
    // handle image or null
  },
  title: 'Upload ID Photo',
  subtitle: 'PNG or JPG under 5MB',
  titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  subtitleStyle: TextStyle(color: Colors.grey),
  cameraBtnDecoration: ElevatedButton.styleFrom(...),
  galleryBtnDecoration: OutlinedButton.styleFrom(...),
  cameraIcon: Icon(Icons.photo_camera),
  galleryIcon: Icon(Icons.folder),
  borderStyle: PhotoUploadBorderStyle.roundedRect,
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
)
```

---

## 📸 Screenshot

> (Add screenshots in your /screenshots folder and link them here)

---

## 📚 API Overview

| Prop                   | Type                     | Description                          |
| ---------------------- | ------------------------ | ------------------------------------ |
| `onImagePicked`        | `Function(File?)`        | Called with image or `null` on clear |
| `title` / `subtitle`   | `String`                 | Shown above the button               |
| `cameraBtnDecoration`  | `ButtonStyle`            | Style for camera button              |
| `galleryBtnDecoration` | `ButtonStyle`            | Style for gallery button             |
| `cameraIcon`           | `Widget?`                | Optional camera button icon          |
| `galleryIcon`          | `Widget?`                | Optional gallery button icon         |
| `icon`                 | `Widget?`                | Optional top icon                    |
| `borderStyle`          | `PhotoUploadBorderStyle` | Shape of the dotted border           |
| `padding`              | `EdgeInsetsGeometry`     | Padding around content               |

---

## 📤 Clear Button Behavior

When an image is selected, a small `X` button appears in the top-right corner. Clicking it:

* Clears the preview
* Calls the `onImagePicked(null)` callback

---

## 📄 License

MIT License © 2025
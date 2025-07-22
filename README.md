# 📸 flutter\_image\_picker\_ui

A modern and customizable image picker UI for Flutter, built on top of the popular `image_picker` plugin.

This widget provides a clean, user-friendly interface for selecting images from the camera or gallery — with support for previews, icons, and styling options.

---

## 📸 Screenshot

<img src="https://raw.githubusercontent.com/AbdullahAlMamun12/flutter_image_picker_ui/f2c66e58a75d2c56a4ee61b7389724f55ffac469/screenshots/demo.jpeg" alt="Preview" width="180" height="350" />

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
  onImagePicked: (File? image) {},

  icon: Container(
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
  ),

  title: 'Upload your profile photo',
  titleStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),

  subtitle: 'PNG or JPG, up to 5MB',
  subtitleStyle: const TextStyle(
    fontSize: 14,
    color: Colors.grey,
  ),

  padding: const EdgeInsets.all(24),

  cameraBtnDecoration: ElevatedButton.styleFrom(
    backgroundColor: Colors.green.shade700,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  galleryBtnDecoration: OutlinedButton.styleFrom(
    foregroundColor: Colors.green.shade700,
    side: BorderSide(
      color: Colors.green.shade700,
      width: 2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  cameraIcon: const Icon(Icons.photo_camera, size: 20),
  galleryIcon: const Icon(Icons.photo_library, size: 20),
);
```

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
| `padding`              | `EdgeInsetsGeometry`     | Padding around content               |

---

## 📤 Clear Button Behavior

When an image is selected, a small `X` button appears in the top-right corner. Clicking it:

* Clears the preview
* Calls the `onImagePicked(null)` callback

---

## 📄 License

[MIT](LICENSE) © Abdullah Al Mamun

---

## 👥 Maintainer

- [Abdullah Al Mamun](https://github.com/AbdullahAlMamun12)

---

> Made with ❤️ using Flutter.
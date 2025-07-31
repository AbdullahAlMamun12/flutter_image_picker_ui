# 📦 Changelog

All notable changes to the `flutter_image_picker_ui` package will be documented in this file.

---

## \[1.0.1] - 2025-07-31

### 🆕 Enhancements

* Added `onCreate` callback to expose `PhotoUploadController`
* Allow programmatic image clearing via `controller.clearImage()`
* Improved internal state handling and cleanup
* Updated docs and examples to reflect new features
* Added optional `icon` widget support to main preview UI

### 🐞 Fixes

* Prevent multiple image pick operations simultaneously
* Better error handling during image selection
* Improved layout rendering for image previews

---

## \[1.0.0] - Initial Release

### 🚀 Features

* Image picker UI built on top of `image_picker`
* Default and fully custom constructors (`PhotoUploadWidget` & `PhotoUploadWidget.custom`)
* Clean UI with:

  * Dotted border styling
  * Optional top icon
  * Title and subtitle text
  * Customizable camera and gallery buttons
* Image preview with a clear (X) icon
* Asset icon support for camera and gallery
* Border style enum: `PhotoUploadBorderStyle`

### ✅ Stable for production use

* Works well with all standard Flutter setups
* Easily embeddable in forms and profile editors

---
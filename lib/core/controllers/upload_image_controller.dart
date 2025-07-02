import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class UploadImageController extends GetxController {
  static UploadImageController get instance => Get.find();
  Uint8List? selectedImageBytes;
  String? fileName;

  Future<void> selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      selectedImageBytes = result.files.first.bytes;
      fileName = result.files.first.name;
      update();
    }
  }
}

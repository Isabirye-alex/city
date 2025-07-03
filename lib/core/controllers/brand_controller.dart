import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BrandController extends GetxController {
  Uint8List? selectedImageBytes;
  String? fileName;
  final RxMap<String, dynamic> category = <String, dynamic>{}.obs;
  final categoryNameController = TextEditingController();

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

  Future<void> createNewBrand(BuildContext context) async {
    try {
      if (selectedImageBytes == null ||
          fileName == null ||
          category['name'] == null) {
        Get.snackbar('Validation', 'All fields including image must be filled');
        return;
      }

      final uri = Uri.parse('http://localhost:3000/brands');
      final request = http.MultipartRequest('POST', uri);
      request.fields['name'] = category['name'];
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          selectedImageBytes!,
          filename: fileName,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        // ✅ Clear the inputs and state
        selectedImageBytes = null;
        fileName = null;
        category.clear();
        categoryNameController.clear();
        update(); // Notify the UI to refresh (e.g., remove image preview)
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: 'Brand added successfully!',
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          'Failed',
          data['message'] ?? 'Unknown error',
        );
        // Get.snackbar('Failed', 'Server responded with ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not add new category: $e');
    }
  }
}

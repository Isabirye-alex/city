import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddSubCategoryController extends GetxController {
  Uint8List? selectedImageBytes;
  String? fileName;
  final RxMap<String, dynamic> subcategory = <String, dynamic>{}.obs;
  final subcategoryNameController = TextEditingController();
  final subcategoryDescriptionController = TextEditingController();

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

  Future<void> createNewSubCategory(BuildContext context) async {
    try {
      final parentId = subcategory['parentCategoryId']?.toString();
      final name = subcategory['name'];
      final desc = subcategory['description'];

      if (selectedImageBytes == null ||
          fileName == null ||
          subcategory['name'] == null) {
        // Get.snackbar('Validation', 'All fields including image must be filled');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('All fields are required')));
        return;
      }

      final uri = Uri.parse('http://localhost:3000/subcategories');
      final request = http.MultipartRequest('POST', uri);

      // Add fields
      request.fields['name'] = name;
      request.fields['category_id'] = parentId!;
      request.fields['description'] = desc;
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          selectedImageBytes!,
          filename: fileName,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      // final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        // ✅ Clear the inputs and state
        selectedImageBytes = null;
        fileName = null;
        subcategory.clear();
        subcategoryDescriptionController.clear();
        subcategoryNameController.clear();
        update();
        // update(); // Notify the UI to refresh (e.g., remove image preview)
        // Get.showSnackbar(
        //   GetSnackBar(
        //     title: 'Success',
        //     message: 'Sub category added successfully!',
        //     duration: const Duration(seconds: 3),
        //     backgroundColor: Colors.green,
        //   ),
        // );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(data['message'] ?? 'Unknown error')),
        // );
        // Get.snackbar(
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.red,
        //   'Failed',
        //   data['message'] ?? 'Unknown error',
        // );
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not add new category: $e');
    }
  }
}

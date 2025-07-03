import 'dart:typed_data';
import 'package:city/models/product.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddProductController extends GetxController {
  Uint8List? selectedImageBytes;

  String? fileName;
  final RxMap<String, dynamic> products = <String, dynamic>{}.obs;
  final RxList<Product> product = <Product>[].obs;
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  /// For File Picker
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

  Future<void> createProduct(BuildContext context) async {
    try {
      final parentId = products['parentCategoryId'].toString();
      final childId = products['parentSubCategoryId'].toString();
      final name = products['name'];
      final desc = products['description'];
      if (selectedImageBytes == null ||
          fileName == null ||
          products['name'] == null ||
          products['price'] == null ||
          products['quantity'] == null) {
        Get.snackbar('Validation', 'All fields including image must be filled');
        return;
      }

      final uri = Uri.parse('http://localhost:3000/products');
      final request = http.MultipartRequest('POST', uri);

      // Add fields
      request.fields['name'] = name;
      request.fields['category_id'] = parentId;
      request.fields['subcategory_id'] = childId;
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
      if (response.statusCode == 201 || response.statusCode == 200) {
        selectedImageBytes = null;
        fileName = null;
        products.clear();
        descriptionController.clear();
        quantityController.clear();
        priceController.clear();
        nameController.clear();
        update();
      } else {}
    } catch (e) {
      Get.snackbar('Error', 'Could not add new category: $e');
    }
  }
}

import 'dart:io';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddCategoryController extends GetxController {
  final addNameController = TextEditingController();
  Rx<File?> selectedImage = Rx<File?>(null);

  // Pick image using any picker logic e.g. image_picker package
  void setSelectedImage(File image) {
    selectedImage.value = image;
  }

  Future<void> addProduct() async {
    final uri = Uri.parse('http://your-api-url.com/api/categories');
    final request = http.MultipartRequest('POST', uri);

    request.fields['name'] = addNameController.text.trim();

    if (selectedImage.value != null) {
      final image = await http.MultipartFile.fromPath(
        'image', 
        selectedImage.value!.path,
        filename: basename(selectedImage.value!.path),
      );
      request.files.add(image);
    }

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Category added successfully');
    } else {
      final body = await response.stream.bytesToString();
      print('Failed to add category: ${response.statusCode} - $body');
    }
  }
}

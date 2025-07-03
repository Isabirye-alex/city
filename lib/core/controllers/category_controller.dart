// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:city/models/category.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  Uint8List? selectedImageBytes;
  String? fileName;
  final RxMap<String, dynamic> category = <String, dynamic>{}.obs;
  final categoryNameController = TextEditingController();
  final RxList<Category> categories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

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

  Future<void> createNewCategory(BuildContext context) async {
    try {
      if (selectedImageBytes == null ||
          fileName == null ||
          category['name'] == null) {
        Get.snackbar('Validation', 'All fields including image must be filled');
        return;
      }

      final uri = Uri.parse('http://localhost:3000/categories');
      final request = http.MultipartRequest('POST', uri);

      // Add fields
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
      if (response.statusCode == 201 || response.statusCode == 200) {
        // ✅ Clear the inputs and state
        selectedImageBytes = null;
        fileName = null;
        category.clear();
        categoryNameController.clear();
        update(); // Notify the UI to refresh (e.g., remove image preview)
        Flushbar(
          leftBarIndicatorColor: Colors.green,
          shouldIconPulse: true,
          icon: Icon(Icons.check_circle, color: Colors.green, size: 30),
          message: 'Success, Category successfully added',
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(top: 50),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      } else {
        Flushbar(
          leftBarIndicatorColor: Colors.green,
          shouldIconPulse: true,
          icon: Icon(Icons.check_circle, color: Colors.green, size: 30),
          message: 'Error, Un knwon error occurred',
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(top: 50),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      }
    } catch (e) {
      Flushbar(
        leftBarIndicatorColor: Colors.green,
        shouldIconPulse: true,
        icon: Icon(Icons.check_circle, color: Colors.green, size: 30),
        message: 'Error, Could not create new product',
        duration: Duration(seconds: 4),
        margin: EdgeInsets.only(top: 50),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
  }

  Future<void> getCategories() async {
    try {
      final uri = Uri.parse('http://localhost:3000/categories');
      final response = await http.get(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> jsonList = data['data'];

        final List<Category> loadedCategories = jsonList
            .map((jsonItem) => Category.fromJson(jsonItem))
            .toList();

        categories.assignAll(loadedCategories);
        Flushbar(
          leftBarIndicatorColor: Colors.green,
          shouldIconPulse: true,
          icon: Icon(Icons.check_circle, color: Colors.green, size: 30),
          message: 'Success, Category successfully added',
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(top: 50),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(Get.context!); // Update observable list
      } else {
        Flushbar(
          leftBarIndicatorColor: Colors.green,
          shouldIconPulse: true,
          icon: Icon(Icons.check_circle, color: Colors.green, size: 30),
          message: 'Error, Un known error occurred',
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(top: 50),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(Get.context!);
      }
    } catch (e) {
      Flushbar(
        leftBarIndicatorColor: Colors.green,
        shouldIconPulse: true,
        icon: Icon(Icons.check_circle, color: Colors.green, size: 30),
        message: 'Error, Could not retrieve category $e',
        duration: Duration(seconds: 4),
        margin: EdgeInsets.only(top: 50),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(Get.context!);
    }
  }
}

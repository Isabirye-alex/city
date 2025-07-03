import 'dart:convert';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:city/models/subcategory.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubCategoryController extends GetxController {
  Uint8List? selectedImageBytes;
  String? fileName;
  final RxMap<String, dynamic> subcategory = <String, dynamic>{}.obs;
  final subcategoryNameController = TextEditingController();
  final subcategoryDescriptionController = TextEditingController();
  final RxList<SubCategoryModel> subcategories = <SubCategoryModel>[].obs;

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

      if (response.statusCode == 201 || response.statusCode == 200) {
        selectedImageBytes = null;
        fileName = null;
        subcategory.clear();
        subcategoryDescriptionController.clear();
        subcategoryNameController.clear();
        update();
        Flushbar(
          leftBarIndicatorColor: Colors.green,
          shouldIconPulse: true,
          icon: Icon(Icons.check_circle, color: Colors.green, size: 30),
          message: 'Success, Sub successfully added',
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(top: 50),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      } else {}
    } catch (e) {
      Get.snackbar('Error', 'Could not add new category: $e');
    }
  }

  Future<void> getSubcategories() async {
    try {
      final uri = Uri.parse('http://localhost:3000/subcategories');
      final response = await http.get(uri);
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> jsonList = data['data'];
        final List<SubCategoryModel> loadedSubCategories = jsonList
            .map((e) => SubCategoryModel.fromJson(e))
            .toList();
        subcategories.assignAll(loadedSubCategories);
      }
    } catch (e) {
      throw Exception('Erro fetching subcategories: $e');
    }
  }
}

import 'package:city/core/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<Categories> {
  late DropzoneViewController dropzoneController;
  String? uploadedFileName;
  bool isImageDropped = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
        backgroundColor: Colors.black45,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Category Name
            TextFormField(
              controller: controller.categoryNameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // // Description
            // TextFormField(
            //   controller: controller.categoryDescriptionController,
            //   maxLines: 3,
            //   decoration: const InputDecoration(
            //     labelText: 'Description',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 16),

            // Image upload box
            Container(
              height: 180,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GetBuilder<CategoryController>(
                    builder: (_) {
                      if (controller.selectedImageBytes == null) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: () => controller.selectImage(),
                              child: const Text('Select Image'),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.fileName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Image.memory(
                              controller.selectedImageBytes!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit button
            ElevatedButton(
              onPressed: () {
                controller.category['name'] =
                    controller.categoryNameController.text;
                controller.createNewCategory(context);
              },
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}

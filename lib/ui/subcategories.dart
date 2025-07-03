import 'package:city/core/controllers/category_controller.dart';
import 'package:city/core/controllers/subcategory_controller.dart';
import 'package:city/models/category.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class Subcategories extends StatefulWidget {
  const Subcategories({super.key});

  @override
  State<Subcategories> createState() => _SubcategoriesState();
}

class _SubcategoriesState extends State<Subcategories> {
  late DropzoneViewController dropzoneController;
  String? uploadedFileName;
  bool isImageDropped = false;

  final TextEditingController subcategoryNameController =
      TextEditingController();
  final TextEditingController subcategoryDescriptionController =
      TextEditingController();

  String? selectedCategory;

  final List<String> dummyCategories = ['Electronics', 'Clothing', 'Books'];

  @override
  void dispose() {
    subcategoryNameController.dispose();
    subcategoryDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final controller = Get.put(SubCategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Subcategory',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black45,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(height: 30),
              // Parent Category Dropdown
              Obx(() {
                return DropdownButtonFormField<Category>(
                  decoration: const InputDecoration(
                    labelText: 'Select Parent Category',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedCategory != null
                      ? categoryController.categories.firstWhereOrNull(
                          (cat) => cat.name == selectedCategory,
                        )
                      : null,
                  items: categoryController.categories
                      .map(
                        (cat) => DropdownMenuItem<Category>(
                          value: cat,
                          child: Text(cat.name),
                        ),
                      )
                      .toList(),
                  onChanged: (Category? value) {
                    setState(() {
                      selectedCategory = value?.name;
                      controller.subcategory['parentCategoryId'] = value?.id;
                    });
                  },
                );
              }),

              const SizedBox(height: 16),

              // Subcategory Name
              TextFormField(
                controller: controller.subcategoryNameController,
                decoration: const InputDecoration(
                  labelText: 'Subcategory Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: controller.subcategoryDescriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Image upload box
              Container(
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GetBuilder<SubCategoryController>(
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
                        OutlinedButton(
                          onPressed: () {
                            if (controller.selectedImageBytes != null) {
                              controller.selectedImageBytes == null;
                              controller.selectImage();
                            }
                          },
                          child: Text('Change Image'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  controller.subcategory['name'] =
                      controller.subcategoryNameController.text;
                  controller.subcategory['description'] =
                      controller.subcategoryDescriptionController.text;

                  controller.createNewSubCategory(context);
                },
                child: const Text('Add Sub Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

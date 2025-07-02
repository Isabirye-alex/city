import 'package:city/core/controllers/add_subcategory_controller.dart';
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

  Future<void> pickImage() async {
    // Implement file picker if needed
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddSubCategoryController());
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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Parent Category',
                  border: OutlineInputBorder(),
                ),
                value: selectedCategory,
                items: dummyCategories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Subcategory Name
              TextFormField(
                controller: subcategoryNameController,
                decoration: const InputDecoration(
                  labelText: 'Subcategory Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: subcategoryDescriptionController,
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
                    GetBuilder<AddSubCategoryController>(
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
                  controller.createNewSubCategory(context);
                  setState(() {
                    controller.categoryNameController.clear();
                    controller.selectedImageBytes!.clear();
                  });
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

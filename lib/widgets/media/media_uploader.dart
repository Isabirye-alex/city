import 'package:city/core/controllers/category_controller.dart';
import 'package:city/core/controllers/product_controller.dart';
import 'package:city/core/controllers/subcategory_controller.dart';
import 'package:city/models/category.model.dart';
import 'package:city/models/subcategory.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaUploader extends StatefulWidget {
  const MediaUploader({super.key});

  @override
  State<MediaUploader> createState() => _MediaUploaderState();
}

class _MediaUploaderState extends State<MediaUploader> {
  String? selectedCategory;
  String? selectedSubCategory;

  @override
  void initState() {
    super.initState();
    final subController = Get.put(AddSubCategoryController());
    subController.getSubcategories();
  }

  @override
  Widget build(BuildContext context) {
    final mediaController = Get.put(ProductController());
    final categoryController = Get.put(CategoryController());
    final subcategoryController = Get.put(AddSubCategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
        backgroundColor: const Color.fromARGB(115, 122, 180, 231),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.only(left: 4),
          children: [
            // Product Name
            TextFormField(
              controller: mediaController.nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: mediaController.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
            ),
            const SizedBox(height: 16),

            // Category Dropdown
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
                    mediaController.products['parentCategoryId'] = value?.id;
                  });
                },
              );
            }),
            SizedBox(height: 16),
            // Subcategory Dropdown
            Obx(() {
              return DropdownButtonFormField<SubCategoryModel>(
                decoration: const InputDecoration(
                  labelText: 'Select Sub category',
                  border: OutlineInputBorder(),
                ),
                value: selectedSubCategory != null
                    ? subcategoryController.subcategories.firstWhereOrNull(
                        (cat) => cat.name == selectedSubCategory,
                      )
                    : null,
                items: subcategoryController.subcategories
                    .map(
                      (cat) => DropdownMenuItem<SubCategoryModel>(
                        value: cat,
                        child: Text(cat.name),
                      ),
                    )
                    .toList(),
                onChanged: (SubCategoryModel? value) {
                  setState(() {
                    selectedSubCategory = value?.name;
                    mediaController.products['parentSubCategoryId'] = value?.id;
                  });
                },
              );
            }),
            SizedBox(height: 16),
            // Price
            TextFormField(
              controller: mediaController.priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Quantity
            TextFormField(
              controller: mediaController.quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Toggle: Featured
            SwitchListTile(
              value: true,
              onChanged: (val) {},
              title: const Text('Featured Product'),
            ),

            // Image Uploader
            const SizedBox(height: 16),
            const Text("Upload Images:"),
            const SizedBox(height: 8),
            Container(
              height: 200,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GetBuilder<ProductController>(
                        builder: (_) {
                          if (mediaController.selectedImageBytes == null) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 8),
                                OutlinedButton(
                                  onPressed: () =>
                                      mediaController.selectImage(),
                                  child: const Text('Select Image'),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  mediaController.fileName ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Image.memory(
                                  mediaController.selectedImageBytes!,
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
                          if (mediaController.selectedImageBytes != null) {
                            setState(() {
                              mediaController.selectedImageBytes == null;
                              mediaController.fileName = null;

                              mediaController.selectImage();
                            });
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

            ElevatedButton(
              onPressed: () {
                mediaController.products['name'] = mediaController
                    .nameController
                    .text
                    .trim();
                mediaController.products['description'] = mediaController
                    .descriptionController
                    .text
                    .trim();
                mediaController.products['stock'] = mediaController
                    .quantityController
                    .text
                    .trim();
                mediaController.products['price'] = mediaController
                    .priceController
                    .text
                    .trim();
                mediaController.createProduct(context);
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}

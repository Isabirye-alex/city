import 'package:city/core/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaController = Get.put(AddProductController());
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
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
            ),
            const SizedBox(height: 16),

            // Category Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: ['Electronics', 'Clothing', 'Books', 'Accessories']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),

            // Subcategory Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Subcategory',
                border: OutlineInputBorder(),
              ),
              items: ['Mobiles', 'Laptops', 'Accessories', 'Chargers', 'Iphone']
                  .map((sub) => DropdownMenuItem(value: sub, child: Text(sub)))
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),

            // Price
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Quantity
            TextFormField(
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
                      GetBuilder<AddProductController>(
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
                            mediaController.selectedImageBytes == null;
                            mediaController.selectImage();
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
                mediaController.category['name'] =
                    mediaController.categoryNameController.text;
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

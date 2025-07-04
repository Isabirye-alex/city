import 'package:city/core/controllers/brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class Brands extends StatefulWidget {
  const Brands({super.key});

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  late DropzoneViewController dropzoneController;
  String? uploadedLogoName;
  bool logoDropped = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> pickLogo() async {}

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Add Brand"),
        backgroundColor: Colors.black45,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(height: 50),
            // Brand Name
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Brand Description
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Logo Upload Box
            Container(
              height: 180,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GetBuilder<BrandController>(
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
                                  width: 200,
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
                  const SizedBox(height: 32),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                controller.category['name'] =
                    controller.categoryNameController.text;
                controller.createNewBrand(context);
              },
              child: const Text('Add Brand'),
            ),
          ],
        ),
      ),
    );
  }
}

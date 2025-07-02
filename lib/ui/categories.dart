import 'package:city/core/controllers/upload_image_controller.dart';
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

  

  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    categoryNameController.dispose();
    categoryDescriptionController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadImageController());
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
              controller: categoryNameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: categoryDescriptionController,
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
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  DropzoneView(
                    cursor: CursorType.copy,
                    mime: const [
                      'image/jpeg',
                      'image/png',
                      'image/gif',
                      'image/webp',
                      'image/jpg',
                    ],
                    onCreated: (ctrl) => dropzoneController = ctrl,
                    onDrop: (ev) async {
                      final name = await dropzoneController.getFilename(ev);
                      setState(() {
                        uploadedFileName = name;
                        isImageDropped = true;
                      });
                    },
                    onError: (ev) => debugPrint('Dropzone error: $ev'),
                  ),
                  if (!isImageDropped)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/drag_and_drop.jpg',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 8),
                        const Text('Drag and drop an image here'),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed:()=>controller.selectImage() ,
                          child: const Text('Select Image'),
                        ),
                      ],
                    )
                  else
                    Text(
                      'Selected file: $uploadedFileName',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit button
            ElevatedButton(
              onPressed: () {
                // TODO: handle category submit logic here
              },
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}

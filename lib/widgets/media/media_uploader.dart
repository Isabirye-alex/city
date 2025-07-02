import 'package:city/widgets/media/media_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
        backgroundColor: const Color.fromARGB(115, 122, 180, 231),
      ),
      body:  Padding(
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
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
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
                items:
                    ['Mobiles', 'Laptops', 'Accessories', 'Chargers', 'Iphone']
                        .map(
                          (sub) =>
                              DropdownMenuItem(value: sub, child: Text(sub)),
                        )
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
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    DropzoneView(
                      mime: const [
                        '/image/jpeg',
                        '/image/png',
                        '/image/gif',
                        '/image/webp',
                        '/image/jpg',
                        '/video/*',
                      ],
                      cursor: CursorType.copy,
                      operation: DragOperation.copy,
                      onCreated: (ctr) => controller.dropzoneController = ctr,
                      onDropFile: (file) {
                        // Handle dropped file
                      },
                      onLoaded: () => debugPrint('Dropzone loaded'),
                      onDrop: (ev) => debugPrint('Dropzone drop: $ev'),
                      onError: (err) => debugPrint('Dropzone error: $err'),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/drag_and_drop.jpg',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Drag and drop here',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {
                            // Trigger file selection manually if needed
                          },
                          child: const Text('Select Images'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  //Submit product logic
                },
                child: const Text('Save Product'),
              ),
            ],
          ),
        ),
      
    );
  }
}

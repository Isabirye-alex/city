import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

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
                            onPressed: pickImage,
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

              ElevatedButton(
                onPressed: () {
                  // TODO: submit subcategory data
                },
                child: const Text('Add Subcategory'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

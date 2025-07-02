import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

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
                  DropzoneView(
                    cursor: CursorType.copy,
                    mime: const [
                      'image/png',
                      'image/jpeg',
                      'image/jpg',
                      'image/webp',
                      'image/svg+xml',
                    ],
                    onCreated: (ctrl) => dropzoneController = ctrl,
                    onDrop: (ev) async {
                      final name = await dropzoneController.getFilename(ev);
                      setState(() {
                        uploadedLogoName = name;
                        logoDropped = true;
                      });
                    },
                    onError: (ev) => debugPrint('Dropzone error: $ev'),
                  ),
                  if (!logoDropped)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/drag_and_drop.jpg',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 8),
                        const Text('Drag and drop a logo image here'),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: pickLogo,
                          child: const Text('Select Logo'),
                        ),
                      ],
                    )
                  else
                    Text(
                      'Selected logo: $uploadedLogoName',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // TODO: Handle submission
                final name = nameController.text.trim();
                final description = descriptionController.text.trim();
                final logo = uploadedLogoName;

                if (name.isEmpty || description.isEmpty || logo == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All fields including logo are required'),
                    ),
                  );
                  return;
                }

                // Submit brand to backend or controller
                debugPrint('Brand added: $name, $description, logo: $logo');
              },
              child: const Text('Add Brand'),
            ),
          ],
        ),
      ),
    );
  }
}

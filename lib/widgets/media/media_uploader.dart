import 'package:city/widgets/media/media_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Drag and drop
        Expanded(
          child: Container(
            margin: EdgeInsets.all(6),

            width: 500,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DropzoneView(
                        mime: [
                          '/image/jpeg',
                          '/image/png',
                          '/image/gif',
                          '/video/*',
                        ],
                        cursor: CursorType.copy,
                        operation: DragOperation.copy,
                        onLoaded: () => debugPrint('zone loaded'),
                        onError: (ev) => debugPrint('zone error: $ev'),
                        onHover: () => debugPrint('zone hovered'),
                        onLeave: () => debugPrint('zone left'),
                        onCreated: (ctr) => controller.dropzoneController = ctr,
                        onDropFile: (file) {},
                        onDrop: (ev) => debugPrint('zone drop invalid: $ev'),
                        onDropMultiple: (ev) async {
                          debugPrint('Zone drop multiple: $ev');
                        },
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/drag_and_drop.jpg',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Drag and drop files here',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Select Images'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

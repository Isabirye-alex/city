import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaController extends GetxController {
  static MediaController get to => Get.find();
  late DropzoneViewController dropzoneController;
}
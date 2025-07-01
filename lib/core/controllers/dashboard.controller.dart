import 'package:get/get.dart';

class DashBoardController extends GetxController {
  final RxList<double> weeklySales = <double>[].obs;
  final RxList<double> monthlySales = <double>[].obs;
  static final RxList<OrderModel> orders = <OrderModel>[].obs;
}

// import 'package:city/helper_functions/date_helper.dart';
import 'package:city/models/order.model.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  static DashBoardController get instance => Get.find();
  final RxList<double> weeklySales = <double>[].obs;
  final RxList<double> monthlySales = <double>[].obs;
  static final RxList<OrderModel> orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchOrders();
    _calculateWeeklySales();
    _calculateMonthlySales();
  }

  void _calculateWeeklySales() {
    // Original logic (commented out for now)
    /*
    for (var order in orders) {
      final DateTime orderWeekStart = AHelperFunction.getStartOfWeek(
        order.paidAt,
      );
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.paidAt.weekday - 1) % 7;
        index = index < 0 ? index + 7 : index; // Ensure index is not negative
        weeklySales[index] += order.totalAmount.toDouble(); 
      }
    }
    */

    // Dummy data for visual representation (Mon - Sun)
    weeklySales.value = [120.0, 240.0, 180.0, 300.0, 210.0, 360.0, 390.0];
  }

  void _calculateMonthlySales() {
    // Original logic (commented out for now)
    // monthlySales.value = List<double>.filled(1000, 0.000);

    // Dummy monthly data (Jan - Dec)
    monthlySales.value = [
      1000.0,
      1200.0,
      1100.0,
      1500.0,
      1700.0,
      1600.0,
      1800.0,
      1900.0,
      1750.0,
      1600.0,
      1550.0,
      2000.0,
    ];
  }

  void _fetchOrders() {
    // Dummy orders for now
    orders.value = [
      OrderModel(
        id: 1,
        userId: 1,
        totalAmount: 100,
        shippingAddress: '123 Main St',
        paymentMethod: 'Credit Card',
        isPaid: true,
        paidAt: DateTime.now().subtract(Duration(days: 1)),
        deliveredAt: null,
        status: 'Delivered',
      ),
      OrderModel(
        id: 2,
        userId: 2,
        totalAmount: 200,
        shippingAddress: '456 Elm St',
        paymentMethod: 'PayPal',
        isPaid: true,
        paidAt: DateTime.now().subtract(Duration(days: 3)),
        deliveredAt: null,
        status: 'Pending',
      ),
      OrderModel(
        id: 2,
        userId: 2,
        totalAmount: 200,
        shippingAddress: '456 Elm St',
        paymentMethod: 'PayPal',
        isPaid: true,
        paidAt: DateTime.now().subtract(Duration(days: 3)),
        deliveredAt: null,
        status: 'Pending',
      ),
      OrderModel(
        id: 2,
        userId: 2,
        totalAmount: 200,
        shippingAddress: '456 Elm St',
        paymentMethod: 'PayPal',
        isPaid: true,
        paidAt: DateTime.now().subtract(Duration(days: 3)),
        deliveredAt: null,
        status: 'Delivered',
      ),
      OrderModel(
        id: 2,
        userId: 2,
        totalAmount: 200,
        shippingAddress: '456 Elm St',
        paymentMethod: 'PayPal',
        isPaid: true,
        paidAt: DateTime.now().subtract(Duration(days: 3)),
        deliveredAt: null,
        status: 'Confirmed',
      ),
      OrderModel(
        id: 2,
        userId: 2,
        totalAmount: 200,
        shippingAddress: '456 Elm St',
        paymentMethod: 'PayPal',
        isPaid: true,
        paidAt: DateTime.now().subtract(Duration(days: 3)),
        deliveredAt: null,
        status: 'Cancelled',
      ),
    ];
  }
}

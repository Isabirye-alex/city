import 'dart:convert';

class OrderModel {
  int id;
  int userId;
  int totalAmount;
  String shippingAddress;
  String paymentMethod;
  bool isPaid;
  DateTime? paidAt;
  DateTime? deliveredAt;
  String status;

  OrderModel({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.isPaid,
    this.paidAt,
    this.deliveredAt,
    required this.status,
  });

  OrderModel copyWith({
    int? id,
    int? userId,
    int? totalAmount,
    String? shippingAddress,
    String? paymentMethod,
    bool? isPaid,
    DateTime? paidAt,
    DateTime? deliveredAt,
    String? status,
  }) => OrderModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    totalAmount: totalAmount ?? this.totalAmount,
    shippingAddress: shippingAddress ?? this.shippingAddress,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    isPaid: isPaid ?? this.isPaid,
    paidAt: paidAt ?? this.paidAt,
    deliveredAt: deliveredAt ?? this.deliveredAt,
    status: status ?? this.status,
  );

  factory OrderModel.fromRawJson(String str) =>
      OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    userId: json["user_id"],
    totalAmount: json["total_amount"],
    shippingAddress: json["shipping_address"],
    paymentMethod: json["payment_method"],
    isPaid: json["is_paid"],
    paidAt: json["paid_at"] != null ? DateTime.tryParse(json["paid_at"]) : null,
    deliveredAt: json["delivered_at"] != null
        ? DateTime.tryParse(json["delivered_at"])
        : null,
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "total_amount": totalAmount,
    "shipping_address": shippingAddress,
    "payment_method": paymentMethod,
    "is_paid": isPaid,
    "paid_at": paidAt?.toIso8601String(),
    "delivered_at": deliveredAt?.toIso8601String(),
    "status": status,
  };
}

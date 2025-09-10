class PaymentResponse {
  final bool success;
  final String message;
  final String? orderId;
  final String? status;
  final Map<String, dynamic>? data;

  PaymentResponse({
    required this.success,
    required this.message,
    this.orderId,
    this.status,
    this.data,
  });

  factory PaymentResponse.success({
    String? orderId,
    String? status,
    Map<String, dynamic>? data,
  }) {
    return PaymentResponse(
      success: true,
      message: 'Payment successful',
      orderId: orderId,
      status: status,
      data: data,
    );
  }

  factory PaymentResponse.failure({
    String message = 'Payment failed',
    String? orderId,
    String? status,
    Map<String, dynamic>? data,
  }) {
    return PaymentResponse(
      success: false,
      message: message,
      orderId: orderId,
      status: status,
      data: data,
    );
  }
}
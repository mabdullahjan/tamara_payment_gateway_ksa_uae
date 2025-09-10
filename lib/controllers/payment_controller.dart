import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/tamara_models.dart';
import '../models/payment_response.dart';
import '../services/tamara_service.dart';

class PaymentController extends GetxController {
  final TamaraService _tamaraService = Get.find();
  final Rx<PaymentState> paymentState = PaymentState.idle.obs;
  final RxString errorMessage = ''.obs;
  final Rx<TamaraCheckoutResponse?> checkoutResponse = Rx<TamaraCheckoutResponse?>(null);
  final Rx<PaymentResponse?> paymentResult = Rx<PaymentResponse?>(null);
  final Rx<Product?> currentProduct = Rx<Product?>(null);

  Future<void> initiatePayment(Product product) async {
    try {
      paymentState.value = PaymentState.processing;
      errorMessage.value = '';
      currentProduct.value = product;

      final orderRequest = _tamaraService.createOrderRequest(product);
      final response = await _tamaraService.createCheckout(orderRequest);

      checkoutResponse.value = response;
      paymentState.value = PaymentState.checkoutCreated;

      // Navigate to webview
      Get.toNamed('/payment-webview', arguments: {
        'checkoutUrl': response.checkoutUrl,
        'orderId': response.orderId,
      });

    } catch (e) {
      errorMessage.value = e.toString();
      paymentState.value = PaymentState.error;
      Get.snackbar(
        'Error',
        'Failed to create payment: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  void handlePaymentResult(Map<String, dynamic> result) {
    final status = result['status']?.toString().toLowerCase();
    final orderId = result['order_id']?.toString();
    final message = result['message']?.toString();

    if (status?.contains('success') == true || status?.contains('approved') == true) {
      paymentResult.value = PaymentResponse.success(
        orderId: orderId,
        status: status,
        data: result,
      );
      paymentState.value = PaymentState.success;
      
      // Show success message
      Get.offNamed('/payment-result');
      
    } else if (status?.contains('cancel') == true) {
      paymentResult.value = PaymentResponse.failure(
        message: message ?? 'Payment was cancelled',
        orderId: orderId,
        status: status,
        data: result,
      );
      paymentState.value = PaymentState.cancelled;
      
      // Show cancellation message
      Get.offNamed('/payment-result');
      
    } else {
      paymentResult.value = PaymentResponse.failure(
        message: message ?? 'Payment failed',
        orderId: orderId,
        status: status,
        data: result,
      );
      paymentState.value = PaymentState.failed;
      
      // Show failure message
      Get.offNamed('/payment-result');
    }
  }

  void retryPayment() {
    if (currentProduct.value != null) {
      initiatePayment(currentProduct.value!);
    }
  }

  void resetPayment() {
    paymentState.value = PaymentState.idle;
    errorMessage.value = '';
    checkoutResponse.value = null;
    paymentResult.value = null;
    currentProduct.value = null;
  }

  // Getter for UI state
  bool get isProcessing => paymentState.value == PaymentState.processing;
  bool get hasError => paymentState.value == PaymentState.error;
  String get currentError => errorMessage.value;
}

enum PaymentState {
  idle,
  processing,
  checkoutCreated,
  success,
  failed,
  cancelled,
  error,
}
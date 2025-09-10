import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/payment_controller.dart';
import '../constants/constants.dart';
import '../models/payment_response.dart';

class PaymentResultView extends StatelessWidget {
  final PaymentController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final result = controller.paymentResult.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Result'),
        leading: Container(), // Remove back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (result?.success == true)
              _buildSuccessUI(result!)
            else if (controller.paymentState.value == PaymentState.cancelled)
              _buildCancelledUI(result)
            else
              _buildFailedUI(result),
            
            SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: () {
                controller.resetPayment();
                Get.offAllNamed(AppRoutes.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Back to Home'),
            ),
            
            if (result?.success != true)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    controller.resetPayment();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Try Again'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessUI(PaymentResponse result) {
    return Column(
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 80,
        ),
        SizedBox(height: 24),
        Text(
          'Payment Successful!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Thank you for your purchase',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        SizedBox(height: 8),
        if (result.orderId != null)
          Text(
            'Order ID: ${result.orderId}',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildFailedUI(PaymentResponse? result) {
    return Column(
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 80,
        ),
        SizedBox(height: 24),
        Text(
          'Payment Failed',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 16),
        Text(
          result?.message ?? 'Something went wrong with your payment',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCancelledUI(PaymentResponse? result) {
    return Column(
      children: [
        Icon(
          Icons.cancel,
          color: Colors.orange,
          size: 80,
        ),
        SizedBox(height: 24),
        Text(
          'Payment Cancelled',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'You cancelled the payment process',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
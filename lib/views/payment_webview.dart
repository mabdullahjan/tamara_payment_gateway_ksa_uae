import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/payment_controller.dart';

class PaymentWebView extends StatefulWidget {
  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  final PaymentController _paymentController = Get.find();
  bool _isLoading = true;
  bool _paymentCompleted = false;

  @override
  void initState() {
    super.initState();
    
    final args = Get.arguments;
    final checkoutUrl = args['checkoutUrl'] as String;
    final orderId = args['orderId'] as String;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar
          },
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
            _checkForAppDeepLinks(url, orderId);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_checkForAppDeepLinks(request.url, orderId)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            if (change.url != null) {
              _checkForAppDeepLinks(change.url!, orderId);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(checkoutUrl));
  }

  bool _checkForAppDeepLinks(String url, String orderId) {
    final uri = Uri.parse(url);
    
    // Check if this is our app's deep link
    if (uri.scheme == 'myapp' && uri.host == 'payment') {
      _handleAppDeepLink(uri, orderId);
      return true;
    }
    
    // Also check for Tamara's success patterns in the URL
    if (url.contains('success') || url.contains('approved')) {
      _handlePaymentSuccess(orderId, url);
      return true;
    } else if (url.contains('cancel') || url.contains('cancelled')) {
      _handlePaymentCancelled(orderId, url);
      return true;
    } else if (url.contains('fail') || url.contains('error')) {
      _handlePaymentFailed(orderId, url);
      return true;
    }
    
    return false;
  }

  void _handleAppDeepLink(Uri uri, String orderId) {
    final path = uri.path;
    
    switch (path) {
      case '/success':
        _handlePaymentSuccess(orderId, uri.toString());
        break;
      case '/failure':
        _handlePaymentFailed(orderId, uri.toString());
        break;
      case '/cancel':
        _handlePaymentCancelled(orderId, uri.toString());
        break;
      default:
        _handlePaymentFailed(orderId, uri.toString());
    }
  }

  void _handlePaymentSuccess(String orderId, String url) {
    if (_paymentCompleted) return;
    _paymentCompleted = true;
    
    _paymentController.handlePaymentResult({
      'status': 'success',
      'order_id': orderId,
      'url': url,
      'message': 'Payment completed successfully',
    });
  }

  void _handlePaymentFailed(String orderId, String url) {
    if (_paymentCompleted) return;
    _paymentCompleted = true;
    
    _paymentController.handlePaymentResult({
      'status': 'failed',
      'order_id': orderId,
      'url': url,
      'message': 'Payment failed',
    });
  }

  void _handlePaymentCancelled(String orderId, String url) {
    if (_paymentCompleted) return;
    _paymentCompleted = true;
    
    _paymentController.handlePaymentResult({
      'status': 'cancelled',
      'order_id': orderId,
      'url': url,
      'message': 'Payment cancelled by user',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tamara Checkout'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Ask user if they want to cancel payment
            Get.defaultDialog(
              title: 'Cancel Payment?',
              middleText: 'Are you sure you want to cancel this payment?',
              textConfirm: 'Yes',
              textCancel: 'No',
              confirmTextColor: Colors.white,
              onConfirm: () {
                _handlePaymentCancelled(
                  Get.arguments['orderId'] as String,
                  'user_cancelled'
                );
                Get.back();
              },
            );
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading payment gateway...'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
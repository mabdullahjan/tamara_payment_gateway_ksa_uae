class AppConstants { 

  
  //sandbox  https://api-sandbox.tamara.co
  //producttion https://api.tamara.co
  static const String baseUrl = 'https://api-sandbox.tamara.co';

  //your token here 
  static const String authToken = '';
  
  // App-specific URLs for deep linking (these will be handled within the app)
  static const String appBaseUrl = 'myapp://payment';
  static const String successUrl = '$appBaseUrl/success';
  static const String failureUrl = '$appBaseUrl/failure';
  static const String cancelUrl = '$appBaseUrl/cancel';
  static const String notificationUrl = '$appBaseUrl/notification'; // Not used but required
}

class AppRoutes {
  static const String home = '/';
  static const String paymentWebview = '/payment-webview';
  static const String paymentResult = '/payment-result';
}

class AppStrings {
  static const String appName = 'Tamara Pay';
  static const String products = 'Products';
  static const String buyNow = 'Buy Now';
  static const String payWithTamara = 'Pay with Tamara';
  static const String paymentProcessing = 'Payment Processing';
  static const String paymentSuccess = 'Payment Successful!';
  static const String paymentFailed = 'Payment Failed';
  static const String paymentCancelled = 'Payment Cancelled';
  static const String tryAgain = 'Try Again';
  static const String backToHome = 'Back to Home';
}
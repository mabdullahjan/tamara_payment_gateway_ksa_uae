import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../views/home_view.dart';
import '../../views/payment_result.dart';
import '../../views/payment_webview.dart';
 
class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
    ),
    GetPage(
      name: AppRoutes.paymentWebview,
      page: () => PaymentWebView(),
    ),
    GetPage(
      name: AppRoutes.paymentResult,
      page: () => PaymentResultView(),
    ),
  ];
}
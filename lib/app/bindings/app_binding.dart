import 'package:get/get.dart';

import '../../controllers/payment_controller.dart';
import '../../services/tamara_service.dart'; 

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TamaraService(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
  }
}
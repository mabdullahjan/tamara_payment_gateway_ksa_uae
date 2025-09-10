import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/product_model.dart';
import '../models/tamara_models.dart';

class TamaraService extends GetxService {
  Future<TamaraCheckoutResponse> createCheckout(TamaraOrderRequest orderRequest) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/checkout'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer ${AppConstants.authToken}',
          'content-type': 'application/json',
        },
        body: json.encode(orderRequest.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TamaraCheckoutResponse.fromJson(data);
      } else {
        final error = json.decode(response.body);
        throw Exception('Tamara API Error: ${error['message']}');
      }
    } catch (e) {
      throw Exception('Failed to create checkout: $e');
    }
  }

  TamaraOrderRequest createOrderRequest(Product product) {
    return TamaraOrderRequest(
      totalAmount: TamaraAmount(amount: product.price),
      shippingAmount: TamaraAmount(amount: 0),
      taxAmount: TamaraAmount(amount: 0),
      orderReferenceId: 'order_${DateTime.now().millisecondsSinceEpoch}',
      orderNumber: 'ORD${DateTime.now().millisecondsSinceEpoch}',
      discount: TamaraDiscount(
        amount: TamaraAmount(amount: 200),
        name: "Christmas 2020",
      ),
      items: [
        TamaraOrderItem(
          name: product.name,
          type: "Digital",
          referenceId: product.id,
          sku: product.sku,
          quantity: 1,
          discountAmount: TamaraAmount(amount: 100),
          taxAmount: TamaraAmount(amount: 10),
          unitPrice: TamaraAmount(amount: product.price),
          totalAmount: TamaraAmount(amount: product.price - 100),
        ),
      ],
      consumer: TamaraConsumer(
        email: "customer@email.com",
        firstName: "Mona",
        lastName: "Lisa",
        phoneNumber: "566027755",
      ),
      countryCode: "SA",
      description: product.description,
      paymentType: "PAY_NOW",
      instalments: 3,
      merchantUrl: TamaraMerchantUrl(
        cancel: AppConstants.cancelUrl,
        failure: AppConstants.failureUrl,
        success: AppConstants.successUrl,
        notification: AppConstants.notificationUrl,
      ),
      billingAddress: TamaraAddress(
        city: "Riyadh",
        countryCode: "SA",
        firstName: "Mona",
        lastName: "Lisa",
        line1: "3764 Al Urubah Rd",
        line2: "string",
        phoneNumber: "532298658",
        region: "As Sulimaniyah",
      ),
      shippingAddress: TamaraAddress(
        city: "Riyadh",
        countryCode: "SA",
        firstName: "Mona",
        lastName: "Lisa",
        line1: "3764 Al Urubah Rd",
        line2: "string",
        phoneNumber: "532298658",
        region: "As Sulimaniyah",
      ),
      platform: "Flutter App",
      isMobile: true,
      locale: "en_US",
      riskAssessment: TamaraRiskAssessment(
        customerAge: 22,
        customerDob: "31-01-2000",
        customerGender: "Male",
        customerNationality: "SA",
        isPremiumCustomer: true,
        isExistingCustomer: true,
        isGuestUser: true,
        accountCreationDate: "31-01-2019",
        platformAccountCreationDate: "31-01-2019",
        dateOfFirstTransaction: "31-01-2019",
        isCardOnFile: true,
        isCODcustomer: true,
        hasDeliveredOrder: true,
        isPhoneVerified: true,
        isFraudulentCustomer: true,
        totalLtv: 501.5,
        totalOrderCount: 12,
        orderAmountLast3months: 301.5,
        orderCountLast3months: 2,
        lastOrderDate: "31-01-2021",
        lastOrderAmount: 301.5,
        rewardProgramEnrolled: true,
        rewardProgramPoints: 300,
        phoneVerified: false,
      ),
      additionalData: {
        "delivery_method": "home delivery",
        "pickup_store": "Store A",
        "store_code": "Store code A",
        "vendor_amount": 0,
        "merchant_settlement_amount": 0,
        "vendor_reference_code": "AZ1234",
      },
    );
  }
}
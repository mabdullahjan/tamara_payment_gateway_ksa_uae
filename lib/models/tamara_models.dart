class TamaraOrderRequest {
  final TamaraAmount totalAmount;
  final TamaraAmount shippingAmount;
  final TamaraAmount taxAmount;
  final String orderReferenceId;
  final String orderNumber;
  final TamaraDiscount discount;
  final List<TamaraOrderItem> items;
  final TamaraConsumer consumer;
  final String countryCode;
  final String description;
  final String paymentType;
  final int instalments;
  final TamaraMerchantUrl merchantUrl;
  final TamaraAddress billingAddress;
  final TamaraAddress shippingAddress;
  final String platform;
  final bool isMobile;
  final String locale;
  final TamaraRiskAssessment riskAssessment;
  final Map<String, dynamic> additionalData;

  TamaraOrderRequest({
    required this.totalAmount,
    required this.shippingAmount,
    required this.taxAmount,
    required this.orderReferenceId,
    required this.orderNumber,
    required this.discount,
    required this.items,
    required this.consumer,
    required this.countryCode,
    required this.description,
    required this.paymentType,
    required this.instalments,
    required this.merchantUrl,
    required this.billingAddress,
    required this.shippingAddress,
    required this.platform,
    required this.isMobile,
    required this.locale,
    required this.riskAssessment,
    required this.additionalData,
  });

  Map<String, dynamic> toJson() => {
    "total_amount": totalAmount.toJson(),
    "shipping_amount": shippingAmount.toJson(),
    "tax_amount": taxAmount.toJson(),
    "order_reference_id": orderReferenceId,
    "order_number": orderNumber,
    "discount": discount.toJson(),
    "items": items.map((item) => item.toJson()).toList(),
    "consumer": consumer.toJson(),
    "country_code": countryCode,
    "description": description,
    "payment_type": paymentType,
    "instalments": instalments,
    "merchant_url": merchantUrl.toJson(),
    "billing_address": billingAddress.toJson(),
    "shipping_address": shippingAddress.toJson(),
    "platform": platform,
    "is_mobile": isMobile,
    "locale": locale,
    "risk_assessment": riskAssessment.toJson(),
    "additional_data": additionalData,
  };
}

class TamaraAmount {
  final double amount;
  final String currency;

  TamaraAmount({required this.amount, this.currency = "SAR"});

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
  };
}

class TamaraDiscount {
  final TamaraAmount amount;
  final String name;

  TamaraDiscount({required this.amount, required this.name});

  Map<String, dynamic> toJson() => {
    "amount": amount.toJson(),
    "name": name,
  };
}

class TamaraOrderItem {
  final String name;
  final String type;
  final String referenceId;
  final String sku;
  final int quantity;
  final TamaraAmount discountAmount;
  final TamaraAmount taxAmount;
  final TamaraAmount unitPrice;
  final TamaraAmount totalAmount;

  TamaraOrderItem({
    required this.name,
    required this.type,
    required this.referenceId,
    required this.sku,
    required this.quantity,
    required this.discountAmount,
    required this.taxAmount,
    required this.unitPrice,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "reference_id": referenceId,
    "sku": sku,
    "quantity": quantity,
    "discount_amount": discountAmount.toJson(),
    "tax_amount": taxAmount.toJson(),
    "unit_price": unitPrice.toJson(),
    "total_amount": totalAmount.toJson(),
  };
}

class TamaraConsumer {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  TamaraConsumer({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
  };
}

class TamaraMerchantUrl {
  final String cancel;
  final String failure;
  final String success;
  final String notification;

  TamaraMerchantUrl({
    required this.cancel,
    required this.failure,
    required this.success,
    required this.notification,
  });

  Map<String, dynamic> toJson() => {
    "cancel": cancel,
    "failure": failure,
    "success": success,
    "notification": notification,
  };
}

class TamaraAddress {
  final String city;
  final String countryCode;
  final String firstName;
  final String lastName;
  final String line1;
  final String line2;
  final String phoneNumber;
  final String region;

  TamaraAddress({
    required this.city,
    required this.countryCode,
    required this.firstName,
    required this.lastName,
    required this.line1,
    required this.line2,
    required this.phoneNumber,
    required this.region,
  });

  Map<String, dynamic> toJson() => {
    "city": city,
    "country_code": countryCode,
    "first_name": firstName,
    "last_name": lastName,
    "line1": line1,
    "line2": line2,
    "phone_number": phoneNumber,
    "region": region,
  };
}

class TamaraRiskAssessment {
  final int customerAge;
  final String customerDob;
  final String customerGender;
  final String customerNationality;
  final bool isPremiumCustomer;
  final bool isExistingCustomer;
  final bool isGuestUser;
  final String accountCreationDate;
  final String platformAccountCreationDate;
  final String dateOfFirstTransaction;
  final bool isCardOnFile;
  final bool isCODcustomer;
  final bool hasDeliveredOrder;
  final bool isPhoneVerified;
  final bool isFraudulentCustomer;
  final double totalLtv;
  final int totalOrderCount;
  final double orderAmountLast3months;
  final int orderCountLast3months;
  final String lastOrderDate;
  final double lastOrderAmount;
  final bool rewardProgramEnrolled;
  final int rewardProgramPoints;
  final bool phoneVerified;

  TamaraRiskAssessment({
    required this.customerAge,
    required this.customerDob,
    required this.customerGender,
    required this.customerNationality,
    required this.isPremiumCustomer,
    required this.isExistingCustomer,
    required this.isGuestUser,
    required this.accountCreationDate,
    required this.platformAccountCreationDate,
    required this.dateOfFirstTransaction,
    required this.isCardOnFile,
    required this.isCODcustomer,
    required this.hasDeliveredOrder,
    required this.isPhoneVerified,
    required this.isFraudulentCustomer,
    required this.totalLtv,
    required this.totalOrderCount,
    required this.orderAmountLast3months,
    required this.orderCountLast3months,
    required this.lastOrderDate,
    required this.lastOrderAmount,
    required this.rewardProgramEnrolled,
    required this.rewardProgramPoints,
    required this.phoneVerified,
  });

  Map<String, dynamic> toJson() => {
    "customer_age": customerAge,
    "customer_dob": customerDob,
    "customer_gender": customerGender,
    "customer_nationality": customerNationality,
    "is_premium_customer": isPremiumCustomer,
    "is_existing_customer": isExistingCustomer,
    "is_guest_user": isGuestUser,
    "account_creation_date": accountCreationDate,
    "platform_account_creation_date": platformAccountCreationDate,
    "date_of_first_transaction": dateOfFirstTransaction,
    "is_card_on_file": isCardOnFile,
    "is_COD_customer": isCODcustomer,
    "has_delivered_order": hasDeliveredOrder,
    "is_phone_verified": isPhoneVerified,
    "is_fraudulent_customer": isFraudulentCustomer,
    "total_ltv": totalLtv,
    "total_order_count": totalOrderCount,
    "order_amount_last3months": orderAmountLast3months,
    "order_count_last3months": orderCountLast3months,
    "last_order_date": lastOrderDate,
    "last_order_amount": lastOrderAmount,
    "reward_program_enrolled": rewardProgramEnrolled,
    "reward_program_points": rewardProgramPoints,
    "phone_verified": phoneVerified,
  };
}

class TamaraCheckoutResponse {
  final String orderId;
  final String checkoutId;
  final String checkoutUrl;
  final String status;

  TamaraCheckoutResponse({
    required this.orderId,
    required this.checkoutId,
    required this.checkoutUrl,
    required this.status,
  });

  factory TamaraCheckoutResponse.fromJson(Map<String, dynamic> json) {
    return TamaraCheckoutResponse(
      orderId: json['order_id'] ?? '',
      checkoutId: json['checkout_id'] ?? '',
      checkoutUrl: json['checkout_url'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

import 'package:project/paystack/api_key.dart';
import 'package:project/ui/utils/log_utils.dart';

class PayStackpayment {
  static final String baseUrl = "https://api.paystack.co";
  final firebase = FirebaseFirestore.instance;

// save account info to firestore
  Future<void> saveAccountInfo(
      {String userid,
      String accountName,
      String bankName,
      String accountNumber,
      String bankCode}) async {
    await firebase.collection("users_acccount_details").doc(userid).set({
      "accountName": accountName,
      "bankCode": bankCode,
      "accountNumber": accountNumber,
      "bankName": bankName
    });
  }

  static Future<String> getAccountName(
      int accountNumber, String bankCode) async {
    final http.Response response = await http.get(
        baseUrl +
            "/bank/resolve?account_number=$accountNumber&bank_code=$bankCode",
        headers: setHeaders(PAYSTACK_API_KEY));
    Map<String, dynamic> decodeJson = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decodeJson["status"] ?? false) {
        logger.d(decodeJson);
        return decodeJson["data"]["account_name"];
      }
      throw decodeJson["message"];
    }
    throw decodeJson["message"];
  }

  // get all nigerian banks fromn paystack
  static Future<Map<String, String>> getAllBanks() async {
    final http.Response response = await http.get(baseUrl + "/bank",
        headers: setHeaders(PAYSTACK_API_KEY));
    Map<String, dynamic> decodeJson = json.decode(response.body);
    // List<Banks> banks = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      // logger.d(response.statusCode);
      // logger.d(decodeJson);
      if (decodeJson["status"] ?? false) {
        Map<String, String> bbanks = {};

        decodeJson["data"].forEach((val) {
          bbanks[val["name"]] = val["code"];
        });
        return bbanks;
      }
      return {};
    }
    throw response.reasonPhrase;
  }
// to verify txn

  Future<bool> verifyTransaction(String reference) async {
    final http.Response response = await http.get(
        baseUrl + "/verify/$reference",
        headers: setHeaders(PAYSTACK_API_KEY));
    Map<String, dynamic> decodeJson = json.decode(response.body);
    logger.d(response.statusCode);
    logger.d(decodeJson);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decodeJson["status"]) {
        return true;
      }
      throw decodeJson["message"];
    }
    throw decodeJson["message"];
  }

// to initialise transaction
  static Future<SplitPaymentResponse> getAccessCode(
      {String emailAddress, String amount}) async {
    // to get reference and access code
    final http.Response response = await http.post(
        baseUrl + "/transaction/initialize",
        headers: setHeaders(PAYSTACK_API_KEY),
        body: json.encode({"email": emailAddress, "amount": amount}));
    Map<String, dynamic> decodeJson = json.decode(response.body);
    logger.d(response.statusCode);
    logger.d(decodeJson);
    if (response.statusCode == 200) {
      if (decodeJson["status"]) {
        return SplitPaymentResponse.fromMap(decodeJson["data"]);
      }
      throw (decodeJson["message"]);
    }
    throw (decodeJson["message"]);
  }

// check if user has subAccount for split payment
  Future<bool> hasSubAccount(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebase.collection("users").doc(userId).get();
    Map<String, dynamic> data = documentSnapshot.data();
    // sub account is the identifier for split paymemnt
    if (data["subAccount"] == null || data["subAccount"].isEmpty) {
      return false;
    }
    return true;
  }

// add subAccount  to firesetore
  Future<void> addSubAccount(String userId, String subAccount) async {
    firebase
        .collection("users")
        .doc(userId)
        .set({"subAccount": subAccount}, SetOptions(merge: true));
  }

  // create sub Account from paystack

  static Future<SubAccount> createSubAccount(
      {String businessName,
      String bankCode,
      String accountNumber,
      double percentCharge}) async {
    final http.Response response = await http.post(baseUrl + "/subaccount",
        body: json.encode({
          "business_name": businessName,
          "bank_code": bankCode,
          "account_number": accountNumber,
          "percentage_charge": percentCharge
        }),
        headers: setHeaders(PAYSTACK_API_KEY));
    Map<String, dynamic> decodeJson = json.decode(response.body);
    logger.d(response.statusCode);
    logger.d(decodeJson);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decodeJson["status"]) {
        return SubAccount.fromMap(decodeJson["data"]);
      }
      throw (decodeJson["message"]);
    }
    throw (decodeJson["message"]);
  }

// Perform split paymennt
  static Future<SplitPaymentResponse> performSplitPayment(
      {String amount, String subaccountCode, String emailAddress}) async {
    final http.Response response = await http.post(
        baseUrl + "/transaction/initialize",
        body: json.encode({
          "subaccount": subaccountCode,
          "amount": amount,
          "email": emailAddress
        }),
        headers: setHeaders(PAYSTACK_API_KEY));
    Map<String, dynamic> decodeJson = json.decode(response.body);
    logger.d(response.statusCode);
    logger.d(decodeJson);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decodeJson["status"]) {
        return SplitPaymentResponse.fromMap(decodeJson["data"]);
      }
      throw (decodeJson["message"]);
    }
    throw (decodeJson["message"]);
  }

  static setHeaders(String token) =>
      {'Content-type': 'application/json', 'Authorization': 'Bearer $token'};
}

// ---------------->>>>>>>>>>>MODELS----------------->>>>>>>>>>>>>>>>>>>>>>>>>>
class Banks {
  final String name;
  final String bankCode;
  final int bankId;

  Banks({
    @required this.name,
    @required this.bankCode,
    @required this.bankId,
  });

  Banks copyWith({
    String name,
    String bankCode,
    int bankId,
  }) {
    return Banks(
      name: name ?? this.name,
      bankCode: bankCode ?? this.bankCode,
      bankId: bankId ?? this.bankId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': bankCode,
      'id': bankId,
    };
  }

  factory Banks.fromMap(Map<String, dynamic> map) {
    return Banks(
      name: map['name'],
      bankCode: map['code'],
      bankId: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Banks.fromJson(String source) => Banks.fromMap(json.decode(source));

  @override
  String toString() =>
      'Banks(name: $name, bankCode: $bankCode, bankId: $bankId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Banks &&
        other.name == name &&
        other.bankCode == bankCode &&
        other.bankId == bankId;
  }

  @override
  int get hashCode => name.hashCode ^ bankCode.hashCode ^ bankId.hashCode;
}

class SplitPaymentResponse {
  final String reference;
  final String accessCode;

  SplitPaymentResponse({this.reference, this.accessCode});

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'access_code': accessCode,
    };
  }

  factory SplitPaymentResponse.fromMap(Map<String, dynamic> map) {
    return SplitPaymentResponse(
      reference: map['reference'],
      accessCode: map['access_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SplitPaymentResponse.fromJson(String source) =>
      SplitPaymentResponse.fromMap(json.decode(source));
}

class SubAccount {
  String businessName;
  String accountNumber;
  double percentageCharge;
  String settlementBank;
  int integration;
  String domain;
  String subaccountCode;
  bool isVerified;
  String settlementSchedule;
  bool active;
  bool migrate;
  int id;
  String createdAt;
  String updatedAt;

  SubAccount(
      {this.businessName,
      this.accountNumber,
      this.percentageCharge,
      this.settlementBank,
      this.integration,
      this.domain,
      this.subaccountCode,
      this.isVerified,
      this.settlementSchedule,
      this.active,
      this.migrate,
      this.id,
      this.createdAt,
      this.updatedAt});

  SubAccount.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    accountNumber = json['account_number'];
    percentageCharge = json['percentage_charge'];
    settlementBank = json['settlement_bank'];
    integration = json['integration'];
    domain = json['domain'];
    subaccountCode = json['subaccount_code'];
    isVerified = json['is_verified'];
    settlementSchedule = json['settlement_schedule'];
    active = json['active'];
    migrate = json['migrate'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['account_number'] = this.accountNumber;
    data['percentage_charge'] = this.percentageCharge;
    data['settlement_bank'] = this.settlementBank;
    data['integration'] = this.integration;
    data['domain'] = this.domain;
    data['subaccount_code'] = this.subaccountCode;
    data['is_verified'] = this.isVerified;
    data['settlement_schedule'] = this.settlementSchedule;
    data['active'] = this.active;
    data['migrate'] = this.migrate;
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'accountNumber': accountNumber,
      'percentageCharge': percentageCharge,
      'settlementBank': settlementBank,
      'integration': integration,
      'domain': domain,
      'subaccountCode': subaccountCode,
      'isVerified': isVerified,
      'settlementSchedule': settlementSchedule,
      'active': active,
      'migrate': migrate,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory SubAccount.fromMap(Map<String, dynamic> map) {
    return SubAccount(
      businessName: map['businessName'],
      accountNumber: map['accountNumber'],
      percentageCharge: map['percentageCharge'],
      settlementBank: map['settlementBank'],
      integration: map['integration'],
      domain: map['domain'],
      subaccountCode: map['subaccountCode'],
      isVerified: map['isVerified'],
      settlementSchedule: map['settlementSchedule'],
      active: map['active'],
      migrate: map['migrate'],
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}

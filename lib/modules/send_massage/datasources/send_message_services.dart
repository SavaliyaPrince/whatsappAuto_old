import 'dart:developer';

import 'package:whatsapp_auto/helper/network_helper.dart';
import 'package:whatsapp_auto/modules/send_massage/datasources/country_code_model.dart';

class SendMessageService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<CountryCodeModel> getCountryCode() async {
    try {
      final result = await _networkAPICall.get('http://ip-api.com/json');
      if (result != null) {
        return CountryCodeModel.fromJson(result);
      }
    } catch (e) {
      log("Error : $e");
    }
    return CountryCodeModel();
  }
}

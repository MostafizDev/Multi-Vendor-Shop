import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/config_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  SplashRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getConfig() async {
    try {
      final response = await dioClient.get(AppConstants.CONFIG_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  void initSharedData(ConfigModel configModel) async {
    if (!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    if (!sharedPreferences.containsKey(AppConstants.SEARCH_ADDRESS)) {
      sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, []);
    }
    if (!sharedPreferences.containsKey(AppConstants.CURRENCY)) {
      sharedPreferences.setString(
          AppConstants.CURRENCY, configModel.currencyList[0].code);
    }
  }

  String getCurrency(ConfigModel configModel) {
    return sharedPreferences.getString(AppConstants.CURRENCY) ??
        configModel.currencyList[0].code;
  }

  void setCurrency(String currencyCode) {
    sharedPreferences.setString(AppConstants.CURRENCY, currencyCode);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tinygrove_android_app/models/customer.dart';
import 'package:tinygrove_android_app/models/login_model.dart';
import 'package:tinygrove_android_app/models/category.dart';

import 'config.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode(Config.key + ":" + Config.secret),
    );

    bool ret = false;

    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }

    return ret;
  }

  Future<LoginResponseModel?> loginCustomer(
      String username, String password) async {
    try {
      var response = await Dio().post(
        Config.tokenURL,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        // Handle non-200 responses
        print("Error: Unexpected response status ${response.statusCode}");
      }
    } on DioError catch (e) {
      // Log Dio-specific errors
      print("DioError: ${e.message}");
    } catch (e) {
      // Log general errors
      print("Error: $e");
    }

    // Return null if there's an error or no data
    return null;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = [];

    try {
      String url = Config.url +
          Config.categoriesURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";

      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }

    return data;
  }
}

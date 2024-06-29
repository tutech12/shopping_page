import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ApiCall {

  Future<dynamic> fetchAPI() async {
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url="https://dummyjson.com/products";
    dynamic result;
    try{

      var response = await dio.get(url);
      if(kDebugMode){
        print("Url = $url\nResponse = $response");
      }
      if (response.statusCode == 200) {
        result = json.decode(response.data.toString());
      }
    } on DioException catch (e){
      debugPrint(e.message);
    }

    return result;

  }


}

import 'dart:convert';

import 'package:dio/dio.dart';

import '../keys.dart';

class NetworkHelper{
  //constructor
  //NetworkHelper({required this.url});

  //final String url;

  Future getData() async{
    Response response;
    var dio = Dio();
    response = await dio.request("https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo&per_page=20&category=nature");
    return (response.data);

    if(response.statusCode == 200){
      String data = response.toString();
      jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }

}
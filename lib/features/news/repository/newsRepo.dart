import 'package:dio/dio.dart';
import 'package:newsapp/user/model/newsModel.dart';
import 'package:newsapp/util/config/dioConfig.dart';

class NewsRepo{
  static Future<List<NewsModel>> getTopHeadLines([String country = 'us']) async{
    try{
      final client = DioConfig.getClientOrg();
      Response response = await client.get(DioConfig.getNewsEndPoint('top-headlines?country=$country'));

      return List<NewsModel>.from(response.data['articles'].map((data) => NewsModel.fromJson(data)));
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  static Future<List<NewsModel>> getSimilarNews(String title) async{
    try{
      final client = DioConfig.getClientOrg();
      Response response = await client.get(DioConfig.getNewsEndPoint('everything?sources=$title'));

      return List<NewsModel>.from(response.data['articles'].map((data) => NewsModel.fromJson(data)));
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  static Future<List<NewsModel>> getCategoryNews(String category) async{
    try{
      final client = DioConfig.getClientOrg();
      Response response = await client.get(DioConfig.getNewsEndPoint('sources?category=$category'));
      print(response.data);
      return List<NewsModel>.from(response.data['articles'].map((data) => NewsModel.fromJson(data)));
    }catch(e){
      print(e.toString());
      return [];
    }
  }
}
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioConfig{

  static Dio getClient ([bool includeOptions = true]) {
    Dio dio = new Dio();
    if(includeOptions){
      dio.options = BaseOptions(
        headers: {
          'X-Api-Key' : env['NEWS_API_KEY']
        }
      );
      return dio;
    }else{
      return dio;
    }

  }

  static String getNewsEndPoint(String? apiLink) => env['NEWS_API']! + apiLink!;
  static String getAuthEndPoint() => env['RANDOM_USER_API']!;
}
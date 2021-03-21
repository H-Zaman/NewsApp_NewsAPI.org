import 'package:dio/dio.dart';
import 'package:newsapp/user/model/userModel.dart';
import 'package:newsapp/util/config/dioConfig.dart';

class AuthRepo{
  static Future<UserModel?> loginUser() async{
    try{
      final client = DioConfig.getClientOrg(false);
      Response response = await client.get(
        DioConfig.getAuthEndPoint()
      );

      return UserModel.fromJson(response.data['results'][0]);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
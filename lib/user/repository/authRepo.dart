import 'package:dio/dio.dart';
import 'package:newsapp/user/model/userModel.dart';
import 'package:newsapp/user/viewModel/userViewModel.dart';
import 'package:newsapp/util/config/dioConfig.dart';

class AuthRepo{
  static Future<bool> loginUser() async{
    try{
      final client = DioConfig.getClient(false);
      Response response = await client.get(
        DioConfig.getAuthEndPoint()
      );
      UserViewModel.setUser(UserModel.fromJson(response.data['results'][0]));
      return false;
    }catch(e){
      print(e.toString());
      return true;
    }
  }
}
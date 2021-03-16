import 'package:newsapp/user/model/userModel.dart';
import 'package:get/get.dart';

class UserViewModel{
  static var user = UserModel(gender: 'gender', name: 'name', email: '', dob: DateTime.now(), phone: 'phone', picture: 'picture', nat: 'nat').obs;
  static setUser(UserModel userData) => user.value = userData;
}
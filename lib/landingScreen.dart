import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/user/model/userModel.dart';
import 'package:newsapp/user/repository/authRepo.dart';
import 'package:newsapp/user/view/homeScreen.dart';
import 'package:newsapp/util/widgets/loadingOverLay.dart';

import 'user/viewModel/userViewModel.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return IsScreenLoading(
      screenLoading: loading,
      child: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () async{
              setState(() {
                loading = true;
              });

              UserModel? user = await AuthRepo.loginUser();
              UserViewModel.setUser(user!);

              Get.offAll(()=>HomeScreen());

              setState(() {
                loading = false;
              });
            },
            child: Text(
                'Login'
            ),
          ),
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/user/repository/authRepo.dart';
import 'package:newsapp/user/view/homeScreen.dart';
import 'package:newsapp/util/widgets/loadingOverLay.dart';

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

              bool error = await AuthRepo.loginUser();

              if(error){
                Get.rawSnackbar(title: 'Error',message: 'Failed to login');
              }else{
                Get.offAll(()=>HomeScreen());
              }

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

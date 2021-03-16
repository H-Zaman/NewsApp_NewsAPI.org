import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsapp/landingScreen.dart';


main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await load();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LandingScreen(),
      theme: ThemeData(
        fontFamily: 'L'
      ),
    );
  }
}


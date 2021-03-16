import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsapp/features/news/repository/newsRepo.dart';
import 'package:newsapp/user/model/newsModel.dart';

import 'widgets/bottomSection.dart';
import 'widgets/topSection.dart';

class HomeViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NewsRepo.getTopHeadLines(),
      builder: (_, AsyncSnapshot<List<NewsModel>> snapshot){
        if(snapshot.hasData && snapshot.data!.length > 0){
          return Column(
            children: [
              TopSection(news: snapshot.data![0], index: 0),
              BottomSection(data: snapshot.data!.sublist(1,snapshot.data!.length),)
            ],
          );
        }else{
          return  SpinKitWave(color: Colors.redAccent,);
        }
      },
    );
  }
}

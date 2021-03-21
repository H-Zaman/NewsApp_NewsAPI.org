import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:newsapp/features/home/view/widgets/bottomSection.dart';
import 'package:newsapp/features/news/repository/newsRepo.dart';
import 'package:newsapp/user/model/newsModel.dart';
import 'package:newsapp/user/model/userModel.dart';
import 'package:newsapp/user/repository/authRepo.dart';
import 'package:newsapp/util/helper/stringHelepr.dart';
import 'package:newsapp/util/resources/_demo.dart';

class NewsScreen extends StatelessWidget {
  final NewsModel news;
  final int index;
  final String? labelText;
  const NewsScreen({Key? key,required this.news, required this.index, this.labelText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: Colors.black12,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              CupertinoIcons.arrow_left,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox.expand(),
          Stack(
            children: [
              Hero(
                tag: '${news.urlToImage}+$index',
                child: Container(
                  height: Get.height * .55,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        news.urlToImage == '' ? Demo.demoNewsImage : news.urlToImage
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(.3),
                            Colors.black.withOpacity(.25),
                            Colors.black.withOpacity(.2),
                            Colors.black.withOpacity(.15),
                            Colors.black.withOpacity(.1),
                            Colors.black.withOpacity(.05),
                            Colors.black.withOpacity(.01),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter
                      )
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(25, Get.height * .265, 25, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title,
                  maxLines: 3,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'B',
                      fontSize: 32,
                      color: Colors.white
                  ),
                ),
                Text(
                  ' - ' + news.source.name,
                  style: TextStyle(
                    fontFamily: 'R',
                    color: Colors.white54
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  news.content,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'R',
                    color: Colors.white54
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Get.height * .51,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                )
              ),
              padding: EdgeInsets.fromLTRB(25,25,25,0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NewsAuthorWidget(),

                      Container(
                        height: 45,
                        width: Get.width * .2,
                        decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                            ),
                            Text(
                              StringHelper.newsTimeSimple(news.publishedAt),
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontFamily: 'B'
                              ),
                            )
                          ]
                        ),
                      ),

                      Container(
                        height: 45,
                        width: Get.width * .23,
                        decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                            ),
                            Text(
                              '${Random().nextInt(10000)}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontFamily: 'B'
                              ),
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    news.description + ' '+ news.content,
                    style: TextStyle(
                      fontFamily: 'R'
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Similar news',
                    style: TextStyle(
                        fontFamily: 'B',
                        fontSize: 22
                    ),
                  ),
                  SizedBox(height: 20),
                  FutureBuilder(
                    future: NewsRepo.getSimilarNews(news.source.name),
                    builder: (_,AsyncSnapshot<List<NewsModel>> snapshot){
                      if(snapshot.hasData && snapshot.data!.length > 0){
                        return Container(
                          height: Get.height * .32,
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) => NewsBlockWidget(news: snapshot.data![index], index: index)
                          ),
                        );
                      }else{
                        return  SpinKitWave(color: Colors.redAccent,);
                      }
                    },
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NewsAuthorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthRepo.loginUser(),
      builder: (_, AsyncSnapshot<UserModel?> snapshot){
        if(snapshot.hasData){
          return Container(
            height: 45,
            width: Get.width * .4,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.all(4),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 40/35,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            snapshot.data!.picture
                        ),
                        fit: BoxFit.cover
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Text(
                    snapshot.data!.name,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'R'
                    ),
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }
}


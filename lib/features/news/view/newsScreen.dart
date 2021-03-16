import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/user/model/newsModel.dart';
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
          Container(
            padding: EdgeInsets.fromLTRB(25, Get.height * .3, 25, 25),
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
                  ' - ' + news.author,
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
            top: Get.height * .5,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}

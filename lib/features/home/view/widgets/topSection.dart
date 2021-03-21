import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/features/news/view/newsScreen.dart';
import 'package:newsapp/user/model/newsModel.dart';

class TopSection extends StatelessWidget {
  final NewsModel news;
  final int index;

  const TopSection({Key? key,required this.news, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: '${news.urlToImage}+$index',
          child: Container(
            height: Get.height * .5,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  news.urlToImage
                ),
                fit: BoxFit.cover
              ),
            )
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
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
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.fromLTRB(25, Get.height * .22, 25, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(label: 'News of the day'),
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
                TextButton(
                  onPressed: () => Get.to(()=>NewsScreen(news: news, index: index)),
                  child: Row(
                    children: [
                      Text(
                        'Learn more',
                        style: TextStyle(
                            fontFamily: 'B+',
                            color: Colors.white
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.white,
                        size: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Label extends StatelessWidget {
  final String label;

  const Label({Key? key,required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'R',
          fontSize: 14
        ),
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/features/news/view/newsScreen.dart';
import 'package:newsapp/user/model/newsModel.dart';
import 'package:newsapp/util/helper/stringHelepr.dart';
import 'package:newsapp/util/resources/_demo.dart';

class BottomSection extends StatelessWidget {
  final List<NewsModel> data;

  const BottomSection({Key? key,required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25,20,25,16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking news',
                style: TextStyle(
                  fontFamily: 'B',
                  fontSize: 22
                ),
              ),
              TextButton(
                onPressed: (){},
                child: Text(
                  'More',
                  style: TextStyle(
                    fontFamily: 'B+',
                    color: Colors.black
                  ),
                ),
              )
            ],
          ),
          Container(
            height: Get.height * .32,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => NewsBlockWidget(news: data[index], index: index)
            ),
          )
        ],
      ),
    );
  }
}

class NewsBlockWidget extends StatelessWidget {
  final NewsModel news;
  final int index;

  const NewsBlockWidget({Key? key,required this.news, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(()=>NewsScreen(news: news, index: index)),
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          width: Get.width * .55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: '${news.urlToImage}+$index',
                child: Container(
                  width: Get.width * .55,
                  height: Get.height * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        news.urlToImage == '' ? Demo.demoNewsImage : news.urlToImage
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
              Text(
                news.title,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontFamily: 'B',
                  fontSize: 18
                ),
              ),
              Text(
                StringHelper.newsTime(news.publishedAt),
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'R'
                ),
              ),
              Text(
                'By ${news.source.name}',
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'R'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

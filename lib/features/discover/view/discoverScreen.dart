import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:newsapp/features/news/repository/newsRepo.dart';
import 'package:newsapp/user/model/newsModel.dart';
import 'package:newsapp/util/resources/_demo.dart';

class DiscoverScreen extends StatelessWidget {
  final categories = [
    'all','business','entertainment','general','health','science','sports','technology'
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Discover',
                style: TextStyle(
                  fontSize: 42,
                  fontFamily: 'B'
                ),
              ),
              Text(
                'News from all over the word',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'R',
                  color: Colors.grey
                ),
              ),

              SizedBox(height: 14),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'R'
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  prefixIcon: Icon(CupertinoIcons.search,color: Colors.grey),
                  suffixIcon: Icon(CupertinoIcons.text_insert,color: Colors.grey),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black
                    )
                  )
                ),
                child: TabBar(
                  tabs: categories.map((e) => Tab(text: e.capitalize)).toList(),
                  isScrollable: true,
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontFamily: 'B',
                    fontSize: 18
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: 'R',
                    fontSize: 18
                  ),
                ),
              ),
              SizedBox(height: 14),

              Expanded(
                child: TabBarView(
                  children: categories.map((e) => FutureBuilder(
                    future: NewsRepo.getCategoryNews(e),
                    builder: (_, AsyncSnapshot<List<NewsModel>> snapshot){
                      if(snapshot.hasData && snapshot.data!.length > 0){
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index)=> NewsListTile(news: snapshot.data![index],),
                        );
                      }else{
                        return SpinKitWave(color: Colors.redAccent);
                      }
                    },
                  )).toList(),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}

class NewsListTile extends StatelessWidget {
  final NewsModel news;

  const NewsListTile({Key? key,required this.news}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      news.urlToImage == '' ? Demo.demoNewsImage : news.urlToImage
                  )
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}

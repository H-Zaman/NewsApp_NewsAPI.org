import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:newsapp/features/discover/view/discoverScreen.dart';
import 'package:newsapp/features/home/view/homeViewScreen.dart';
import 'package:newsapp/features/profie/view/profileScreen.dart';
import 'package:newsapp/landingScreen.dart';
import 'package:newsapp/user/viewModel/userViewModel.dart';

class HomeScreen extends StatelessWidget {
  static final drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: drawerController,
      style: DrawerStyle.Style3,
      menuScreen: HomeDrawer(),
      mainScreen: HomeBody(),
      borderRadius: 24.0,
      showShadow: true,
      mainScreenScale: .1,
      slideWidth: MediaQuery.of(context).size.width,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }
}

class HomeBody extends StatelessWidget {

  static RxInt pageIndex = 0.obs;
  static changeIndex(int? index) => pageIndex.value = index!;

  final _screens = [HomeViewScreen(), DiscoverScreen()/*, ProfileScreen()*/];

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        bool isOpen = HomeScreen.drawerController.isOpen!();
        if(isOpen){
          HomeScreen.drawerController.toggle!();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              color: Colors.black12,
              child: IconButton(
                onPressed: (){
                  HomeScreen.drawerController.toggle!();
                },
                icon: Icon(
                  CupertinoIcons.line_horizontal_3,
                ),
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Obx(()=>IndexedStack(
          children: _screens,
          index: HomeBody.pageIndex.value,
        )),
        bottomNavigationBar: Obx(()=>BottomNavigationBar(
          currentIndex: HomeBody.pageIndex.value,
          onTap: HomeBody.changeIndex,
          unselectedLabelStyle: TextStyle(
            fontFamily: 'R'
          ),
          selectedLabelStyle: TextStyle(
            fontFamily: 'R'
          ),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.home_outlined
                ),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.search
                ),
                label: 'Discover'
            ),
        /*    BottomNavigationBarItem(
                icon: Icon(
                    Icons.person_outline
                ),
                label: 'Profile'
            ),*/
          ],
        )),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    UserViewModel.user.value!.picture
                  )
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white54,
                    spreadRadius: 3,
                    blurRadius: 2,
                  )
                ]
              ),
            ),
            SizedBox(height: 20),
            Text(
              UserViewModel.user.value!.name,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'B',
                fontSize: 22
              ),
            ),
            SizedBox(height: 10),
            Text(
              '✉  '+UserViewModel.user.value!.email,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'R',
                fontSize: 14
              ),
            ),
            SizedBox(height: 10),
            Text(
              '📞  '+UserViewModel.user.value!.phone,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'R',
                  fontSize: 14
              ),
            ),

            Spacer(),
            ListTile(
              onTap: (){
                Get.dialog(Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Confirm Logout?',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'R'
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(onPressed: ()=>Get.back(), icon: Icon(CupertinoIcons.clear), label: Text('Cancel'),style: ElevatedButton.styleFrom(primary: Colors.black),),
                            ElevatedButton.icon(onPressed: ()=>Get.offAll(LandingScreen()), icon: Icon(Icons.exit_to_app_rounded), label: Text('Confirm')),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
              },
              leading: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.white,
              ),
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0,
              title: Text(
                'Logout',
                style: TextStyle(
                  letterSpacing: 3,
                  color: Colors.white,
                  fontFamily: 'B',
                  fontSize: 18
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
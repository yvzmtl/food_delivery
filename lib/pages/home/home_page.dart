

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery/pages/home/main_food_page.dart';
import 'package:flutter_food_delivery/utils/colors.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  //late PersistentTabController _controller;
  List pages = [
    MainFoodPage(),
    CartPage(),
    Container(child: Center(child: Text("2. sayfa"),),),
    Container(child: Center(child: Text("3. sayfa"),),),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller = PersistentTabController(initialIndex: 0);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.signColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // selectedLabelStyle: TextStyle(fontSize: 12),
        // selectedFontSize: 0.0,
        // unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Anasayfa"
             ),
             BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "Siparişlerim"
             ),
             BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Sepetim"
             ),
             BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Hesabım"
             ),
        ]),
    );
  }
   

   
  //  List<Widget> _buildScreens() {
  //       return [
  //         MainFoodPage(),
  //         CartPage(),
  //         Container(child: Center(child: Text("2. sayfa"),),),
  //         Container(child: Center(child: Text("3. sayfa"),),),
  //       ];
  //   }

  //     List<PersistentBottomNavBarItem> _navBarsItems() {
  //       return [
  //           PersistentBottomNavBarItem(
  //               icon: Icon(Icons.home_outlined),
  //               title: ("Anasayfa"),
  //               activeColorPrimary: AppColors.mainColor,
  //               inactiveColorPrimary: CupertinoColors.systemGrey,
  //           ),
  //           PersistentBottomNavBarItem(
  //               icon: Icon(Icons.archive),
  //               title: ("Siparişlerim"),
  //               activeColorPrimary: AppColors.mainColor,
  //               inactiveColorPrimary: CupertinoColors.systemGrey,
  //           ),
  //           PersistentBottomNavBarItem(
  //               icon: Icon(Icons.shopping_cart),
  //               title: ("Sepetim"),
  //               activeColorPrimary: AppColors.mainColor,
  //               inactiveColorPrimary: CupertinoColors.systemGrey,
  //           ),
  //           PersistentBottomNavBarItem(
  //               icon: Icon(Icons.person),
  //               title: ("Hesabım"),
  //               activeColorPrimary: AppColors.mainColor,
  //               inactiveColorPrimary: CupertinoColors.systemGrey,
  //           ),
  //       ];
  //   }

  //  @override
  // Widget build(BuildContext context) {
  //   return PersistentTabView(
  //       context,
  //       controller: _controller,
  //       screens: _buildScreens(),
  //       items: _navBarsItems(),
  //       confineInSafeArea: true,
  //       backgroundColor: Colors.white, // Default is Colors.white.
  //       handleAndroidBackButtonPress: true, // Default is true.
  //       resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  //       stateManagement: true, // Default is true.
  //       hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  //       decoration: NavBarDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         colorBehindNavBar: Colors.white,
  //       ),
  //       popAllScreensOnTapOfSelectedTab: true,
  //       popActionScreens: PopActionScreensType.all,
  //       itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
  //         duration: Duration(milliseconds: 200),
  //         curve: Curves.ease,
  //       ),
  //       screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
  //         animateTabTransition: true,
  //         curve: Curves.ease,
  //         duration: Duration(milliseconds: 200),
  //       ),
  //       navBarStyle: NavBarStyle.style8, // Choose the nav bar style with this property.
  //   );
  // }

  
}
import 'package:dystopia_flutter_app/screens/account.dart';
import 'package:dystopia_flutter_app/screens/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/home_screen.dart';

import 'floating_action_helper.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex;
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = 0;
    final systemTheme = SystemUiOverlayStyle.light;
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  List iconList = <IconData>[
    Icons.home, // the pet market

    Icons.favorite, // user's favorites

    Icons.chat_bubble, // connects the user and pet owner

    Icons.account_circle, // user's details
  ];
  final List _screens = [
    HomePage2(),
    SavedPage(),
    Scaffold(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
      allowFontScaling: true,
    );
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: _screens[_bottomNavIndex],
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: GestureDetector(
          onTap: () {
            _animationController.reset();

            // logic to be implemented

            _animationController.forward();
          },
          child: CircleAvatar(
            backgroundColor: Color(0xFFb9815d),
            radius: 35.h,
            child: Image.asset(
              'assets/images/pet_logo.png',
              color: Colors.black,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FixedDockedFabLocation(context: context),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        height: 80.h,
        iconSize: 35.h,
        activeIndex: _bottomNavIndex,
        elevation: 10,
        backgroundColor: Colors.white, //Color(0xFFedf3eb),
        activeColor: Color(0xFFb9815d),
        splashColor: Color(0xFF875433),
        inactiveColor: Colors.grey,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.softEdge,
        gapLocation: GapLocation.end,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}

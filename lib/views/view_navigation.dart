import 'package:flutter/material.dart';

class NavigationIconView {

  Widget _icon;
  Color mColor;
  String _title;
  BottomNavigationBarItem item;
  AnimationController controller;
  Animation<double> _animation;
  Widget mIncludedWidget;

  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
    Widget page
  }) : _icon = icon,
        mColor = color,
        _title = title,
        item = BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: Text(title),
          backgroundColor: color,
        ),
        controller = AnimationController(
          duration: Duration(milliseconds: 200),
          vsync: vsync,
        ),
        mIncludedWidget = page
  {
    var curve_drive = CurveTween(
      curve: const Interval(0.5, 1.0,curve: Curves.fastOutSlowIn),
    );
    _animation = controller.drive(curve_drive);
  }

  FadeTransition transition(BottomNavigationBarType type,BuildContext context){
    Color iconColor;
    if(type == BottomNavigationBarType.fixed){
      iconColor = mColor;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    var rtn = FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.02, 0.0),
            end: Offset.zero,
          ),
        ),
        child: mIncludedWidget,
        /*child: IconTheme(
          data: IconThemeData(
            color:iconColor,
            size: 200.0,
          ),
          child: Semantics(
            label: 'PlaceHolder',
            child: mIncludedWidget,
          ),
        ),*/
      ),
    );

    return rtn;
  }
}
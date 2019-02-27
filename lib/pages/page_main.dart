import 'package:flutter/material.dart';
import 'package:from_downtown/views/view_navigation.dart';
import 'package:from_downtown/pages/page_typelist.dart';
import 'package:from_downtown/pages/page_setup.dart';

class DowntownPage extends StatefulWidget {

  DowntownPage({Key key}) : super(key:key);

  @override
  _DowntownPageState createState() => _DowntownPageState();

}

class _DowntownPageState extends State<DowntownPage>
  with TickerProviderStateMixin {

  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var navi1 = NavigationIconView(
      icon: const Icon(Icons.phone_android),
      activeIcon: const Icon(Icons.phone_android),
      title: 'CargoTypes',
//      color: Colors.deepOrange,
      vsync: this,
      page: TypeListPage(title : "first page"),
    );

    var navi2 = NavigationIconView(
      icon: const Icon(Icons.home),
      activeIcon: const Icon(Icons.home),
      title: 'Setup',
//      color: Colors.pink,
      vsync: this,
      page: UserSetupPage(title : "second page"),
    );

    _navigationViews = <NavigationIconView>[
      navi1,
      navi2
    ];

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for(NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  Widget _buildTransitionsStack(){
    final List<FadeTransition> transitions = <FadeTransition>[];


    for (int i=0;i<_navigationViews.length;i++){
      NavigationIconView view = _navigationViews[i];
      transitions.add(view.transition(_type, context));
//      view.transition(type, context)
    }

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    var rtn = Stack(
      children: transitions,
    );
    return rtn;
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    var botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    Color bkcolor = _navigationViews[_currentIndex].mColor;

    var appbar = AppBar(
      title: const Text('手机维修铺'),
      backgroundColor: bkcolor,
    );

    var body = Center(
      child: _navigationViews[_currentIndex].mIncludedWidget,
//      child: _buildTransitionsStack(),
    );

    var scaffold = Scaffold(
      appBar: appbar,
      body: body,
      bottomNavigationBar: botNavBar,
    );

    return scaffold;
  }
}

import 'package:flutter/material.dart';
import 'theme.dart';

class DowntownPage extends StatefulWidget {

  DowntownPage({Key key}) : super(key:key);

  @override
  _DowntownPageState createState() => _DowntownPageState();

}

class NavigationIconView {

  Widget _icon;
  Color _color;
  String _title;
  BottomNavigationBarItem item;
  AnimationController controller;
  Animation<double> _animation;

  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
  _color = color,
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
  )
  {
    var curve_drive = CurveTween(
      curve: const Interval(0.5, 1.0,curve: Curves.fastOutSlowIn),
    );
    _animation = controller.drive(curve_drive);
  }

  FadeTransition transition(BottomNavigationBarType type,BuildContext context){
    Color iconColor;
    if(type == BottomNavigationBarType.shifting){
      iconColor = _color;
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
              begin: const Offset(0.0, 0.02),
              end: Offset.zero,
            ),
          ),
          child: IconTheme(
              data: IconThemeData(
                color:iconColor,
                size: 120.0,
              ),
              child: Semantics(
                label: 'PlaceHolder',
                child: _icon,
              ),
          ),
      ),
    );

    return rtn;
  }
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
      color: Colors.deepOrange,
      vsync: this,
    );

    var navi2 = NavigationIconView(
      icon: const Icon(Icons.settings),
      activeIcon: const Icon(Icons.settings),
      title: 'Setup',
      color: Colors.pink,
      vsync: this,
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

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
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

    var appbar = AppBar(
      title: const Text('NewSmartCargoSys'),
    );

    var body = Center(
      child: _buildTransitionsStack(),
    );


    var scaffold = Scaffold(
      appBar: appbar,
      body: body,
      bottomNavigationBar: botNavBar,
    );

    return scaffold;
  }
}

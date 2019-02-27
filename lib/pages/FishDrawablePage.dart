import 'package:flutter/material.dart';
import 'dart:math';

import 'package:from_downtown/objs/PointF.dart';
import 'package:from_downtown/views/FishDrawableView.dart';
import 'package:from_downtown/views/CustomStarView.dart';

class FishDrawablePage extends StatefulWidget {

  FishDrawablePage({Key key}) : super(key:key);

  @override
  _FishDrawablePageState createState() => _FishDrawablePageState();

}

class _FishDrawablePageState extends State<FishDrawablePage> with SingleTickerProviderStateMixin
{

  AnimationController controller;
  Animation<double> animation;

  //lastTouch（即鱼当前所在位置）
  //thisTouch记录当前点击的位置（即鱼即将到达的位置）
  PointF middlepoint = new PointF(4.18 * 50, 4.18 * 50);
  PointF lastTouch = new PointF(0,0);
  PointF thisTouch = new PointF(0,0);
  double angle = 0;

  int clicks = 0;

  FishDrawableView _fishDrawableView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init constValue based on number of level

    controller = AnimationController(
        duration: const Duration(milliseconds: 5000),
        vsync: this);
    animation = Tween(
        begin: 0.0,
        end: 1.0).animate(controller)
      ..addListener((){
        setState(() {
          //fraction记录路径完成的进度
          double fraction = animation.value;
          middlepoint.x = (thisTouch.x-lastTouch.x)*fraction + lastTouch.x;
          middlepoint.y = (thisTouch.y-lastTouch.y)*fraction + lastTouch.y;

          //根据thisTouch和lastTouch的位置关系确定鱼首的角度
          angle = atan((thisTouch.y-lastTouch.y)/(thisTouch.x-lastTouch.x))*180/pi;
        });
      })
      ..addStatusListener((status){
        if(status == AnimationStatus.completed){
        }
        else if(status == AnimationStatus.dismissed){
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var appbar = AppBar(
      title: Text("Fish"),
      backgroundColor: Colors.deepOrange,
    );

    _fishDrawableView = FishDrawableView(context,angle,middlepoint);
    var bodyFish = CustomPaint(
        painter: _fishDrawableView,
    );

    var mainScaffold = Scaffold(
      appBar: appbar,
      body: bodyFish,
    );

    var gestureDetector = GestureDetector(
      child: mainScaffold,
      onPanDown: (pos){
        double thisPointX = pos.globalPosition.dx;
        double thisPointY = pos.globalPosition.dy;
        if(clicks == 0){
          lastTouch = middlepoint;
          thisTouch = PointF(thisPointX,thisPointY);
        }
        else{
          lastTouch = thisTouch;
          thisTouch = PointF(thisPointX,thisPointY);
        }
        clicks++;
        controller.forward();
        setState(() {

        });
      },
    );

    return gestureDetector;
  }
}
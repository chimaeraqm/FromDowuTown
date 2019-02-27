import 'dart:math';

import 'package:flutter/material.dart';
import 'package:from_downtown/objs/PointF.dart';

class FishDrawableView extends CustomPainter
{
  BuildContext mContext;
//  PointF lastPnt;
//  PointF thisPnt;

  final double HEAD_RADIUS = 50;
  final int BODY_ALPHA = 220;
  final int OTHER_ALPHA = 160;
  final int FINS_ALPHA = 100;
  final int FINS_LEFT = 1;//左鱼鳍
  final int FINS_RIGHT = -1;
  double BODY_LENGHT;
  double FINS_LENGTH;
  double TOTAL_LENGTH;

  Paint mPaint;
  //全局控制标志
  int currentValue = 0;
  //角度表示的角
  double _mainAngle;
  //ObjectAnimator finsAnimator;
  double waveFrequence = 1;
  //鱼头点
  PointF headPoint;
  //转弯更自然的中心点
  PointF _middlePoint;
  double finsAngle = 0;
  Paint bodyPaint;
  Path mPath;

  FishDrawableView(this.mContext,double angle,PointF middlepoint)
  {
    BODY_LENGHT = HEAD_RADIUS * 3.2; //第一节身体长度
    FINS_LENGTH = HEAD_RADIUS * 1.3;
    TOTAL_LENGTH = 6.79 * HEAD_RADIUS;
    _mainAngle = angle;
    _middlePoint = middlepoint;
    initView();
  }

  void initView()
  {
    //路径
    mPath = new Path();
    //画笔
    mPaint = new Paint();
    mPaint.isAntiAlias = true;
    mPaint.style = PaintingStyle.fill;
    mPaint.color = Color.fromARGB(OTHER_ALPHA, 244, 92, 71);
    //身体画笔
    bodyPaint = new Paint();
    mPaint.isAntiAlias = true;
    mPaint.style = PaintingStyle.fill;
    mPaint.color = Color.fromARGB(OTHER_ALPHA + 5, 244, 92, 71);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    makeBody(canvas, HEAD_RADIUS);
  }

  void makeBody(Canvas canvas, double headRadius)
  {
    //sin参数为弧度值
    //现有角度=原始角度+ sin（域值[-1，1]）*可摆动的角度   sin作用是控制周期摆动
    //中心轴线加偏移量和X轴顺时针方向夹角

    double angle = _mainAngle + sin((currentValue * 1.2 * waveFrequence)*pi/180) * 2;
    headPoint = calculatPoint(_middlePoint, BODY_LENGHT / 2,_mainAngle);
    //画头
    canvas.drawCircle(Offset(headPoint.x, headPoint.y), HEAD_RADIUS, mPaint);
    //右鳍 起点
    PointF pointFinsRight = calculatPoint(headPoint, headRadius * 0.9, angle -110);
    makeFins(canvas, pointFinsRight, FINS_RIGHT, angle);
    //左鳍 起点
    PointF pointFinsLeft = calculatPoint(headPoint, headRadius * 0.9, angle +110);
    makeFins(canvas, pointFinsLeft, FINS_LEFT, angle);

    PointF endPoint = calculatPoint(headPoint, BODY_LENGHT, angle-180);
    //躯干2
    PointF mainPoint = new PointF(endPoint.x, endPoint.y);
    makeSegments(canvas, mainPoint, headRadius * 0.7, 0.6, angle);
    PointF point1, point2, point3, point4, contralLeft, contralRight;
    //point1和4的初始角度决定发髻线的高低值越大越低
    point1 = calculatPoint(headPoint, headRadius,  angle-80);
    point2 = calculatPoint(endPoint, headRadius * 0.7, angle-90);
    point3 = calculatPoint(endPoint, headRadius * 0.7, angle +90);
    point4 = calculatPoint(headPoint, headRadius, angle +80);
    //决定胖瘦
    contralLeft = calculatPoint(headPoint, BODY_LENGHT * 0.56, angle -130);
    contralRight = calculatPoint(headPoint, BODY_LENGHT * 0.56, angle +130);
    mPath.reset();
    mPath.moveTo(point1.x, point1.y);
    mPath.quadraticBezierTo(contralLeft.x, contralLeft.y, point2.x, point2.y);
    mPath.lineTo(point3.x, point3.y);
    mPath.quadraticBezierTo(contralRight.x, contralRight.y, point4.x, point4.y);
    mPath.lineTo(point1.x, point1.y);

    mPaint.color = Color.fromARGB(BODY_ALPHA, 244, 92, 71);
    //画最大的身子
    canvas.drawPath(mPath, mPaint);
  }

  /**
   * 第二节节肢
   * 0.7R * 0.6 =1.12R
   *
   * @param canvas
   * @param mainPoint
   * @param segmentRadius
   * @param MP 梯形上边下边长度比
   */
  void makeSegments(Canvas canvas, PointF mainPoint, double segmentRadius, double MP, double fatherAngle)
  {
    //中心轴线和X轴顺时针方向夹角
    double angle = fatherAngle + cos((currentValue * 1.5 * waveFrequence)*pi/180) * 15;
    //身长
    double segementLenght = segmentRadius * (MP + 1);
    PointF endPoint = calculatPoint(mainPoint, segementLenght, angle-180);

    PointF point1, point2, point3, point4;
    point1 = calculatPoint(mainPoint, segmentRadius, angle-90);
    point2 = calculatPoint(endPoint, segmentRadius * MP,angle-90);
    point3 = calculatPoint(endPoint, segmentRadius * MP, angle +90);
    point4 = calculatPoint(mainPoint, segmentRadius, angle+90);

    canvas.drawCircle(Offset(mainPoint.x, mainPoint.y), segmentRadius, mPaint);
    canvas.drawCircle(Offset(endPoint.x, endPoint.y), segmentRadius * MP, mPaint);
    mPath.reset();
    mPath.moveTo(point1.x, point1.y);
    mPath.lineTo(point2.x, point2.y);
    mPath.lineTo(point3.x, point3.y);
    mPath.lineTo(point4.x, point4.y);
    canvas.drawPath(mPath, mPaint);

    //躯干2
    PointF mainPoint2 = new PointF(endPoint.x, endPoint.y);
    makeSegmentsLong(canvas, mainPoint2, segmentRadius * 0.6, 0.4, angle);
  }

  /**
   * 第三节节肢
   * 0.7R * 0.6 * (0.4 + 2.7) + 0.7R * 0.6 * 0.4=1.302R + 0.168R
   *
   * @param canvas
   * @param mainPoint
   * @param segmentRadius
   * @param MP            梯形上边下边长度比
   */
  void makeSegmentsLong(Canvas canvas, PointF mainPoint, double segmentRadius, double MP, double fatherAngle)
  {
    //中心轴线和X轴顺时针方向夹角
    double angle = fatherAngle + sin((currentValue * 1.5 * waveFrequence)*pi/180) * 35;
    //身长
    double segementLenght = segmentRadius * (MP + 2.7);
    PointF endPoint = calculatPoint(mainPoint, segementLenght, angle-180);

    PointF point1, point2, point3, point4;
    point1 = calculatPoint(mainPoint, segmentRadius, angle -90 );
    point2 = calculatPoint(endPoint, segmentRadius * MP,angle -90 );
    point3 = calculatPoint(endPoint, segmentRadius * MP, angle +90);
    point4 = calculatPoint(mainPoint, segmentRadius, angle +90);

    makeTail(canvas, mainPoint, segementLenght, segmentRadius, angle);


    canvas.drawCircle(Offset(endPoint.x, endPoint.y), segmentRadius * MP, mPaint);
    mPath.reset();
    mPath.moveTo(point1.x, point1.y);
    mPath.lineTo(point2.x, point2.y);
    mPath.lineTo(point3.x, point3.y);
    mPath.lineTo(point4.x, point4.y);
    canvas.drawPath(mPath, mPaint);
  }

  /**
   * 鱼鳍
   *
   * @param canvas
   * @param startPoint
   * @param type
   */
  void makeFins(Canvas canvas, PointF startPoint, int type, double fatherAngle)
  {
    //鱼鳍三角控制角度
    double contralAngle = 115;
    mPath.reset();
    mPath.moveTo(startPoint.x, startPoint.y);
    PointF endPoint = calculatPoint(startPoint, FINS_LENGTH, type == FINS_RIGHT ? fatherAngle - finsAngle-180 : fatherAngle + finsAngle+180);
    PointF contralPoint = calculatPoint(startPoint, FINS_LENGTH * 1.8, type == FINS_RIGHT ?
    fatherAngle - contralAngle - finsAngle : fatherAngle + contralAngle + finsAngle);
    mPath.quadraticBezierTo(contralPoint.x, contralPoint.y, endPoint.x, endPoint.y);
    mPath.lineTo(startPoint.x, startPoint.y);
    mPaint.color = Color.fromARGB(FINS_ALPHA, 244, 92, 71);
    canvas.drawPath(mPath, mPaint);
    mPaint.color = Color.fromARGB(OTHER_ALPHA, 244, 92, 71);
  }

  /**
   * 鱼尾及鱼尾张合
   *
   * @param canvas
   * @param mainPoint
   * @param length
   * @param maxWidth
   */
  void makeTail(Canvas canvas, PointF mainPoint, double length, double maxWidth, double angle)
  {
    //TODO : newWidth should be valued as ABS
    double newWidth = sin((currentValue * 1.7 * waveFrequence)*pi/180) * maxWidth + HEAD_RADIUS/5*3;
    //endPoint为三角形底边中点
    PointF endPoint = calculatPoint(mainPoint, length, angle-180);
    PointF endPoint2 = calculatPoint(mainPoint, length - 10, angle-180);
    PointF point1, point2, point3, point4;
    point1 = calculatPoint(endPoint, newWidth, angle-90);
    point2 = calculatPoint(endPoint, newWidth, angle +90);
    point3 = calculatPoint(endPoint2, newWidth - 20, angle-90);
    point4 = calculatPoint(endPoint2, newWidth - 20, angle +90);
    //内
    mPath.reset();
    mPath.moveTo(mainPoint.x, mainPoint.y);
    mPath.lineTo(point3.x, point3.y);
    mPath.lineTo(point4.x, point4.y);
    mPath.lineTo(mainPoint.x, mainPoint.y);
    canvas.drawPath(mPath, mPaint);
    //外
    mPath.reset();
    mPath.moveTo(mainPoint.x, mainPoint.y);
    mPath.lineTo(point1.x, point1.y);
    mPath.lineTo(point2.x, point2.y);
    mPath.lineTo(mainPoint.x, mainPoint.y);
    canvas.drawPath(mPath, mPaint);

  }

  PointF calculatPoint(PointF startPoint, double length, double angle) {
    double deltaX = cos(angle*pi/180) * length;
    //符合Android坐标的y轴朝下的标准
    double deltaY = sin((angle-180)*pi/180) * length;
    return new PointF(startPoint.x + deltaX, startPoint.y + deltaY);
  }

}
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    this.color,
    this.fabLocation,
    this.shape
  });

  final Color color;
  final FloatingActionButtonLocation fabLocation;
  final NotchedShape shape;

  static final List<FloatingActionButtonLocation> kCenterLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowContents = <Widget> [
      IconButton(
        icon: const Icon(
            Icons.store_mall_directory,
            color: Colors.white
        ),
        highlightColor: Colors.white,
        disabledColor: Colors.white,
        iconSize: 28.0,
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.face),
        highlightColor: color,
        disabledColor: Colors.white,
        iconSize: 28.0,
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.star_border),
        highlightColor: color,
        disabledColor: Colors.white,
        iconSize: 28.0,
        onPressed: () {},
      ),
    ];


    if (kCenterLocations.contains(fabLocation)) {
      rowContents.add(
        const Expanded(child: SizedBox()),
      );
    }

    rowContents.addAll(<Widget> [
      FlatButton(
        child: Text(
          '加入购物车',
        ),
        color: Colors.orange,
        textColor: Colors.white,
        onPressed: (){},
      ),
      FlatButton(
        child: Text(
          '立即购买',
        ),
        color: Colors.deepOrange,
        textColor: Colors.white,
        onPressed: (){},
      ),
    ]);

    var rtn = BottomAppBar(
      color: Colors.black12,
      child: Row(children: rowContents),
      shape: shape,
    );

    return rtn;
  }
}
import 'package:flutter/material.dart';
import 'package:from_downtown/dialogs/dialog_purchase.dart';
import 'package:from_downtown/views/view_bottom_appbar.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class _ChoiceValue<T> {
  const _ChoiceValue({ this.value, this.title, this.label });

  final T value;
  final String title;
  final String label; // For the Semantics widget that contains title

  @override
  String toString() => '$runtimeType("$title")';
}

const _ChoiceValue<Widget> kCircularFab = _ChoiceValue<Widget>(
  title: 'Circular',
  label: 'circular floating action button',
  value: FloatingActionButton(
    child: Icon(Icons.add, semanticLabel: 'Action'),
    backgroundColor: Colors.orange,
  ),
);

const _ChoiceValue<FloatingActionButtonLocation> kFabEndDocked = _ChoiceValue<FloatingActionButtonLocation>(
  title: 'Attached - End',
  label: 'floating action button is docked at the end of the bottom app bar',
  value: FloatingActionButtonLocation.endDocked,
);

class ServiceDetailDialog extends StatefulWidget {
  @override
  ServiceDetailDialogState createState() => ServiceDetailDialogState();
}

class ServiceDetailDialogState extends State<ServiceDetailDialog>
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);

    var appbar = AppBar(
      title: Text('Detail Page'),
    );

    var form_child_box1 = Container(
      //height: 200,
      color: Colors.white,
      child: Image.asset('images/huawei_cx8e.png'),
    );

    var box2_text_row1 = Text("599元",
      style: TextStyle(
        color: Colors.deepOrange,
        fontWeight: FontWeight.w800,
        fontSize: 20.0,
      ),
    );

    var box2_container_row1 = Container(
      alignment: Alignment.centerLeft,
      child: box2_text_row1,
    );

    var box2_text_row2 = Text("华为HUAWEI手机维修店 华为畅享8E青春\n主板进水不开机 基带 wifi",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
      ),
    );

    var box2_container_row2 = Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 8.0),
      child: box2_text_row2,
    );

    var box2_text_row3 = Row(
      children: <Widget>[
        Text("快递:0.00",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.0),
        ),
        Expanded(
          child: Text("月销:780",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.0,
            ),
          ),
        ),
        Text("上海",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
        ),
      ],
    );

    var box2_container_row3 = Container(
      alignment: Alignment.centerLeft,
      child: box2_text_row3,
    );

    var form_child_box2 = Container(
      //height:150.0,
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          box2_container_row1,
          box2_container_row2,
          box2_container_row3,
        ],
      ),
    );


    var box3_text_row1 = Row(
      children: <Widget>[
        Text("优惠",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.0),
        ),
        Expanded(
          child: Text("购买可得25积分",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          disabledColor: Colors.black54,
          iconSize: 20.0,
          onPressed: () {
            Scaffold.of(context).showSnackBar(const SnackBar(
                content: Text('购买可得25积分')
            ));
          },
        )
      ],
    );

    var box3_container_row1 = Container(
      alignment: Alignment.centerLeft,
      child: box3_text_row1,
    );

    var box3_text_row2 = Row(
      children: <Widget>[
        Text("服务",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.0),
        ),
        Expanded(
          child: Text("正品保证.不支持7天退换",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          disabledColor: Colors.black54,
          iconSize: 20.0,
          onPressed: () {
            Scaffold.of(context).showSnackBar(const SnackBar(
                content: Text('正品保证.不支持7天退换')
            ));
          },
        )
      ],
    );

    var box3_container_row2 = Container(
      alignment: Alignment.centerLeft,
      child: box3_text_row2,
    );

    var form_child_box3 = Container(
      //height:150.0,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          box3_container_row1,
          box3_container_row2,
        ],
      ),
    );

    var bottom_bar = CustomBottomAppBar(
      color: Colors.deepOrange,
      fabLocation: kFabEndDocked.value,
      shape: CircularNotchedRectangle(),
    );

    var scaffold = Scaffold(
      //appBar: appbar,

      body:Container(
        color: Colors.black12,
        child: ListView(
          children: <Widget>[
            form_child_box1,
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
            ),
            form_child_box2,
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
            ),
            form_child_box3,
          ],
        ),
      ),
      bottomNavigationBar: bottom_bar,
    );
    return scaffold;
  }
}
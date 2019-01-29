import 'package:flutter/material.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class PurchaseDialog extends StatefulWidget {
  @override
  PurchaseDialogState createState() => PurchaseDialogState();
}

class PurchaseDialogState extends State<PurchaseDialog>
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);

    var appbar = AppBar(
      title: Text('Order Confirm'),
    );

    var address_text1 = Text('收货人：chimaeraqm\n联系方式：000-00000000000',
      style: TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.w800,
        fontSize: 20.0,
      ),
    );

    var address_text2 = Text('地址：上海市黄浦区xxxxxxxxxxxxxxxx',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    );

    var form_child_box1 = SizedBox(
      height: 200,
      child: Image.asset('images/huawei_cx8e.png'),
    );

    var price_text = Text("购买数量 1",
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
      ),
    );

    var sales_text = Text("配送方式",
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14.0,
      ),
    );

    var service_text = Text("买家留言：填写内容已和卖家协商确认",
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14.0,
      ),
    );

    var confirm_text = Text("599元",
      style: TextStyle(
        color: Colors.deepOrange,
        fontSize: 20.0,
      ),
    );

    var form_child_box2 = SizedBox(
      height: 400,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          address_text1,
          address_text2,
          form_child_box1,
          price_text,
          sales_text,
          service_text,
          confirm_text,
        ],
      ),
    );

    var button_bar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          child: Text(
            '提交订单',
          ),
          textColor: Colors.amber.shade500,
          color: Colors.blueAccent,
          onPressed: (){},
        ),
      ],
    );

    var body_form = Form(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          form_child_box2,
          button_bar,
        ],
      ),
    );

    var scaffold = Scaffold(
      appBar: appbar,
      body: body_form,
    );
    return scaffold;
  }
}

import 'package:flutter/material.dart';
import 'package:from_downtown/dialogs/dialog_purchase.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

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

    var form_child_box1 = SizedBox(
      height: 200,
      child: Image.asset('images/huawei_cx8e.png'),
    );

    var price_text = Text("599元",
      style: TextStyle(
        color: Colors.deepOrange,
        fontWeight: FontWeight.w800,
        fontSize: 20.0,
      ),
    );

    var sales_text = Text("优惠 购买可得00积分",
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14.0,
      ),
    );

    var service_text = Text("服务 七天无理由退货",
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14.0,
      ),
    );

    var form_child_box2 = SizedBox(
      height: 300,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          form_child_box1,
          price_text,
          sales_text,
          service_text,
        ],
      ),
    );

    var button_bar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          child: Text(
            '立即购买',
          ),
          textColor: Colors.amber.shade500,
          color: Colors.blueAccent,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute<DismissDialogAction>(
              builder: (BuildContext context) => PurchaseDialog(),
              fullscreenDialog: true,
            ));
          },
        ),
        FlatButton(
          child: Text(
            '加入购物车',
          ),
          textColor: Colors.white,
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
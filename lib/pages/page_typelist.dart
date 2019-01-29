import 'package:flutter/material.dart';
import 'package:from_downtown/views/view_card.dart';

class TypeListPage extends StatefulWidget {
  TypeListPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TypeListPageState createState() => _TypeListPageState();
}

class _TypeListPageState extends State<TypeListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    final List<SingleType> items = <SingleType>[
      const SingleType(
        assetName: 'images/huawei_cx8e.png',
//        title: '华为畅享8E青春',
        description: <String>[
          '手机类型',
          '华为畅享8E青春',
          '价位：1000元以内',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_cx9.png',
//        title: '华为畅享9',
        description: <String>[
          '手机类型',
          '华为畅享9',
          '价位：1000~2000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_cx9p.png',
//        title: '华为畅享9Plus',
        description: <String>[
          '手机类型',
          '华为畅享9Plus',
          '价位：1000~2000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_cxmax.png',
//        title: '华为畅享Max',
        description: <String>[
          '手机类型',
          '华为畅享Max',
          '价位：1000~2000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_mate10_pro.png',
//        title: 'HUAWEI Mate10 Pro',
        description: <String>[
          '手机类型',
          'HUAWEI Mate10 Pro',
          '价位：3000~4000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_mate20.png',
//        title: 'HUAWEI Mate20',
        description: <String>[
          '手机类型',
          'HUAWEI Mate20',
          '价位：4000~5000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_mate20_pro.png',
//        title: 'HUAWEI Mate20 Pro',
        description: <String>[
          '手机类型',
          'HUAWEI Mate20 Pro',
          '价位：5000~6000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_mate20_pro_ud.png',
//        title: 'HUAWEI Mate20 Pro(UD)',
        description: <String>[
          '手机类型',
          'HUAWEI Mate20 Pro(UD)',
          '价位：6000元及以上',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_mate20_x.png',
//        title: 'HUAWEI Mate20 X',
        description: <String>[
          '手机类型',
          'HUAWEI Mate20 X',
          '价位：5000~6000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_nova3.png',
//        title: 'HUAWEI nova 3',
        description: <String>[
          '手机类型',
          'HUAWEI nova 3',
          '价位：2000~3000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_nova3i.png',
//        title: 'HUAWEI nova 3i',
        description: <String>[
          '手机类型',
          'HUAWEI nova 3i',
          '价位：2000~3000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_nova4.png',
//        title: 'HUAWEI nova 4',
        description: <String>[
          '手机类型',
          'HUAWEI nova 4',
          '价位：3000~4000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_p20.png',
//        title: 'HUAWEI P20',
        description: <String>[
          '手机类型',
          'HUAWEI P20',
          '价位：3000~4000元',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_p20_pro.png',
//        title: 'HUAWEI P20 Pro',
        description: <String>[
          '手机类型',
          'HUAWEI P20 Pro',
          '价位：5000~6000元',
        ],
      ),
    ];

    /*Iterable<Widget> listTiles = items.map<Widget>((String item) => buildListTile(context, item));
    if (_showDividers)
      listTiles = ListTile.divideTiles(context: context, tiles: listTiles);*/


    var scaffold = Scaffold(
      body: ListView(
          itemExtent: SingleTypeItem.height,
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          children: items.map<Widget>((SingleType singleType) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: SingleTypeItem(
                singleType: singleType,
              ),
            );
          }).toList()
      ),
/*
      body: Scrollbar(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: _dense ? 4.0 : 8.0),
            children: listTiles.toList(),
          )),
*/
    );
    return scaffold;
  }
}
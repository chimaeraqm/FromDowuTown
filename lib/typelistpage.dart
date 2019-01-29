import 'package:flutter/material.dart';
import 'cardview.dart';

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

  bool _dense = true;
  bool _showDividers = true;
  bool _showAvatars = true;
  bool _showIcons = true;
  List<String> items = <String>[
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget buildListTile(BuildContext context, String item) {
    Widget secondary = const Text('Additional item information.');
    var merged_item = MergeSemantics(
      child: ListTile(
        isThreeLine: true,
        dense:_dense,
        leading: _showAvatars ? ExcludeSemantics(child: CircleAvatar(child: Text(item))) : null,
        title: Text('This item represents $item.'),
        subtitle: secondary,
        trailing: _showIcons ? Icon(
            Icons.info,
            color: Theme.of(context).disabledColor,
            size: 24.0,) : null,
      ),
    );
    return merged_item;
  }
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    const String _kGalleryAssetsPackage = 'phone_types_images_assets';

    final List<SingleType> items = <SingleType>[
      const SingleType(
        assetName: 'images/huawei_cx8e.png',
        assetPackage: _kGalleryAssetsPackage,
        title: 'HUAWEI CHANGXIANG 8E',
        description: <String>[
          'Type1',
          'Number1',
          'Take1',
        ],
      ),
      const SingleType(
        assetName: 'images/huawei_cx9.png',
        assetPackage: _kGalleryAssetsPackage,
        title: 'This is Type2',
        description: <String>[
          'Type2',
          'Number2',
          'Take2',
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
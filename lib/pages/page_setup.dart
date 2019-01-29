import 'package:flutter/material.dart';

class UserSetupPage extends StatefulWidget {
  UserSetupPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _UserSetupPageState createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {

  bool _dense = true;
  bool _showDividers = true;
  bool _showAvatars = true;
  bool _showIcons = false;
  List<String> items = <String>[
    'My Orders', 'Account Balance', 'User Setup',
  ];

  List<String> dess = <String>[
    'Query history repair orders path.', 'Query account balance here.', 'Other setups, including registed user name and password modification.',
  ];

  List<Icon> icons = <Icon>[
    Icon(Icons.list),Icon(Icons.details),Icon(Icons.settings),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget buildListTile(BuildContext context, String item, String des, Icon icon) {
    var merged_item = MergeSemantics(
      child: ListTile(
        isThreeLine: true,
        dense:_dense,
        leading: _showAvatars ? ExcludeSemantics(child: CircleAvatar(child: icon)) : null,
        title: Text(item),
        subtitle: Text(des),
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

    final List<Widget> listtiles1 = <Widget>[
      buildListTile(context,items[0],dess[0],icons[0]),
      buildListTile(context,items[1],dess[1],icons[1]),
      buildListTile(context,items[2],dess[2],icons[2]),
    ];

    /*Iterable<Widget> listTiles = items.map<Widget>((String item) => buildListTile(context, item));
    if (_showDividers)
      listTiles = ListTile.divideTiles(context: context, tiles: listTiles);*/


    var scaffold = Scaffold(
      body: Scrollbar(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: _dense ? 4.0 : 8.0),
            children: listtiles1,
          )),
    );
    return scaffold;
  }
}
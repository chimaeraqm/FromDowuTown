import 'package:flutter/material.dart';
import 'dialog_service_detail.dart';

class SingleType {
  const SingleType({
    this.assetName,
    this.assetPackage,
    this.title,
    this.description,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final List<String> description;

  bool get isValid => assetName != null && title != null && description?.length == 3;
}

class SingleTypeItem extends StatelessWidget
{
  static const double height = 366.0;
  final SingleType singleType;
  final ShapeBorder shape;

  SingleTypeItem({ Key key, @required this.singleType, this.shape })
      : assert(singleType != null && singleType.isValid),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    var box_stack1 = Stack(
      children: <Widget>[
        Positioned.fill(
            child: Image.asset(singleType.assetName),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              singleType.title,
              style: titleStyle,
            ),
          ),
        ),
      ],
    );

    var colume_box = SizedBox(
      height: 184.0,
      child: box_stack1,
    );

    var exp_text = DefaultTextStyle(
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style: descriptionStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              singleType.description[0],
              style: descriptionStyle.copyWith(
                color: Colors.black54,
              ),
            ),
          ),
          Text(singleType.description[1]),
          Text(singleType.description[2])]
      )
    );

    var colume_exp = Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: exp_text,
      ),
    );

    var button_bar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          child: Text(
            'Choose',
            semanticsLabel: 'Choose ${singleType.title}',
          ),
          textColor: Colors.amber.shade500,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute<DismissDialogAction>(
              builder: (BuildContext context) => ServiceDetailDialog(),
              fullscreenDialog: true,
            ));
          }
        ),
      ],
    );

    var colume_button_bar = ButtonTheme.bar(
      child: button_bar,
    );

    var card_colume = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        colume_box,
        colume_exp,
        colume_button_bar,
      ],
    );

    var cardview = Card(
      shape: shape,
      child: card_colume,
    );

    var container = Container(
      padding: const EdgeInsets.all(8.0),
      height: height,
      child: cardview,
    );

    var safearea = SafeArea(
      top: false,
      bottom: false,
      child: container,
    );

    return safearea;
  }
}
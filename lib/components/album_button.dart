import 'package:flutter/material.dart';

class AlbumButton extends StatefulWidget {
  AlbumButton({Key key, this.label, this.onPress}) : super(key: key);
  final String label;
  final Function onPress;
  @override
  _AlbumButtonState createState() => _AlbumButtonState();
}

class _AlbumButtonState extends State<AlbumButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.onPress,
      color: Colors.black,
      minWidth: 10.0,
      textColor: Colors.white,
      child: Text(widget.label),
    );
  }
}

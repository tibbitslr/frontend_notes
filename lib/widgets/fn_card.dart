import 'package:flutter/material.dart';

class FnCard extends StatelessWidget {
  final Widget child;
  final bool isFirst;
  final bool isLast;

  const FnCard({
    Key key,
    this.child,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          top: isFirst ? 8.0 : 2,
          bottom: isLast ? 8.0 : 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isFirst ? 16.0 : 0),
          bottom: Radius.circular(isLast ? 16.0 : 0),
        ),
      ),
      child: child,
    );
  }
}

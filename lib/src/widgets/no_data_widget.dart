import 'package:flutter/material.dart';

class NoDataWidget extends StatefulWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  State<NoDataWidget> createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/no_items.png'),
          Text('No existen datos')
        ],
      ),
    );
  }
}

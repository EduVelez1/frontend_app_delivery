import 'package:flutter/material.dart';

class StoresOrdersListPage extends StatefulWidget {
  const StoresOrdersListPage({ Key? key }) : super(key: key);

  @override
  State<StoresOrdersListPage> createState() => _StoresOrdersListPageState();
}

class _StoresOrdersListPageState extends State<StoresOrdersListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('stores'),
      ),
      
    );
  }
}
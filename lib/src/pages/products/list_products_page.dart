import 'package:flutter/material.dart';

class ListProduts extends StatefulWidget {
  const ListProduts({ Key? key }) : super(key: key);

  @override
  State<ListProduts> createState() => _ListProdutsState();
}

class _ListProdutsState extends State<ListProduts>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cardProduct(),    
      
    );
  }

  Widget _cardProduct(){
    return Container(
      height: 250,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}
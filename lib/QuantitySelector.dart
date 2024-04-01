// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int _quantity = 0;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Quantity ',
          style: TextStyle(
            color: Color.fromRGBO(202, 146, 99, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 8),
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color.fromRGBO(202, 146, 99, 1),
                borderRadius: BorderRadius.circular(5)
              ),
              child: IconButton(
                onPressed: _decrement,
                icon: Icon(Icons.remove,size: 16,),
                color: Colors.white
              ),
            ),
            SizedBox(width: 8),
            Text(
              '$_quantity',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 8),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color.fromRGBO(202, 146, 99, 1),
                borderRadius: BorderRadius.circular(5)
              ),
              child: IconButton(
                onPressed: _increment,
                icon: Icon(Icons.add,size: 16,),
                color: Colors.white
              ),
            ),
          ],
        ),
      ],
    );
  }
}

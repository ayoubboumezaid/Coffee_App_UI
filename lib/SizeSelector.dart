import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String _selectedSize = 'Small'; // Initially selected size

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Row(
          children: [
            buildSizeButton('Small', _selectedSize == 'Small'),
            SizedBox(width: 30), 
            buildSizeButton('Medium', _selectedSize == 'Medium'),
            SizedBox(width: 30), 
            buildSizeButton('Large', _selectedSize == 'Large'),
          ],
        ),
      ],
    );
  }

  Widget buildSizeButton(String size, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = size;
        });
      },
      child: buildSizeText(size, isSelected),
    );
  }

  Widget buildSizeText(String size, bool isSelected) {
    return Column(
      children: [
        Text(
          size,
          style: TextStyle(
            color: isSelected ? Color.fromRGBO(202, 146, 99, 1) : Colors.white,
            decoration: isSelected ? TextDecoration.underline : null,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4), 
        Container(
          height: 2,
          width: 30, 
          color: isSelected ? Color.fromRGBO(202, 146, 99, 1) : Colors.transparent,
        ),
      ],
    );
  }
}

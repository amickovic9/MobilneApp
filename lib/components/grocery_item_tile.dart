import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceryItemTile extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  void Function(String, double)? onPressed;

  GroceryItemTile({
    required this.itemName,
    required this.itemPrice,
    required this.onPressed,
  });

  @override
  _GroceryItemTileState createState() => _GroceryItemTileState();
}

class _GroceryItemTileState extends State<GroceryItemTile> {
  TextEditingController weightController = TextEditingController(text: '1.0');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemName,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.itemPrice + ' rsd',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Unesi količinu:',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 50,
                    child: TextFormField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  if (widget.onPressed != null) {
                    double enteredWeight =
                        double.tryParse(weightController.text) ?? 1.0;
                    double totalPrice =
                        double.parse(widget.itemPrice) * enteredWeight;
                    widget.onPressed!(widget.itemName, totalPrice);
                  }
                },
                child: Text(
                  'Dodaj u korpu',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

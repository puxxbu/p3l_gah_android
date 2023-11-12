import 'package:flutter/material.dart';

import '../../../theme/hotel_app_theme.dart';

class InvoiceDialog extends StatelessWidget {
  final String invoiceNumber;
  final String productName;
  final double price;
  final int quantity;

  InvoiceDialog({
    required this.invoiceNumber,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HotelAppTheme.buildLightTheme().primaryColor,
      title: Text('Detail Invoice'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Invoice Number: $invoiceNumber'),
          SizedBox(height: 10),
          Text('Product Name: $productName'),
          SizedBox(height: 10),
          Text('Price: $price'),
          SizedBox(height: 10),
          Text('Quantity: $quantity'),
          SizedBox(height: 10),
          Text('Total: ${price * quantity}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Yes'),
        ),
      ],
    );
  }
}

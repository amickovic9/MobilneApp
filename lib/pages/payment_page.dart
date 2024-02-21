import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String totalAmountText;
  const PaymentPage({Key? key, required this.totalAmountText})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController amountPaidController = TextEditingController();
  double changeAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Total Amount: ${widget.totalAmountText}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountPaidController,
              decoration: InputDecoration(labelText: 'Enter Amount Paid'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Preračunaj kusur kada se pritisne dugme
                calculateChange();
              },
              child: Text('Calculate Change'),
            ),

            const SizedBox(height: 20),

            // Prikazi izračunat kusur
            Text(
              'Change: \$${changeAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Funkcija za preračunavanje kusura
  void calculateChange() {
    double amountPaid = double.tryParse(amountPaidController.text) ?? 0.0;

    // Proveri da li je iznos plaćanja manji od ukupne cene
    if (amountPaid < double.parse(widget.totalAmountText.substring(1))) {
      // Prikaži upozorenje sa iznosom duga
      showPaymentErrorAlert(amountPaid);
    } else {
      // Preračunaj kusur
      setState(() {
        changeAmount =
            amountPaid - double.parse(widget.totalAmountText.substring(1));
      });
    }
  }

  // Funkcija za prikazivanje upozorenja
  void showPaymentErrorAlert(double amountPaid) {
    double remainingAmount =
        double.parse(widget.totalAmountText.substring(1)) - amountPaid;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Error'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Customer needs to pay more!'),
              const SizedBox(height: 8),
              Text('Remaining Amount: \$${remainingAmount.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

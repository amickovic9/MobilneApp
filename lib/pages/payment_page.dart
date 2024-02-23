import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

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
    CartModel cart = Provider.of<CartModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Naplata'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ukupan iznos: ${widget.totalAmountText} rsd',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountPaidController,
              decoration: InputDecoration(
                labelText: 'Unesite iznos koji je mušterija platila',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  calculateChange();
                } catch (e) {
                  print("Greška prilikom konverzije: $e");
                  showInvalidInputAlert();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Plati',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Kusur: ${changeAmount.toStringAsFixed(2)} rsd',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cart.clearCart();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Završi',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateChange() {
    double amountPaid =
        double.parse(amountPaidController.text.replaceAll(',', '.'));

    if (amountPaid < double.parse(widget.totalAmountText)) {
      showPaymentErrorAlert(amountPaid);
    } else {
      setState(() {
        changeAmount = amountPaid - double.parse(widget.totalAmountText);
      });
    }
  }

  void showInvalidInputAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nevažeći unos'),
          content: Text('Unesite broj'),
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

  void showPaymentErrorAlert(double amountPaid) {
    double remainingAmount = double.parse(widget.totalAmountText) - amountPaid;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Greška pri plaćanju'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Kupac treba da plati više!'),
              const SizedBox(height: 8),
              Text(
                'Preostali iznos: ${remainingAmount.toStringAsFixed(2)} rsd',
              ),
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

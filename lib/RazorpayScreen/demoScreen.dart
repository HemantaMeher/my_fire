import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayDemoScreen extends StatefulWidget {
  const RazorpayDemoScreen({Key? key}) : super(key: key);

  @override
  State<RazorpayDemoScreen> createState() => _RazorpayDemoScreenState();
}

class _RazorpayDemoScreenState extends State<RazorpayDemoScreen> {
  TextEditingController amountCountroller = TextEditingController();

  var _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Success +++++++++++++++++++++++++");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Fail ---------------------------");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Getway"),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: amountCountroller,
                decoration: InputDecoration(hintText: "Amount.."),
              ),
              SizedBox(height: 100,),

              ElevatedButton(
                  onPressed: () {
                    var options = {
                      'key': 'rzp_test_voBuMN7ZlM8kaE',
                      'amount': (int.parse(amountCountroller.text.toString())) * 100, //in the smallest currency sub-unit.
                      'name': 'Hemanta Meher',
                      // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                      'description': 'Trail..',
                      'timeout': 200, // in seconds
                      // 'prefill': {
                      //   'contact': '9123456789',
                      //   'email': 'gaurav.kumar@example.com'
                      // }
                    };
                    _razorpay.open(options);
                  },
                  child: Text("Payment")
              )
            ],
          ),
        ),
      ),
    );
  }
}

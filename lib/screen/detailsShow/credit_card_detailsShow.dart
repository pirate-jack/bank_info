import 'package:bank_info/firebase/firebase_services.dart';
import 'package:bank_info/model/cardModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreditCardDetailsshow extends StatefulWidget {
  const CreditCardDetailsshow({super.key});

  @override
  State<CreditCardDetailsshow> createState() => _CreditCardDetailsshowState();
}

class _CreditCardDetailsshowState extends State<CreditCardDetailsshow> {
  FirebaseServices firebaseServices = FirebaseServices();
  List<Cardmodel> creditCardDetail = [];

  @override
  void initState() {
    fetchDetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: creditCardDetail.length,
                  itemBuilder: (context, index) {
                    final bankInfo = creditCardDetail[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Card(
                        elevation: 10,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: ListTile(
                          title: Text("Account Holder Name : ${bankInfo.name}"),
                          subtitle: Text(
                            'Card Number: ${creditCardDetail[index].cardNumber}\nExp: ${creditCardDetail[index].mm}/${creditCardDetail[index].yy}',
                          ),
                          trailing:
                              Text('cvv : ${creditCardDetail[index].cvv}'),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchDetails() async {
    try {
      creditCardDetail = await firebaseServices.getCreditDetails();

      setState(() {});
    } catch (e) {
      print('Error fetching bank or credit/debit card details: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching details. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );

      if (e is FirebaseException) {
        print('Firebase error: ${e.message}');
      }
    }
  }
}

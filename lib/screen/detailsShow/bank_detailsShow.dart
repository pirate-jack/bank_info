import 'package:bank_info/firebase/firebase_services.dart';
import 'package:bank_info/model/bank_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BankDetailsShow extends StatefulWidget {
  const BankDetailsShow({super.key});

  @override
  State<BankDetailsShow> createState() => _BankDetailsShowState();
}

class _BankDetailsShowState extends State<BankDetailsShow> {
  FirebaseServices firebaseServices = FirebaseServices();
  List<BankInfoModel> bankDetail = [];

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
                  itemCount: bankDetail.length,
                  itemBuilder: (context, index) {
                    final bankInfo = bankDetail[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Card(
                        elevation: 10,
                        margin:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: ListTile(
                          title: Text("Account Holder Name : ${bankInfo.name}"),
                          subtitle: Text(
                              'Account Number: ${bankInfo
                                  .accountNumber}\nIFSC code : ${bankInfo
                                  .ifscCode}'),
                          trailing: Text(bankInfo.accountType),
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
      bankDetail = await firebaseServices.getBankDetails();

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

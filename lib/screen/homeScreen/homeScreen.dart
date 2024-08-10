import 'package:bank_info/firebase/firebase_services.dart';
import 'package:bank_info/model/bank_info_model.dart';
import 'package:bank_info/model/cardModel.dart';
import 'package:bank_info/screen/detailsAdd/bank_details.dart';
import 'package:bank_info/screen/detailsAdd/credit_card_Add.dart';
import 'package:bank_info/screen/detailsAdd/debit_card_add.dart';
import 'package:bank_info/screen/detailsShow/bank_detailsShow.dart';
import 'package:bank_info/screen/detailsShow/credit_card_detailsShow.dart';
import 'package:bank_info/screen/detailsShow/debit_card_details_show.dart';
import 'package:bank_info/screen/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  FirebaseServices firebaseServices = FirebaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<BankInfoModel> bankDetail = [];
  List<Cardmodel> creditCardDetail = [];
  List<Cardmodel> debitCardDetail = [];

  String currentUser = '';
  User? user;
  String currentUserEmail = '';

  @override
  void initState() {
    getCurrentUser();
    print(currentUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      fetchDetails();
    });
    return Scaffold(
      /*appBar: AppBar(
          title: Text('HomeScreen'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Log out'),
                        content:
                            const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              firebaseServices.logOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false,
                              );
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.white,
                ))
          ],
        ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  // App bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Good morning',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Log out'),
                                  content: const Text(
                                      'Are you sure you want to log out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        firebaseServices.logOut();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (route) => false,
                                        );
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.exit_to_app_sharp),
                        ),
                      )
                    ],
                  ),
                  // Card
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Image.asset(
                                          'assets/icons/profile.png'),
                                      radius: 35,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'hello ${currentUser.toUpperCase()}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '${currentUserEmail}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bank Details
                  /*  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bank Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'View All',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: bankDetail.length,
                            itemBuilder: (context, index) {
                              final bankInfo = bankDetail[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(
                                      "Account Holder Name : ${bankInfo.name}"),
                                  subtitle: Text(
                                      'Account Number: ${bankInfo.accountNumber}\nIFSC code : ${bankInfo.ifscCode}'),
                                  trailing: Text(bankInfo.accountType),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Credit Details
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Credit Card Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'View All',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: creditCardDetail.length,
                            itemBuilder: (context, index) {
                              final cardInfo = creditCardDetail[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(
                                      "Account Holder Name : ${cardInfo.name}"),
                                  subtitle: Text(
                                      'Card Number: ${cardInfo.cardNumber}\nExp : ${cardInfo.mm}/${cardInfo.yy}'),
                                  trailing: Text(
                                      'CVV : ${int.parse(cardInfo.cvv.toString())}'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Debit Card
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Debit Card Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'View All',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: debitCardDetail.length,
                            itemBuilder: (context, index) {
                              final cardInfo = debitCardDetail[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(
                                      "Account Holder Name : ${cardInfo.name}"),
                                  subtitle: Text(
                                      'Card Number: ${cardInfo.cardNumber}\nExp : ${cardInfo.mm}/${cardInfo.yy}'),
                                  trailing: Text(
                                      'CVV : ${int.parse(cardInfo.cvv.toString())}'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BankDetailsShow(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue.shade300,
                                ),
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ' Bank Details',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25,
                              child: Text('${bankDetail.length}'),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreditCardDetailsshow(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.green.shade300,
                                ),
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ' Credit Card',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25,
                              child: Text('${creditCardDetail.length}'),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DebitCardDetailsShow(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red.shade200,
                                ),
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ' Debit Card',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25,
                              child: Text('${debitCardDetail.length}'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemTeal.withOpacity(.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                height: MediaQuery.of(context).size.height * 0.25,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          Text(
                            'Add Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.blue.withOpacity(.1),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BankDetails(),
                                          ));
                                    },
                                    icon: Image.asset(
                                      'assets/icons/bankinfo.png',
                                      height: 45,
                                    )),
                              ),
                              Text(
                                'Bank Account',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.blue.withOpacity(.1),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CreditCardAdd(),
                                          ));
                                    },
                                    icon: Image.asset(
                                        'assets/icons/creditCard.png',
                                        height: 45)),
                              ),
                              Text(
                                'Credit Card',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.blue.withOpacity(.1),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DebitCardAdd(),
                                          ));
                                    },
                                    icon: Image.asset(
                                        'assets/icons/debitCard.png',
                                        height: 45)),
                              ),
                              Text(
                                'Debit Card',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot =
            await _firestore.collection('users').doc(user.uid).get();
        if (documentSnapshot.exists) {
          currentUserEmail = documentSnapshot['email'];
          currentUser = documentSnapshot['name'];
        } else {
          print('User data not fount');
        }
      } catch (e) {
        print('user not found');
      }
    }
  }

  Future<void> fetchDetails() async {
    try {
      bankDetail = await firebaseServices.getBankDetails();

      creditCardDetail = await firebaseServices.getCreditDetails();

      debitCardDetail = await firebaseServices.getDebitDetails();

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

import 'package:bank_info/firebase/firebase_services.dart';
import 'package:bank_info/screen/homeScreen/homeScreen.dart';
import 'package:flutter/material.dart';

class DebitCardAdd extends StatefulWidget {
  const DebitCardAdd({super.key});

  @override
  State<DebitCardAdd> createState() => _DebitCardAddState();
}

class _DebitCardAddState extends State<DebitCardAdd> {
  FirebaseServices _firebaseServices = FirebaseServices();

  final _cardHolderName = TextEditingController();
  final _cardNumber = TextEditingController();
  final _cardCvv = TextEditingController();
  final _cardMM = TextEditingController();
  final _cardYY = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)),
                color: Colors.blue),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        'Debit Card',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  creditCard(context),
                  Forms(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget creditCard(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 230,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Debit Card',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Image.asset(
                            'assets/icons/visa.png',
                            height: 75,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/icons/chip.png',
                            color: Colors.black54,
                            height: 60,
                          )),
                      Text(
                        'XXXX XXXX XXXX XXXX',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mr.Jack',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            'Exp : XX/XX',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Forms(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 360,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card Holder Name',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextField(
                controller: _cardHolderName,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Card Number',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextField(
                controller: _cardNumber,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 35,
                    child: TextField(
                      controller: _cardCvv,
                      maxLength: 3,
                      decoration: InputDecoration(
                          counter: SizedBox.shrink(), hintText: 'CVV'),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                        child: TextField(
                          controller: _cardMM,
                          decoration: InputDecoration(
                            hintText: 'MM',
                          ),
                        ),
                      ),
                      Text(
                        ' / ',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 35,
                        child: TextField(
                          controller: _cardYY,
                          decoration: InputDecoration(
                            hintText: 'YY',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 100,
                  child: FilledButton(
                    onPressed: () async {
                      int cardNUmber = int.parse(_cardNumber.text);
                      String cardHolderName = _cardHolderName.text;
                      int cardCvv = int.parse(_cardCvv.text);
                      int cardMM = int.parse(_cardMM.text);
                      int cardYY = int.parse(_cardYY.text);
                      try {
                        await _firebaseServices.addDebitCard(cardHolderName,
                            cardNUmber, cardCvv, cardMM, cardYY);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Card added successfully!')));
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to add card: $e')));
                      }
                    },
                    child: Text('Submit'),
                    style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

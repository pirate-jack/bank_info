import 'package:bank_info/firebase/firebase_services.dart';
import 'package:bank_info/screen/homeScreen/homeScreen.dart';
import 'package:flutter/material.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final _accountHolderName = TextEditingController();
  final _accountNumber = TextEditingController();
  final _accountIFSC = TextEditingController();

  FirebaseServices _firebaseServices = FirebaseServices();

  List<String> AccountType = ["Current", 'Saving'];
  String? _selectedOption;

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
                        'Bank Info',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 230,
                    child: Image.asset('assets/icons/form.png'),
                  ),
                  Forms(context),
                ],
              ),
            ),
          ),
        ],
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
                'Acount Holder Name',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextField(
                controller: _accountHolderName,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Acount Number',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextField(
                controller: _accountNumber,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Acount Type',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      DropdownButton<String>(
                        hint: Text('Account Type'),
                        value: _selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue;
                          });
                        },
                        items: AccountType.map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Acount IFSC Code',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              controller: _accountIFSC,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
                      String name = _accountHolderName.text;
                      String accountNumber = _accountNumber.text;
                      String? accountType = _selectedOption;
                      String accountIFSC = _accountIFSC.text;
                      try {
                        await _firebaseServices.addBankdetail(
                            name, accountNumber, accountType!, accountIFSC);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Account added successfully!')));
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

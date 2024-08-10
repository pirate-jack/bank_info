import 'package:bank_info/model/bank_info_model.dart';
import 'package:bank_info/model/cardModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInwithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('signIn error  : $e');
      return null;
    }
  }

  Future<User> logInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email.');
        case 'wrong-password':
          throw Exception('Wrong password provided for that user.');
        case 'invalid-email':
          throw Exception('The email address is not valid.');
        default:
          throw Exception('$e');
      }
    } catch (e) {
      print('logIn error : $e');
      throw Exception("Log In Failed: ${e.toString()}");
    }
  }

  Future<void> addCreditCard(
      String name, int number, int cvv, int mm, int yy) async {
    Cardmodel cardAdd =
        Cardmodel(name: name, cardNumber: number, cvv: cvv, mm: mm, yy: yy);
    User? user = await _auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('Credit Card')
          .doc()
          .set(cardAdd.toMap());
    } else {
      print('User not Found');
    }
  }

  Future<void> addDebitCard(
      String name, int number, int cvv, int mm, int yy) async {
    Cardmodel cardAdd =
        Cardmodel(name: name, cardNumber: number, cvv: cvv, mm: mm, yy: yy);
    User? user = await _auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('Debit Card')
          .doc()
          .set(cardAdd.toMap());
    } else {
      print('User not Found');
    }
  }

  Future<void> addBankdetail(String holderName, String accountNumber,
      String accountType, String accountIFSC) async {
    BankInfoModel bankInfoModel = BankInfoModel(
        name: holderName,
        accountNumber: accountNumber,
        accountType: accountType,
        ifscCode: accountIFSC);
    User? user = await _auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('Account Details')
          .doc()
          .set(bankInfoModel.toMap());
    } else {
      print('User not Found');
    }
  }

  Future<List<BankInfoModel>> getBankDetails() async {
    User? user = _auth.currentUser;
    List<BankInfoModel> bankDetailsList = [];

    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('Account Details')
            .get();

        bankDetailsList = snapshot.docs.map((doc) {
          return BankInfoModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      } catch (e) {
        print('Error fetching bank details: $e');
      }
    } else {
      print('User not Found');
    }

    return bankDetailsList;
  }

  Future<List<Cardmodel>> getCreditDetails() async {
    User? user = _auth.currentUser;
    List<Cardmodel> cardDetailsList = [];

    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('Credit Card')
            .get();

        cardDetailsList = snapshot.docs.map((doc) {

          return Cardmodel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      } catch (e) {
        print('Error fetching bank details: $e');
      }
    } else {
      print('User not Found');
    }

    return cardDetailsList;
  }

  Future<List<Cardmodel>> getDebitDetails() async {
    User? user = _auth.currentUser;
    List<Cardmodel> cardDetailsList = [];

    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('Debit Card')
            .get();

        cardDetailsList = snapshot.docs.map((doc) {

          return Cardmodel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      } catch (e) {
        print('Error fetching bank details: $e');
      }
    } else {
      print('User not Found');
    }

    return cardDetailsList;
  }



  Future<void> logOut() async {
    try {
      await _auth.signOut();
      print('User logged out successfully.');
    } catch (e) {
      print('logOut error : $e');
    }
  }
}

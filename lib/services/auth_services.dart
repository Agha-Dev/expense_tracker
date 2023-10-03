import 'package:expense_tracker/models/expenses_model.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  Future signup(String email, String password, String username,) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('user').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
      });
    } catch (e) {
      return 300;
    }
  }
  Future addToExpenses(String uid, String description, int amount, String category,
    String docid,DateTime date) async {
    try {
      await _firestore
          .collection('user')
          .doc(uid)
          .collection('expenses')
          .doc(docid)
          .set({
        'description':description,
        'amount': amount,
        'category': category,
        'docid': docid,
        'date': date
      });
    } catch (e) {
      return 300;
    }
  }


 

  Future deleteFromExpenses(String uid, String docid) async {
    try {
      await _firestore
          .collection('user')
          .doc(uid)
          .collection('expenses')
          .doc(docid)
          .delete();
    } catch (e) {
      return 300;
    }
  }
 

  Future signin(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return 200;
    } catch (e) {
      return 300;
    }
  }

  Future getUserData() async {
    final auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance.collection("user");
    final doc = await db.doc(auth.currentUser!.uid).get();
    UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    return user;
  }
   Future<List<Expenses>> getExpensesData(String userid) async {
    final dataList = <Expenses>[];
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(userid)
        .collection('expenses')
        .get();
    if (snapshot.docs.isEmpty) {
      return dataList;
    }
    for (final doc in snapshot.docs) {
      final expensedata = Expenses.fromJson(doc.data());
      dataList.add(expensedata);
    }
    return dataList;
  }
}



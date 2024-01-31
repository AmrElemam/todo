// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/user.dart';

class UsersDao {
  static CollectionReference<User> getUsersCollection() {
    var db = FirebaseFirestore.instance;
    var collection = db.collection(User.collectionName).withConverter(
        fromFirestore: (snapshot, options) =>
            User.fromfirestore(snapshot.data()),
        toFirestore: (object, options) => object.tofirestore());
    return collection;
  }

  static Future<void> createUser(User user) {
    var userCollection = getUsersCollection();
    var doc = userCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<User?> getUser(String id) async {
    var userCollection = getUsersCollection();
    var doc = userCollection.doc(id);
    var docsnapshot = await doc.get();
    return docsnapshot.data();
  }
}

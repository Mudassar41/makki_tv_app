import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  static CollectionReference textAnnRef =
      FirebaseFirestore.instance.collection('text_announcements');

  static CollectionReference imgAnnRef =
      FirebaseFirestore.instance.collection('image_announcements');

  static Stream<QuerySnapshot> textStream = FirebaseFirestore.instance
      .collection('text_announcements')
      .orderBy('createdAt')
      .snapshots();

  static Stream<QuerySnapshot> imgStream = FirebaseFirestore.instance
      .collection('image_announcements')
      .orderBy('createdAt')
      .snapshots();

  ///
  static Future<void> addImageAnnouncementToDb(
      File file, String fileName) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref('announcements')
          .child(fileName + DateTime.now().toString());
      await storageReference.putFile(file);
      final String link = await storageReference.getDownloadURL();
      // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() async {});
      await FirebaseFirestore.instance.collection('image_announcements').add({
        'url': link,
        'createdAt': Timestamp.now(),
      });
    } catch (_) {
      print('error');
      rethrow;
    }
  }

  static Future<void> addTextAnnouncementToDb(String text) async {
    try {
      await FirebaseFirestore.instance.collection('text_announcements').add({
        'txt': text,
        'createdAt': Timestamp.now(),
      });
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> updateTextAnnouncement(String text, String docID) async {
    await textAnnRef.doc(docID).update({'txt': text});
  }

  static Future<void> delTextAnnouncement(String docID) async {
    await textAnnRef.doc(docID).delete();
  }

  static Future<void> delImgAnnouncement(String docID) async {
    await imgAnnRef.doc(docID).delete();
  }
}

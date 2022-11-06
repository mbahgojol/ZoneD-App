import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoned/data/model/FeedModel.dart';

import '../../ui/home/item_view.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference _feeds() => firestore.collection("feeds");
  final Stream<QuerySnapshot> _collectionStream =
      FirebaseFirestore.instance.collection('feeds').snapshots();

  final storageRef = FirebaseStorage.instance.ref();

  String _getCurrentDate() {
    final now = DateTime.now();
    return now.toString();
  }

  StreamBuilder<QuerySnapshot> getFeedsRealtime() =>
      StreamBuilder<QuerySnapshot>(
        stream: _collectionStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return !snapshot.hasData
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data =
                        snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                    return ItemView(model: FeedModel.fromJson(data));
                  },
                );
        },
      );

  Future<String> saveFile(String path) async {
    var imgRef = storageRef.child("images/img_${_getCurrentDate()}.jpg");
    try {
      await imgRef.putFile(File(path));
    } on FirebaseException catch (e) {
      debugPrintStack(stackTrace: e.stackTrace);
    }
    var downloadUrl = imgRef.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addFeeds(FeedModel feedModel) {
    return _feeds()
        .add(feedModel.toJson())
        .then((value) => debugPrint("Feed Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  Future<QuerySnapshot<Object?>> getFeeds() => _feeds().get();
}

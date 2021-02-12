import 'dart:io';

import 'package:ECommerceTask/model/Story.dart';
import 'package:ECommerceTask/services/Store.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/widgets.dart';

class DBStorage {
  firebase_storage.Reference _ref=  firebase_storage.FirebaseStorage.instance.ref();

  Future<void> uploadFile(File _file,name) async {

  try {
       firebase_storage.UploadTask  task=  _ref
        .child("story")
        .child(DateTime.now().millisecondsSinceEpoch.toString()+".jpg")
        .putFile(_file);
        await task;
        print(await task.snapshot.ref.fullPath);
        Store _stor=Store();
        _stor.addStory(StoryModel(
          sName: name,
          sImage:(await task.snapshot.ref.getDownloadURL()),
          sCaption: "Test Caption By Defualt Add Alrasheed",
          sType: "image"
        ));
        // .snapshot.ref.;
        print("true");
  }  catch (e) {
    print(e);
    // e.g, e.code == 'canceled'
  }
}

NetworkImage getUrlImage(String path) {
  print("path "+path);
   String url ;
    _ref.child(path).getDownloadURL().then((value) => url= value);
    // firebase_storage.FirebaseStorage.instance
    //   .ref(path)
    //   .getDownloadURL()
    print(url.toString()+" Image ");
    // Image.network(url);
    return NetworkImage(url);//   .then((value) => url=value);
  // return url;
}

}
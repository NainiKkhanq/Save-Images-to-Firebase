import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod{

  final FirebaseStorage _storage  = FirebaseStorage.instance;


  // This Future method will take childName where he can store image or if childName was not in Database Storage it will create new one
  // secondly this will take img which will be uploaded to database storage
  Future <String> uploadImagetodatabase(String childName, Uint8List img)async{
          // the below line of code will return the reference so we will save it in Reference variable
    // _storage.ref().child(childName).child("Images");
    Reference reference =  _storage.ref().child(childName).child("Images");

    // Uploading Image (In reference variable we get the database storage reference and now we are uploading (saving) the image on that reference )
    UploadTask uploadTask = reference.putData(img);

    // We also want to save this image to Fire store Database so in Fire store we will save the URL of this image and later on we will
    // show this in network image via this download URL. (Like a profile pic)

    /* First take the snapshot fromm the uploadTask and than use String to save the download URL using the snap that we get*/

    TaskSnapshot snapshot = await uploadTask;
    String  downloadURL = await snapshot.ref.getDownloadURL();

    // We Now This method will used to upload the img to database storage and than we save download link in firebase fire store.
    // So we will call this method in the place where we can save this downloadURL to fire store database because this future method
    // Will return the downloadURL in String. and also the method type is String.
    return downloadURL;



  }



}
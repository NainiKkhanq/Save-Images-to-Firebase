import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_to_firebasestorage/auth/firebase_storage_methods.dart';
class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}
Uint8List? _img;
class _HomeState extends State<Home> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea
        (
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Stack(
                children: [
                   _img !=null ? CircleAvatar(
                     radius: 64,
                     backgroundImage: MemoryImage(_img!),
                   ):const CircleAvatar(
                     radius: 64,
                     backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"),
                   ),
                  Positioned(
                      left:80 ,
                      bottom: -10,
                      child: IconButton(onPressed: (){
                        SelectImage();


                      }, icon: const Icon(Icons.add_a_photo,size: 30,color: Colors.white,))),


                ],
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(

                onPressed: ()async{


                  // calling the method that will save the img to database storage and this method is returning the downloadURL that we want to save in Firebase Storage
                  // that's why we will save the return value in a String

                  String downloadImageURL = await StorageMethod().uploadImagetodatabase("testImage", _img!);
                  // Sending the downloadImageURL to fire store
                  _firestore.collection("Users").doc("2394203422934").set({
                    'downloadImamgeURLforImage': downloadImageURL,
                  });

                }, child: Text("Upload Now"))
          ],
        ),
      ),
    );
  }

SelectImage()async{

Uint8List profileimg = await pickImage(ImageSource.gallery);
setState(() {
  _img = profileimg;
});

  }

  pickImage(ImageSource imageSource)async{
    final ImagePicker _imagePicker = ImagePicker();
    XFile? file = await _imagePicker.pickImage(source: imageSource);
    if(file !=null){
      return await file.readAsBytes();
    }else{
      print("No Image was Picked");
    }


  }

}

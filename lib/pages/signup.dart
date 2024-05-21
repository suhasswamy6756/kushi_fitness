// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/components/textfield.dart';
import 'package:kushi_3/model/user_data.dart';

// import 'package:kushi_3/service/auth/auth_controller.dart';
import 'package:kushi_3/service/firestore_service.dart';

// import '../chat_application/pages/image_picker_page.dart';

FirestoreService _firestoreService = FirestoreService();

class SignUp extends StatefulWidget {

  const SignUp({super.key});


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? imageCamera;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  String profileUrl = '';
  bool isLoading = false;

  Uint8List? imageGallery;
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _phoneNumber;

  String? userEmail;
  File? _imageFile;


  final picker = ImagePicker();

  // Function to open gallery and set selected image
  Future<void> _openGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Function to upload image to Firebase Storage
  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      print('No image selected.');
      return;
    }
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Uploading image to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('images/$userId');
    await storageRef.putFile(_imageFile!);
    final downloadUrl = await storageRef.getDownloadURL();
    setState(() {
      profileUrl = downloadUrl.toString();
    });

    print('Image uploaded successfully.');
  }

  void fetchUserPhone() async {
    String? phone = _firestoreService.phoneNumberReturn();
    setState(() {
      _phoneNumber = phone;
    });
  }


  @override
  void initState() {
    super.initState();
    fetchUserEmail();
  }

  Future<void> fetchUserEmail() async {
    String? email = await _firestoreService.getCurrentUserEmail();
    setState(() {
      userEmail = email;
    });
  }

  void _openImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => _getImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => _getImage(ImageSource.camera),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    Navigator.of(context).pop(); // Close modal sheet after image selection
  }

  // Function to upload image to Firebase Storage
  // Future<void> _uploadImageToFirebase() async {
  //   if (_imageFile == null) {
  //     print('No image selected.');
  //     return;
  //   }
  //
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference storageReference =
  //   storage.ref().child('images/${DateTime.now()}.png');
  //
  //   UploadTask uploadTask = storageReference.putFile(_imageFile!);
  //   await uploadTask.whenComplete(() => print('Image uploaded to Firebase'));
  //
  //   setState(() {
  //     // Reset image after upload
  //     _imageFile = null;
  //   });
  // }


  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Circular icon button to open gallery
                IconButton(
                  icon: _imageFile != null
                      ? CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_imageFile!),
                  )
                      : const Icon(Icons.add_photo_alternate),
                  iconSize: 100,
                  onPressed: _openGallery,
                ),
                const SizedBox(height: 20),
                // Button to upload image to Firebase Storage

              ],
            ),

            const SizedBox(height: 20),

            MyTextField(
              hintText: "Full Name",
              obscureText: false,
              controller: _fullnameController,
              readOnly: false,
              hintColor: Colors.grey,
            ),


            const SizedBox(height: 25,),
            MyTextField(
              hintText: userEmail != null ? "$userEmail" : " Email",
              obscureText: false,
              controller: _emailController,
              readOnly: userEmail == null ? false : true,
              hintColor: userEmail == null ? Colors.grey : Colors.black,

            ),
            const SizedBox(height: 25,),


            MyTextField(
              hintText: _firestoreService.phoneNumberReturn() ?? "Phone number",
              obscureText: false,
              controller: _phonenNumberController,
              readOnly: _firestoreService.phoneNumberReturn() == null
                  ? false
                  : true,
              hintColor: _firestoreService.phoneNumberReturn() == null ? Colors
                  .grey : Colors.black,
            ),

            // Text(_firestoreService.fetchFieldValue(_firestoreService.getUserId().toString(), "phoneNumber").toString()),
            const SizedBox(height: 25,),

            const SizedBox(height: 10,),


            const SizedBox(height: 10,),
            MyButton(text: "Sign Up", onTap: () async {
              setState(() {
                isLoading = true;
              });
              await _uploadImage();
              userDataMap['email_id'] = _emailController.text;

              userDataMap['profileUrl'] = profileUrl;
              userDataMap['full_name'] = _fullnameController.text;

              // await _firestoreService.addContactNumberToUserDocument(userDataMap['phoneNumber'], userDataMap['email_id']);

              await _firestoreService.setUserDocument(
                  _firestoreService.getCurrentUserId()!, userDataMap, context)
                  .then((value) => Navigator.pushNamed(context, '/stepper'));
              setState(() {
                isLoading = false;
              });
            },
            ),
            const SizedBox(height: 15,),

            const SizedBox(height: 50,),
            // Text(_phoneNumber)


          ],
        ),
      ),
      floatingActionButton: isLoading ? const LoadingWidget() : null,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userDataMap.clear();
  }



}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background: Transparent container to capture touch events
        Container(
          color: Colors.black.withOpacity(0.3),
          constraints: const BoxConstraints.expand(),
        ),
        // Loading indicator
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}


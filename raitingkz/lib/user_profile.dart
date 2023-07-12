import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'auth.dart';

import 'design_course/design_course_app_theme.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final User? currentUser = Auth().currentUser;
  bool isEditiingMode = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Positioned(
            top: 32.0,
            right: 12.0,
            child: IconButton(
              icon: Icon(
                Icons.edit,
              ),
              onPressed: () {
                setState(() {
                  isEditiingMode = !isEditiingMode;
                });
              },
            ),
          ),
          Positioned(
            top: 32.0,
            left: 12.0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15 - 75,
            left: MediaQuery.of(context).size.width * 0.5 - 75,
            child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: DesignCourseAppTheme.nearlyWhite,
                    borderRadius: BorderRadius.all(Radius.circular(1000))),
                child: isEditiingMode
                    ? !_loading
                        ? GestureDetector(
                            onTap: changeUserImage,
                            child: CircleAvatar(
                                child: Icon(
                              Icons.photo,
                              size: 30,
                            )),
                          )
                        : CircularProgressIndicator()
                    : CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(currentUser!
                                .photoURL ??
                            'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg'))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Text(
                            currentUser?.email ?? 'user',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.27,
                              color: DesignCourseAppTheme.darkerText,
                            ),
                          ),
                        ),
                        Text(
                          'Cras non metus molestie risus posuere vulputate sed ut ipsum. Phasellus et risus eget arcu mattis egestas nec at nulla. Nulla dignissim, nisl a facilisis gravida, nisl urna commodo tellus, a mollis libero augue in sapien. Sed ut mattis lectus. Vestibulum tempus dolor non nulla efficitur, sed fermentum dolor tincidunt.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            letterSpacing: 0.27,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: FilledButton(
              child: Text('Log Out'),
              onPressed: () {
                Auth().signOut();
                SystemNavigator.pop();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> changeUserImage() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? xfile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    File image = File(xfile!.path);

    String imageUrl = await uploadImageToStorageAndReturnUrl(image);
    await currentUser?.updatePhotoURL(imageUrl);
    setState(() {
      _loading = false;
    });
  }

  Future<String> uploadImageToStorageAndReturnUrl(File? image) async {
    setState(() {
      _loading = true;
    });
    final String uid = currentUser!.uid;
    final Reference reference =
        FirebaseStorage.instance.ref("profile_images/${uid}");
    await reference.putFile(image as File);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}

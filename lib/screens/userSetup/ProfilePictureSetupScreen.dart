import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureSetupScreen extends StatefulWidget {
  final NavHostController navController;

  ProfilePictureSetupScreen({required this.navController});

  @override
  _ProfilePictureSetupScreenState createState() =>
      _ProfilePictureSetupScreenState();
}

class _ProfilePictureSetupScreenState extends State<ProfilePictureSetupScreen> {
  String imageBtnText = 'Upload image';
  late String imageUri;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Let us see who you are!',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                _buildProfileImage(),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _pickImage(),
                  child: Text(imageBtnText),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (imageUri != null) {
                      // Perform necessary actions with the selected image URI
                      // For example, upload the image and navigate to the next screen
                      // You can replace this with your logic
                      widget.navController.navigate('/main');
                    }
                  },
                  child: Text('Done!'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Image.network(
      imageUri ?? 'https://example.com/default_profile_image.png',
      width: 200,
      height: 200,
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageUri = pickedFile.path;
        imageBtnText = 'Change image';
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePictureSetupScreen(navController: NavHostController()),
  ));
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePickerBottomSheet extends StatelessWidget {
  final Function(ImageSource source) onImagePicked;

  const CustomImagePickerBottomSheet({
    super.key,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.20,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white, // Use your theme or preferred color
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                onImagePicked(ImageSource.camera);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.camera,
                    size: size.height * 0.036,
                    color: Colors.black,
                  ),
                  SizedBox(width: size.width * 0.03),
                  Text(
                    'Take Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.046,
                      color: Colors.black,
                      fontFamily: "NunitoSans",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            InkWell(
              onTap: () {
                onImagePicked(ImageSource.gallery);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.photo,
                    size: size.height * 0.036,
                    color: Colors.black,
                  ),
                  SizedBox(width: size.width * 0.03),
                  Text(
                    'Pick from Gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.046,
                      color: Colors.black,
                      fontFamily: "NunitoSans",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../app_exports.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
          _imageFile != null
              ? FileImage(_imageFile!)
              : AssetImage(Assets.pngAssetsTeslaAvatar) as ImageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 7,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: getProportionateScreenHeight(22),
              width: getProportionateScreenWidth(22),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.camera_alt, color: kBlackColor, size: 12),
            ),
          ),
        ),
      ],
    );
  }
}

import '../../../app_exports.dart';

final List<String?> genderList = [
  'Male',
  'Female',
  'Non-Binary',
  'Transgender',
  'Prefer Not to Say',
];

final List<Map<String, dynamic>> profileFields = [
  {
    'title': 'Email',
    'hintText': 'user123@gmail.com',
    'prefixIcon': Icon(Icons.mail_outline, color: Colors.grey, size: 16),
    'read': true,
  },
  {
    'title': 'First Name',
    'hintText': 'Enter first name',
    'read': false,
    'prefixIcon': SvgPicture.asset(
      Assets.svgAssetsIconProfile,
      colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
    ),
  },
  {
    'title': 'Last Name',
    'hintText': 'Enter last name',
    'read': false,
    'prefixIcon': SvgPicture.asset(Assets.svgAssetsIconProfile, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
    ),
  },
];

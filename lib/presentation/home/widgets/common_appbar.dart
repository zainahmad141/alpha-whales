import '../../../app_exports.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      showBackIcon: false,
      prefixIcon: CircleAvatar(
        child: Image.asset(
          Assets.pngAssetsAvatarImage,
          height: getProportionateScreenHeight(60),
        ),
      ),
      titleText: "Emily Jones",
      subtitleText: "emilyjames@gmail.com",
      suffixIcon1: SvgPicture.asset(Assets.svgAssetsAppbarSearch),
      suffixIcon2: SvgPicture.asset(Assets.svgAssetsAppbarSetting),
      onSuffix2Pressed: () {
        Navigator.pushNamed(context, RouteName.settings);
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 22);
}

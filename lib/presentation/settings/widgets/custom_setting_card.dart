import 'package:alpha_whales/app_exports.dart';

class CustomAccountCard extends StatelessWidget {
  final IconData? icon;
  final String? iconAsset;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;

  const CustomAccountCard({
    super.key,
    this.icon,
    this.iconAsset,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.backgroundColor,
    this.iconBackgroundColor,
    this.titleColor,
    this.subtitleColor,
  }) : assert(icon != null || iconAsset != null, 'Either icon or iconAsset must be provided');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10),horizontal: getProportionateScreenWidth(14)),
        decoration: BoxDecoration(
          color: kBgColor,
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
        ),
        child: Row(
          children: [
            Container(
              width: getProportionateScreenWidth(40),
              height: getProportionateScreenWidth(40),
              decoration: BoxDecoration(
                color: kHintTextColor,
                borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
              ),
              child: Center(
                child: iconAsset != null
                    ? SvgPicture.asset(
                  iconAsset!,
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenWidth(20),
                  colorFilter: const ColorFilter.mode(
                    kWhiteColor,
                    BlendMode.srcIn,
                  ),
                )
                    : Icon(
                  icon!,
                  size: getProportionateScreenWidth(20),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppStyles.w500f14poppins.copyWith(color: kWhiteColor)
                  ),
                  Text(
                    subtitle,
                      style: AppStyles.w400f12poppins.copyWith(color: kMutedGrayColor)
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

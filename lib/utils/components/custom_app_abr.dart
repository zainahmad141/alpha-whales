import '../../main.dart' as navigation_service;
import '/app_exports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackIcon;
  final Widget? title;
  final String? backgroundImage;

  final Widget? prefixIcon;
  final String? titleText;
  final String? subtitleText;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? suffixIcon1;
  final Widget? suffixIcon2;
  final VoidCallback? onPrefixPressed;
  final VoidCallback? onSuffix1Pressed;
  final VoidCallback? onSuffix2Pressed;
  final bool showDivider;
  final Color? dividerColor;
  final EdgeInsets? contentPadding;

  const CustomAppBar({
    super.key,
    this.showBackIcon = true,
    this.title,
    this.backgroundImage,
    this.prefixIcon,
    this.titleText,
    this.subtitleText,
    this.titleStyle,
    this.subtitleStyle,
    this.suffixIcon1,
    this.suffixIcon2,
    this.onPrefixPressed,
    this.onSuffix1Pressed,
    this.onSuffix2Pressed,
    this.showDivider = true,
    this.dividerColor,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundImage == null ? kScaffoldColor : null,
            image: backgroundImage != null
                ? DecorationImage(
              image: AssetImage(backgroundImage!),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                kPrimaryColor.withValues(alpha: 0.7),
                BlendMode.overlay,
              ),
            )
                : null,
          ),
          child: SafeArea(
            child: Padding(
              padding: contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(16),
                  ),
              child: Row(
                children: [
                  if (prefixIcon != null || showBackIcon)
                    GestureDetector(
                      onTap: onPrefixPressed ??
                          (showBackIcon ? () => Navigator.of(context).pop() : null),
                      child: prefixIcon ??
                          (showBackIcon
                              ? const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          )
                              : const SizedBox()),
                    ),

                  if (prefixIcon != null || showBackIcon)
                    SizedBox(width: getProportionateScreenWidth(6)),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (titleText != null || title != null)
                          title ?? Text(
                            titleText!,
                            style: titleStyle ??
                                AppStyles.w600f18poppins.copyWith(fontSize: 14,color: kWhiteColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (subtitleText != null) ...[
                          SizedBox(height: getProportionateScreenHeight(2)),
                          Text(
                            subtitleText!,
                            style: subtitleStyle ??
                                AppStyles.w600f18poppins.copyWith(fontSize: 10,color: kHintTextColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (suffixIcon1 != null) ...[
                        GestureDetector(
                          onTap: onSuffix1Pressed,
                          child: suffixIcon1!,
                        ),
                        SizedBox(width: getProportionateScreenWidth(6)),
                      ],
                      if (suffixIcon2 != null)
                        GestureDetector(
                          onTap: onSuffix2Pressed,
                          child: suffixIcon2!,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Container(
            height: 1,
            color: dividerColor ?? Color(0xff1F2735),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      getProportionateScreenHeight(80) +
          (showDivider ? 1 : 0) +
          MediaQuery.of(navigation_service.navigatorKey.currentContext!).padding.top
  );
}
class CircularAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final double size;
  final Color? borderColor;
  final double borderWidth;
  final Widget? fallback;

  const CircularAvatar({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.size = 40.0,
    this.borderColor,
    this.borderWidth = 0.0,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderWidth > 0
            ? Border.all(color: borderColor ?? Color(0xff1F2735), width: borderWidth)
            : null,
      ),
      child: ClipOval(
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    } else if (assetPath != null) {
      return Image.asset(
        assetPath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    } else {
      return _buildFallback();
    }
  }

  Widget _buildFallback() {
    return fallback ??
        Container(
          color: Colors.grey[300],
          child: Icon(
            Icons.person,
            size: size * 0.6,
            color: Colors.grey[600],
          ),
        );
  }
}

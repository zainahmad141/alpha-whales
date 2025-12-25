import 'package:alpha_whales/app_exports.dart';

class CustomDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(getProportionateScreenHeight(20)),
        backgroundColor: kBgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppStyles.w600f16poppins),
              SizedBox(height: getProportionateScreenHeight(5)),
              Text(
                textAlign: TextAlign.center,
                message,
                style: AppStyles.w400f14poppins.copyWith(
                  color: kLightGrayColor,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              Row(
                spacing: getProportionateScreenWidth(8),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomActionButton(
                    buttonText: cancelText,
                    onTap: () {
                      Navigator.pop(context);
                      onCancel?.call();
                    },
                    width: getProportionateScreenWidth(87),
                    backgroundColor: kHintTextColor,
                  ),
                  CustomActionButton(
                    buttonText: confirmText,
                    onTap: () {
                      Navigator.pop(context);
                      onConfirm?.call();
                    },
                    width: getProportionateScreenWidth(87),
                    backgroundColor: kRedStatusColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

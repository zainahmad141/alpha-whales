import 'package:alpha_whales/app_exports.dart';

class CustomLoader {
  static bool _isShowing = false;

  static void show(BuildContext context, {String? message}) {
    if (!_isShowing) {
      _isShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: kWhiteColor,
                strokeWidth: 5,
              ),
              if (message != null) ...[
                const SizedBox(height: 8),
                Text(
                  message,
                  style: AppStyles.w600f10poppins.copyWith(color: kWhiteColor),
                ),
              ],
            ],
          ),
        ),
      );
    }
  }

  static void hide(BuildContext context) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}

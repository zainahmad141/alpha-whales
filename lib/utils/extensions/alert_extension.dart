import 'dart:ui';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../app_exports.dart';

extension ExtensionOnContext on BuildContext {
  void showToast(String message, {bool isError = false, VoidCallback? onTap}) {
    Color snakeColor = isError ? Colors.red : Colors.green;
    DelightToastBar.removeAll();
    DelightToastBar(
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      builder: (context) => InkWell(
        onTap: () {
          DelightToastBar.removeAll();
          onTap?.call();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
            color: kScaffoldColor.withAlpha(204),
            border: Border.all(
              color: snakeColor,
              width: 1,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: snakeColor.withAlpha(25),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: snakeColor,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    ).show(this);
  }

  pop() {
    Navigator.pop(this);
  }

  void showLoading({Color color = kPrimaryColor}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) {
        return  Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
            color: color,
            size: 50,
        ),
        );
      },
    );
  }

  void showAppDialog(
      BuildContext context, {
        void Function()? onYes,
        void Function()? onNo,
        required final Widget child,
        required String yesText,
        required String noText,
        required Widget icon,
        Color yesButtonBgColor = kPrimaryColor,
        Color yesButtonTextColor = kScaffoldBlackColor,
        Color noButtonBgColor = kWhiteColor,
        Color noButtonTextColor = kBlackColor,
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            content: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.26),
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        icon,
                        child,
                        Row(
                          children: [
                            Expanded(
                              child: CustomActionButton(
                                buttonText: noText,
                                borderRadius: 8,
                                backgroundColor: kAppGradient,
                                buttonTextColor: noButtonTextColor,
                                onTap: onNo,
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(8),
                            ),
                            Expanded(
                              child: CustomActionButton(
                                buttonText: yesText,
                                backgroundColor: kAppGradient,
                                borderRadius: 8,
                                buttonTextColor: yesButtonTextColor,
                                onTap: onYes,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }



  TextTheme get textTheme => Theme.of(this).textTheme;

  showBottomSheet(Widget content) {
    return showModalBottomSheet(
      context: this,
      enableDrag: true,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: kAppGreenColor,
      elevation: 10,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: getProportionateScreenWidth(16),
            right: getProportionateScreenWidth(16),
          ),
          child: content,
        );
      },
    );
  }
}
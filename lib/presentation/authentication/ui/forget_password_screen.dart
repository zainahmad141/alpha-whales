import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../di/locator.dart';
import '/app_exports.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  ValueNotifier<bool> showLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.pngAssetsBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Forget Password?", style: AppStyles.w600f32poppins),
                  Text(
                    "Please enter your email account to reset your password.",
                    style: AppStyles.w500f12poppins,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getProportionateScreenHeight(80)),
                  CustomTextField(
                    validator: ValidateForm.validateEmail,
                    controller: _emailController,
                    hintText: "Enter email address",
                    fieldTitle: "Email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: kHintTextColor,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  ValueListenableBuilder(
                    valueListenable: showLoading,
                    builder: (context, value, child) => value
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: kSecondaryColor,
                              size: 50,
                            ),
                          )
                        : CustomActionButton(
                            buttonText: 'Continue',
                            onTap: _handlePasswordReset,
                          ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  CustomRichText(
                    actionText: " Login",
                    leadingText: "Remember password?",
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.signIn);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePasswordReset() async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoading.value = true;
        await locator.get<AuthenticationProvider>().sendPasswordResetEmail(
          _emailController.text.trim(),
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RouteName.signIn);
        context.showToast("Password reset email has been sent to you email");
        showLoading.value = false;
      } on FirebaseAuthException catch (e) {
        showLoading.value = false;
        context.showToast(e.message.toString(), isError: true);
      } catch (e) {
        showLoading.value = false;
        context.showToast(e.toString(), isError: true);
      }
    }
  }
}

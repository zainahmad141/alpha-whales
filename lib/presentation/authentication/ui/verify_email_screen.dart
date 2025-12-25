import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../di/locator.dart';
import '/app_exports.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

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
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacementNamed(context, RouteName.navBar);
                context.showToast("Email verified successfully!");
              } else if (state is LoginFailure) {
                context.showToast(
                  state.error ?? "Verification failed. Please try again.",
                  isError: true,
                );
              } else if (state is LoginVerification) {
                if (state.error != null) {
                  context.showToast(state.error!, isError: true);
                }
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Verify Your Email", style: AppStyles.w600f32poppins),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      "We've sent a verification email to your registered email address. Please check your email and click the verification link.",
                      style: AppStyles.w500f12poppins,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    Icon(
                      Icons.email_outlined,
                      size: 80,
                      color: kSecondaryColor,
                    ),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    Text(
                      "Didn't receive the email? Check your spam folder or click resend below.",
                      style: AppStyles.w400f12poppins.copyWith(color: kWhiteColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    state is LoginInProgress
                        ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: kSecondaryColor,
                        size: 50,
                      ),
                    )
                        : Column(
                      children: [
                        CustomActionButton(
                          buttonText: 'I\'ve Verified',
                          onTap: _handleVerifyEmail,
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        CustomActionButton(
                          buttonText: 'Resend Email',
                          onTap: _handleResendEmail,
                          backgroundColor: Colors.transparent,
                          borderColor: kSecondaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    CustomRichText(
                      actionText: " Sign In",
                      leadingText: "Want to use different email?",
                      onTap: () {
                        _handleSignOut();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleVerifyEmail() {
    _loginBloc.add(VerifyEmailButtonPressed());
  }

  Future<void> _handleResendEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        if (mounted) {
          context.showToast("Verification email sent!");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        context.showToast(e.message.toString(), isError: true);
      }
    } catch (e) {
      if (mounted) {
        context.showToast(e.toString(), isError: true);
      }
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await locator.get<AuthenticationProvider>().signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.signIn,
              (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        context.showToast("Error signing out", isError: true);
      }
    }
  }
}
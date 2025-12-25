import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/app_exports.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> showLoading = ValueNotifier(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    showLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showLoading.value = false;
          Navigator.pushReplacementNamed(context, RouteName.navBar);
        } else if (state is LoginFailure) {
          showLoading.value = false;
          context.showToast(state.error ?? 'Login failed', isError: true);
        } else if (state is LoginVerification) {
          showLoading.value = false;
          Navigator.pushReplacementNamed(context, RouteName.verifyEmail);
          context.showToast("Please verify your email before signing in. Check your inbox for verification email.");
        } else if (state is LoginInProgress) {
          showLoading.value = true;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.pngAssetsAuthGradient),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome Back!", style: AppStyles.w600f32poppins),
                      Text(
                        "Enter your credentials to access your account!",
                        style: AppStyles.w500f12poppins,
                      ),
                      SizedBox(height: getProportionateScreenHeight(48)),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Enter email address",
                        fieldTitle: "Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: kHintTextColor,
                        ),
                        validator: ValidateForm.validateEmail,
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Enter password",
                        fieldTitle: "Password",
                        prefixIcon: SvgPicture.asset(
                            Assets.svgAssetsPasswordIcon),
                        validator: ValidateForm.passwordValidator,
                        obscureText: true,
                      ),
                      SizedBox(height: getProportionateScreenHeight(4)),
                      ForgetPasswordButton(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.forgetPassword);
                        },
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
                          buttonText: "Login",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print("Button Tapped");
                              context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  username: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                          backgroundColor: kAppGradient,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      OrContinueWithDivider(),
                      SizedBox(height: getProportionateScreenHeight(18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: getProportionateScreenWidth(20),
                        children: [
                          Image.asset(
                            Assets.pngAssetsButtons,
                            height: getProportionateScreenHeight(44),
                          ),
                          Image.asset(
                            Assets.pngAssetsButtons1,
                            height: getProportionateScreenHeight(44),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      CustomRichText(
                        actionText: " SignUp",
                        leadingText: "Don't have an account?",
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.signUp);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
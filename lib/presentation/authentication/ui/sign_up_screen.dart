import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../data/model/user_model.dart';
import '/app_exports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> showLoading = ValueNotifier(false);

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    showLoading.dispose();
    super.dispose();
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
            image: AssetImage(Assets.pngAssetsAuthGradient),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                showLoading.value = false;
                Navigator.pushReplacementNamed(context, RouteName.verifyEmail);
                context.showToast("Account created! Please check your email to verify your account.");
              } else if (state is SignUpFailure) {
                showLoading.value = false;
                context.showToast(state.error, isError: true);
              } else if (state is LoginVerification) {
                showLoading.value = false;
                Navigator.pushReplacementNamed(context, RouteName.verifyEmail);
              } else if (state is LoginInProgress) {
                showLoading.value = true;
              }
            },
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Create New Account", style: AppStyles.w600f32poppins),
                    Text(
                      "Enter following details to signup and start using the app",
                      style: AppStyles.w500f12poppins,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getProportionateScreenHeight(48)),
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Enter your name",
                      fieldTitle: "Full Name",
                      prefixIcon: SvgPicture.asset(Assets.svgAssetsPersonIcon),
                      validator: ValidateForm.fullNameValidator,
                    ),
                    SizedBox(height: getProportionateScreenHeight(12)),
                    CustomTextField(
                      controller: _emailController,
                      validator: ValidateForm.validateEmail,
                      hintText: "Enter email address",
                      fieldTitle: "Email",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: kHintTextColor,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(12)),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Enter password",
                      fieldTitle: "Password",
                      prefixIcon: SvgPicture.asset(Assets.svgAssetsPasswordIcon),
                      validator: ValidateForm.passwordValidator,
                      obscureText: true,
                    ),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    ValueListenableBuilder(
                      valueListenable: showLoading,
                      builder: (context, value, child) => value
                          ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: kPrimaryColor,
                          size: 50,
                        ),
                      )
                          : CustomActionButton(
                        buttonText: "Sign Up",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                              SignUpButtonPressed(
                                user: UserModel(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              ),
                            );
                          }
                        },
                        backgroundColor: kAppGradient,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(35)),
                    OrContinueWithDivider(),
                    SizedBox(height: getProportionateScreenHeight(15)),
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
                    SizedBox(height: getProportionateScreenHeight(35)),
                    CustomRichText(
                      actionText: " Login",
                      leadingText: "Already have an account?",
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
      ),
    );
  }
}
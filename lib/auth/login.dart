import 'package:flutter/material.dart';
import 'package:gchat/auth/signup.dart';

import '../screens/bottom_bar.dart';
import '../splash/splash_screen.dart';
import '../utils/auth_service.dart';
import '../utils/colors.dart';
import '../utils/validators.dart';
import '../widgets/buttons.dart';
import '../widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  Future<void> login(context) async {
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
          emailController.text, passwordController.text);

      //navidate tto homepage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBarPage()),
      );
    }
    //catch
    catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDone =
        emailController.text.length >= 3 && passwordController.text.length >= 8;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        // foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 8),
              GChatText(
                text: "Login with your existing account",
                fontColor: AppColors.grey2,
                textAlign: TextAlign.start,
              ),

              SizedBox(
                height: 24,
              ),
              //email
              AppTextField(
                labelText: 'Email',
                textInputAction: TextInputAction.next,
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) => EmailValidator.validateEmail(value!),
              ),

              SizedBox(
                height: 24,
              ),
              //password
              AppTextField(
                labelText: 'Password',
                textInputAction: TextInputAction.done,
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) =>
                    PasswordValidator.validatePassword(value!),
              ),
              // SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isDone
                ? AppButton(
                    text: "LOGIN",
                    textColor: Colors.white,
                    ontap: () => login(context),
                    // () {
                    //   if (_formKey.currentState!.validate()) {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => BottomBarPage()),
                    //     );
                    //   }
                    // },
                  )
                :
                // button inactive until all conditions are met
                AppButton(
                    text: "LOGIN",
                    textColor: Colors.white,
                    borderColor: const Color.fromARGB(255, 142, 162, 200),
                    buttonColor: const Color.fromARGB(255, 142, 162, 200),
                    ontap: () {},
                  ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: "Dont't have an account ",
                  style: TextStyle(
                      color: Colors.black, fontFamily: "Roboto", fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(
                        color: AppColors.appThemeColor,
                        fontFamily: "Roboto",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../screens/bottom_bar.dart';
// import '../splash/splash_screen.dart';
import '../utils/auth_service.dart';
import '../utils/colors.dart';
import '../utils/validators.dart';
import '../widgets/app_loader.dart';
import '../widgets/buttons.dart';
import '../widgets/textfield.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  bool _isLoading = false;

  void register(context) async {
    final authService = AuthService();

    setState(() {
      _isLoading = true;
    });

    try {
      await authService.signUpWithEmailPassword(
        emailController.text,
        passwordController.text,
        nameController.text,
        context,
      );

      setState(() {
        _isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBarPage()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Registration Failed"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDone = emailController.text.length >= 3 &&
        nameController.text.length >= 3 &&
        passwordController.text.length >= 8;
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
                'Sign Up',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 8),
              GChatText(
                text: "Fill out the fields below to register on\nGChat",
                fontColor: AppColors.grey2,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 24),
              AppTextField(
                labelText: 'Name',
                textInputAction: TextInputAction.next,
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) => NameValidator.validateEmptyfield(value!),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
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
            _isLoading
                ? Center(
                    child: AppLoader(color: AppColors.appThemeColor),
                  )
                : isDone
                    ? AppButton(
                        text: "REGISTER",
                        textColor: Colors.white,
                        ontap: () {
                          if (_formKey.currentState!.validate()) {
                            register(context);
                          }
                        },
                      )
                    : AppButton(
                        text: "REGISTER",
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
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account?  ',
                  style: TextStyle(
                      color: Colors.black, fontFamily: "Roboto", fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'Login',
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

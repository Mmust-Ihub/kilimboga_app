import 'package:kilimboga/components/login_page.dart';
import 'package:kilimboga/components/validate_otp.dart';
import 'package:kilimboga/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:kilimboga/components/input.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Consumer<AuthProvider>(
            builder:
                (BuildContext context, AuthProvider provider, Widget? child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 215,
                            width: 200,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.webp'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Text(
                            "Create an Account",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(height: 30),
                  InputComponent(
                    hintText: 'User name',
                    prefixIcon: Icon(Icons.person, color: Colors.grey.shade500),
                    controller: username,
                    readOnly: provider.isLoading ? true : false,
                  ),
                  const SizedBox(height: 30),
                  InputComponent(
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.grey.shade500),
                    controller: email,
                    readOnly: provider.isLoading ? true : false,
                  ),
                  const SizedBox(height: 20),
                  InputComponent(
                    hintText: 'Password',
                    isPassword: true,
                    prefixIcon:
                        Icon(Icons.lock_outline, color: Colors.grey.shade500),
                    controller: password,
                    readOnly: provider.isLoading ? true : false,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade300,
                          Colors.blue.shade400,
                          Colors.blue.shade500,
                        ],
                      ),
                    ),
                    child: TextButton(
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                              if (email.text.trim().isNotEmpty &&
                                  password.text.trim().isNotEmpty &&
                                  username.text.isNotEmpty) {
                                int statusCode = await provider.createUser(
                                    email.text.trim(),
                                    username.text,
                                    password.text.trim());

                                if (statusCode == 201) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const ValidateOtp(
                                            ),),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Something went wrong, try again!"),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              }
                            },
                      child: Text(
                        provider.isLoading ? provider.message : "Sign Up",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: provider.isLoading
                        ? null
                        : () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    maintainState: false,
                                    builder: (context) => const LoginPage()));
                          },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}

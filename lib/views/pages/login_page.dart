// ignore_for_file: use_build_context_synchronously

import 'package:kilimboga/views/pages/signup_page.dart';
import 'package:kilimboga/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:kilimboga/components/input.dart';
import 'package:kilimboga/views/pages/farmer.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                            "Login To Your Account",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(height: 30),
                  InputComponent(
                    hintText: 'Email or username',
                    controller: email,
                    readOnly: provider.isLoading ? true : false,
                  ),
                  const SizedBox(height: 20),
                  InputComponent(
                    hintText: 'Password',
                    isPassword: true,
                    controller: password,
                    readOnly: provider.isLoading ? true : false,
                  ),
                  const SizedBox(height: 20),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 40.0, vertical: 5),
                  //   decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.all(Radius.circular(15)),
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       colors: [
                  //         Colors.blue.shade300,
                  //         Colors.blue.shade400,
                  //         Colors.blue.shade500,
                  //       ],
                  //     ),
                  //   ),
                  //   child: TextButton(
                  //     onPressed: provider.isLoading
                  //         ? null
                  //         : () async {
                  //             int statusCode = await provider.authUser(
                  //                 email.text, password.text.trim());

                  //             if (statusCode == 200) {
                  //               Navigator.of(context).pushReplacement(
                  //                   MaterialPageRoute(
                  //                       builder: (context) => const Farmer()));
                  //             } else if (statusCode == 500) {
                  //               ScaffoldMessenger.of(context).showSnackBar(
                  //                 const SnackBar(
                  //                   content:
                  //                       Text('Something went wrong,try again!'),
                  //                   duration: Duration(seconds: 3),
                  //                 ),
                  //               );
                  //             } else if (statusCode == 401) {
                  //               ScaffoldMessenger.of(context).showSnackBar(
                  //                 const SnackBar(
                  //                   content: Text('Unauthorized,try again!'),
                  //                   duration: Duration(seconds: 3),
                  //                 ),
                  //               );
                  //             } else {
                  //               ScaffoldMessenger.of(context).showSnackBar(
                  //                 const SnackBar(
                  //                   content:
                  //                       Text('Invalid credentials,try again!'),
                  //                   duration: Duration(seconds: 3),
                  //                 ),
                  //               );
                  //             }
                  //           },
                  //     child: Text(
                  //       provider.isLoading ? provider.message : "Login",
                  //       style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
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
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Farmer()));
                      },
                      child: Text(
                        provider.isLoading ? provider.message : "Login",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          maintainState: false,
                          builder: (context) => const SignupPage()));
                    },
                    child: const Text(
                      "Don't have an account? Sign up",
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

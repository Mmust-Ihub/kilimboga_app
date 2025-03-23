import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/layout/patient/patient.dart';
import 'package:kilimboga/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ValidateOtp extends StatefulWidget {

  const ValidateOtp({super.key});

  @override
  State<ValidateOtp> createState() => _ValidateOtpState();
}

class _ValidateOtpState extends State<ValidateOtp> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<AuthProvider>(
            builder:
                (BuildContext context, AuthProvider provider, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Verification Code",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "Code was sent to the email below: ",
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade500),
                        ),
                        Text(
                          preuser!.email,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Form(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: TextFormField(
                                      controller: _controller1,
                                      readOnly:
                                          provider.isLoading ? true : false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade300,
                                          border: InputBorder.none),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ]),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: TextFormField(
                                      controller: _controller2,
                                      readOnly:
                                          provider.isLoading ? true : false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade300,
                                          border: InputBorder.none),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ]),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: TextFormField(
                                      controller: _controller3,
                                      readOnly:
                                          provider.isLoading ? true : false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade300,
                                          border: InputBorder.none),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ]),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: TextFormField(
                                      controller: _controller4,
                                      readOnly:
                                          provider.isLoading ? true : false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade300,
                                          border: InputBorder.none),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ]),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: TextFormField(
                                      controller: _controller5,
                                      readOnly:
                                          provider.isLoading ? true : false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade300,
                                          border: InputBorder.none),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ]),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: TextFormField(
                                      controller: _controller6,
                                      readOnly:
                                          provider.isLoading ? true : false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade300,
                                          border: InputBorder.none),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ]),
                                ),
                              ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.grey.shade500,
                              size: 16,
                            ),
                            Text(
                              "1:32",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade500),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            textStyle: WidgetStatePropertyAll(
                              TextStyle(
                                backgroundColor: Colors.transparent,
                                wordSpacing: 1.0,
                                decorationThickness: 1.2,
                              ),
                            ),
                            side: WidgetStatePropertyAll(
                                BorderSide(color: Colors.blue),),),
                        child: const Text("Resend Code"),
                      ),
                      FilledButton(
                          onPressed: provider.isLoading
                              ? null
                              : () async {
                                  if (_controller1.text.trim().isNotEmpty &&
                                      _controller2.text.trim().isNotEmpty &&
                                      _controller3.text.trim().isNotEmpty &&
                                      _controller4.text.trim().isNotEmpty &&
                                      _controller5.text.trim().isNotEmpty &&
                                      _controller6.text.trim().isNotEmpty) {
                                    String otp = _controller1.text +
                                        _controller2.text +
                                        _controller3.text +
                                        _controller4.text +
                                        _controller5.text +
                                        _controller6.text;

                                    int statusCode =
                                        await provider.validateToken(
                                            preuser!.email, otp, preuser!.password);

                                    if (statusCode != 200) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Something went wrong, try again!"),
                                        duration: Duration(seconds: 3),
                                      ));
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Patient()));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Finish filling the tokens!"),
                                      duration: Duration(seconds: 3),
                                    ));
                                  }
                                },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue.shade400)),
                          child: Text(provider.isLoading
                              ? provider.message
                              : "Confirm"),)
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

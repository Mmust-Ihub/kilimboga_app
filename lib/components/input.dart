import 'package:flutter/material.dart';

class InputComponent extends StatefulWidget {
  final bool? isObscured;
  final String hintText;
  final Widget? prefixIcon;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool readOnly;
  const InputComponent(
      {super.key,
      this.isObscured,
      required this.hintText,
      required this.controller,
      this.prefixIcon,
      this.keyboardType,
      this.isPassword,
      required this.readOnly});

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  late bool isObscured;
  late bool isPassword;

  @override
  void initState() {
    super.initState();
    isObscured = widget.isPassword ?? false;
    isPassword = widget.isPassword ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: isObscured,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          contentPadding: const EdgeInsets.all(15),
          labelText: widget.hintText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            fontSize: 16,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
          ),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  child: isObscured
                      ? Icon(Icons.visibility, color:Theme.of(context).colorScheme.secondary.withOpacity(0.3))
                      : Icon(Icons.visibility_off, color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
                )
              : null),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kilimboga/responsive/mobile_scaffold.dart';


class Patient extends StatefulWidget {
  const Patient({super.key});

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  @override
  Widget build(BuildContext context) {
    return const MobileScaffold();
  }
}

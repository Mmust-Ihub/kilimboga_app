import 'package:kilimboga/config/size_config.dart';
import 'package:kilimboga/models/models.dart';
import 'package:kilimboga/provider/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateAppointment extends StatefulWidget {
  final List<Nurse> nurses;
  const CreateAppointment({super.key, required this.nurses});

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  final List<String> timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
  ];

  late DateTime selectedDate;
  late String selectedNurse;
  String? selectedTime;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedNurse = widget.nurses[0].id;
    _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      width: SizeConfig.blockSizeVertical! * 0.8,
      height: SizeConfig.blockSizeHorizontal! * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Consumer<AppointmentProvider>(
        builder: (BuildContext context, AppointmentProvider provider,
            Widget? child) {
          return Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.nurses.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedNurse == widget.nurses[index].id;
                    final Nurse nurse = widget.nurses[index];

                    return GestureDetector(
                      onTap: provider.isLoading
                          ? null
                          : () => setState(() => selectedNurse = nurse.id),
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal! * 80,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blueAccent
                              : (isDark
                                  ? const Color(0xFF374151)
                                  : Colors.white),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nurse.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? const Color(0xFFF3F4F6)
                                        : const Color(0xFF1F2937)),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              nurse.email,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? const Color(0xFFF3F4F6)
                                        : const Color(0xFF1F2937)),
                              ),
                            ),
                            nurse.speciality.isNotEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: nurse.speciality
                                        .map(
                                          (it) => Text(
                                            it,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : (isDark
                                                      ? const Color(0xFFF3F4F6)
                                                      : const Color(
                                                          0xFF1F2937)),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  )
                                : const Text("No speciality"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    final date = DateTime.now().add(Duration(days: index));
                    final isSelected = DateUtils.isSameDay(date, selectedDate);

                    return GestureDetector(
                      onTap: provider.isLoading
                          ? null
                          : () => setState(() => selectedDate = date),
                      child: Container(
                        width: 70,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blueAccent
                              : (isDark
                                  ? const Color(0xFF374151)
                                  : Colors.white),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEE').format(date),
                              style: TextStyle(
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? const Color(0xFFF3F4F6)
                                        : const Color(0xFF1F2937)),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('d').format(date),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? const Color(0xFFF3F4F6)
                                        : const Color(0xFF1F2937)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: timeSlots.map((time) {
                    final isSelected = time == selectedTime;
                    return GestureDetector(
                      onTap: provider.isLoading
                          ? null
                          : () => setState(() => selectedTime = time),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blueAccent
                              : (isDark
                                  ? const Color(0xFF374151)
                                  : Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                    ? const Color(0xFFF3F4F6)
                                    : const Color(0xFF1F2937)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: TextField(
                    readOnly: provider.isLoading ? true : false,
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Appointment reason...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: null),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                            if (_controller.text.trim().isNotEmpty) {
                              final int statusCode =
                                  await provider.createAppointment(
                                      selectedNurse,
                                      _controller.text,
                                      selectedDate,
                                      selectedTime!);

                              if (statusCode == 201) {
                                Navigator.of(context).pop();
                              }
                            }
                          },
                    child: Text(
                      provider.isLoading
                          ? 'Creating...'
                          : 'Confirm Appointment',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

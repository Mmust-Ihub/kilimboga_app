import 'package:kilimboga/data/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF374151) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.0),

      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    DateFormat('d').format(DateTime.parse(appointment.date)),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? const Color(0xFFF3F4F6)
                          : const Color(0xFF1F2937),
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(DateTime.parse(appointment.date)),
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.nurse,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xFFF3F4F6)
                          : const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment.reason,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                  Text(
                    appointment.status,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              )),
              Text(
                appointment.time,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? const Color(0xFFF3F4F6)
                      : const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Color(0xFFE5E7EB)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.close, color: Colors.white, size: 20),
                label: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.calendar_today,
                    color: Colors.white, size: 20),
                label: const Text(
                  'Reschedule',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}

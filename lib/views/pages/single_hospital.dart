import 'package:kilimboga/components/create_appointment.dart';
import 'package:kilimboga/data/models.dart';
import 'package:kilimboga/provider/hospital_provider.dart';
import 'package:flutter/material.dart';
import 'package:kilimboga/views/pages/single_chat_page.dart';
import 'package:provider/provider.dart';

class SingleHospital extends StatefulWidget {
  final Hospital hospital;
  const SingleHospital({super.key, required this.hospital});

  @override
  State<SingleHospital> createState() => _SingleHospitalState();
}

class _SingleHospitalState extends State<SingleHospital> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HospitalProvider>(context, listen: false)
          .fetchSingleHospital(widget.hospital.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HospitalProvider>(
            builder: (BuildContext context, HospitalProvider provider,
                Widget? child) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.hospital.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? const Color(0xFFF3F4F6)
                                  : const Color(0xFF1F2937),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Level: ${widget.hospital.level}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDark
                                        ? const Color(0xFF9CA3AF)
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                                Text(
                                  '${widget.hospital.distance.toStringAsFixed(2)} km',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDark
                                        ? const Color(0xFF9CA3AF)
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (provider.nurses.isNotEmpty)
                          TextButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: provider.isLoading
                                ? null
                                : () {
                                    openDialog(
                                      context: context,
                                      widget: CreateAppointment(
                                        nurses: provider.nurses,
                                      ),
                                    );
                                  },
                            child: Text(
                              provider.isLoading
                                  ? "Fetching"
                                  : "Create Appointment",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: provider.isLoading
                          ? Container(
                              width: double.infinity,
                              color: Colors.grey.shade100,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            )
                          : provider.nurses.isEmpty
                              ? Container(
                                  width: double.infinity,
                                  color: Colors.grey.shade100,
                                  child: Center(
                                    child: Text(
                                      "No Nurses Available",
                                      style: TextStyle(
                                          color: Colors.grey.shade500),
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Wrap(
                                    children: [
                                      ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            Nurse nurse =
                                                provider.nurses[index];
                                            return Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Colors.grey.shade100,
                                              ),
                                              child: ListTile(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SIngleChatPage(
                                                        name: nurse.name,
                                                        id: nurse.id,
                                                        chatroomid: nurse.id,
                                                        tokens: nurse.fcm,
                                                        phone: nurse.phone,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                title: Text(nurse.name),
                                                subtitle: Text(
                                                    nurse.phone ?? nurse.email),
                                                trailing: const Icon(
                                                  Icons
                                                      .chat_bubble_outline_outlined,
                                                  color: Color(0xFF2563EB),
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const Divider(),
                                          itemCount: provider.nurses.length)
                                    ],
                                  ),
                                ),
                    )
                  ]);
            },
          ),
        ),
      ),
    );
  }
}

Future openDialog({
  required BuildContext context,
  required Widget widget,
}) {
  return showDialog(
    context: context,
    builder: (context) => widget,
  );
}

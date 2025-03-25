import 'package:flutter/material.dart';
import 'package:kilimboga/components/smart_device_component.dart';
import 'package:kilimboga/data/models.dart';
import 'package:kilimboga/widgets/live_data_streaming.dart';

class SingleGreenHousePage extends StatefulWidget {
  const SingleGreenHousePage({super.key});

  @override
  State<SingleGreenHousePage> createState() => _SingleGreenHousePageState();
}

class _SingleGreenHousePageState extends State<SingleGreenHousePage> {
  final List<Map<String, dynamic>> _sections = [
    {"title": "Plants", "content": "List of your plants and care tips"},
    {"title": "Schedules", "content": "Your daily gardening schedule"},
  ];

  List<SmartDevice> devices = [
    SmartDevice(name: "Fan", icon: "assets/svg/fan.svg", powerStatus: true),
    SmartDevice(name: "Light", icon: "assets/svg/bulb.svg", powerStatus: false),
    SmartDevice(name: "Tap", icon: "assets/svg/tap.svg", powerStatus: true),
    SmartDevice(name: "Fan", icon: "assets/svg/fan.svg", powerStatus: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Green House Name")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LiveDataStreaming(),
              const SizedBox(height: 15),
              GridView.builder(
                padding: const EdgeInsets.all(15.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) =>
                    SmartDeviceComponent(device: devices[index]),
                itemCount: devices.length,
              ),
              ExpansionPanelList.radio(
                expandedHeaderPadding: const EdgeInsets.all(0),
                elevation: 1,
                children: _sections.asMap().entries.map((entry) {
                  int index = entry.key;
                  var section = entry.value;

                  return ExpansionPanelRadio(
                    value: index,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(section["title"],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(section["content"]),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

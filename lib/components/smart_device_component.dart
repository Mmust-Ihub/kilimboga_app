import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kilimboga/data/models.dart';
import 'package:flutter/material.dart';

class SmartDeviceComponent extends StatefulWidget {
  final SmartDevice device;
  const SmartDeviceComponent({super.key, required this.device});

  @override
  State<SmartDeviceComponent> createState() => _SmartDeviceComponentState();
}

class _SmartDeviceComponentState extends State<SmartDeviceComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SvgPicture.asset(
            widget.device.icon,
            width: 60,
            height: 60,
            colorFilter: ColorFilter.mode(
                widget.device.powerStatus
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
                    : Colors.grey.shade800,
                BlendMode.srcIn),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(widget.device.name),
            Transform.rotate(
              angle: pi / 2,
              child: CupertinoSwitch(
                value: widget.device.powerStatus,
                onChanged: (_) {
                  setState(() {
                    widget.device.powerStatus = !widget.device.powerStatus;
                  });
                },
                activeColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.8),
              ),
            ),
          ])
        ]),
      ),
    );
  }
}

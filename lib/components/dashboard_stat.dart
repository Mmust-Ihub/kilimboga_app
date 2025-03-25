import 'package:flutter/material.dart';
import 'package:kilimboga/config/size_config.dart';

class DashboardStat extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final String value;
  const DashboardStat(
      {super.key,
      required this.name,
      required this.icon,
      required this.color,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      width: SizeConfig.blockSizeHorizontal! * 40,
      height: SizeConfig.blockSizeHorizontal! * 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Theme.of(context).cardColor,
      ),
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, color: color, size: 32),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700),
            ),
          ),
        )
      ]),
    );
  }
}

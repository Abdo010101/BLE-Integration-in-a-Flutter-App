import 'package:ble/core/theming/style.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          'connecting',
          style: TextStyles.font13DarkBlueMedium,
        ))
      ],
    );
  }
}

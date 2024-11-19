import 'package:ble/core/theming/style.dart';
import 'package:flutter/material.dart';

class ConnectingWidget extends StatelessWidget {
  const ConnectingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Status ....  Connecting.......',
            style: TextStyles.font13DarkBlueMedium,
          ),
        )
      ],
    );
  }
}

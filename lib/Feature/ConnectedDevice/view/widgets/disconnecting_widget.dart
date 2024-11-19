
import 'package:ble/core/theming/style.dart';
import 'package:flutter/material.dart';

class DisconnectingWidget extends StatelessWidget {
  const DisconnectingWidget({
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
          'Opps ..  Disconnect',
          style: TextStyles.font13DarkBlueMedium,
        ))
      ],
    );
  }
}


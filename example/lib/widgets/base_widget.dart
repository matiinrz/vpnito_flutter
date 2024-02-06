import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/data/interface_controller/api_interface_controller.dart';
import 'custom_retry_widget.dart';


class BaseWidget extends StatelessWidget {
  ///A widget with only custom retry button widget.
  final Widget child;

  const BaseWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiInterfaceController>(
      builder: (c) => Stack(
        children: [
          Positioned.fill(
            child: child,
          ),
          Visibility(
            visible: c.retry != null && c.error != null,
            child: Positioned.fill(
              child: Scaffold(
                body: CustomRetryWidget(
                  onPressed: c.onRetryTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

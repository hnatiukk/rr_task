import 'package:flutter/material.dart';
import '../../../core/utils/ui_constants.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UIConstants.progressIndicatorSize,
      height: UIConstants.progressIndicatorSize,
      child: CircularProgressIndicator(
        strokeWidth: UIConstants.progressIndicatorStrokeWidth,
      ),
    );
  }
}

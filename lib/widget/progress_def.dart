import 'package:flutter/material.dart';

class ProgressDef extends StatelessWidget {
  const ProgressDef({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

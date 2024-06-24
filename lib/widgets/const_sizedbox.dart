import 'package:flutter/material.dart';

class SmallSizedBoxHeight extends StatelessWidget {
  const SmallSizedBoxHeight({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 8,
    );
  }
}

class MidSizedBoxHeight extends StatelessWidget {
  const MidSizedBoxHeight({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
    );
  }
}

class LargeSizedBoxHeight extends StatelessWidget {
  const LargeSizedBoxHeight({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 24,
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ResipalLogo extends StatelessWidget {
  const ResipalLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/resipal_logo.svg',
      package: 'resipal_core',
      semanticsLabel: 'Resipal logo',
    );
  }
}

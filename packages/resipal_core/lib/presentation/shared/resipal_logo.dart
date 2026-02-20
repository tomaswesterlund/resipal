import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ResipalLogo extends StatelessWidget {
  final String assetPath;
  const ResipalLogo({this.assetPath = 'assets/resipal_logo_green.svg', super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetPath, package: 'resipal_core', semanticsLabel: 'Resipal logo');
  }
}

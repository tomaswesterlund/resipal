import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum LogoColor { blue, green }

enum LogoType { png, svg }

class ResipalLogo extends StatelessWidget {
  final LogoColor color;
  final LogoType type;
  final double? width;
  final double? height;

  const ResipalLogo({
    super.key,
    this.color = LogoColor.green,
    this.type = LogoType.svg,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final String colorStr = color.name;
    final String extension = type.name;
    final String assetPath = 'packages/resipal_core/assets/resipal_logo_$colorStr.$extension';

    if (type == LogoType.svg) {
      return SvgPicture.asset(assetPath, width: width, height: height, semanticsLabel: 'Resipal Logo');
    } else {
      return Image.asset(assetPath, width: width, height: height);
    }
  }
}

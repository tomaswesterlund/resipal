import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:wester_kit/lib.dart';

class QrScannerView extends StatefulWidget {
  final Function(String) onQrCodeDetected;
  const QrScannerView({required this.onQrCodeDetected, super.key});

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppBar(
        title: 'Escanear Pase',
        backgroundColor: Colors.transparent,
        actions: [
          // Control de Linterna (Flash)
          // ValueListenableBuilder(
          //   valueListenable: controller.value.torchState.rawValue,
          //   builder: (context, state, child) {
          //     return IconButton(
          //       icon: Icon(
          //         state == TorchState.on ? Icons.flashlight_on : Icons.flashlight_off,
          //         color: Colors.white,
          //       ),
          //       onPressed: () => controller.toggleTorch(),
          //     );
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && isScanning) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  _onCodeDetected(code);
                }
              }
            },
          ),

          // Máscara visual para centrar el QR
          CustomPaint(painter: ScannerOverlayPainter(), child: Container()),

          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: BodyText.medium('Centra el código QR para validar', color: Colors.white),
              ),
            ),
          ),
          Row(
            children: [
              PrimaryButton(
                label: 'Not valid',
                onPressed: () {
                  widget.onQrCodeDetected('not valid');
                },
              ),
              PrimaryButton(
                label: 'Future',
                onPressed: () {
                  widget.onQrCodeDetected('3310761b-7252-4ea8-88b3-ca22ddf51400');
                },
              ),
              PrimaryButton(
                label: 'Valid',
                onPressed: () {
                  widget.onQrCodeDetected('71993c8a-c44a-44af-9a99-476e87d9f09d');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onCodeDetected(String qrCodeToken) {
    setState(() => isScanning = false);
    Feedback.forTap(context);
    widget.onQrCodeDetected(qrCodeToken);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.6);
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final scanW = size.width * 0.7;
    final scanBox = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: scanW, height: scanW);

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(rect),
        Path()..addRRect(RRect.fromRectAndRadius(scanBox, const Radius.circular(20))),
      ),
      paint,
    );

    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path();
    double cornerSize = 30;

    path.moveTo(scanBox.left, scanBox.top + cornerSize);
    path.lineTo(scanBox.left, scanBox.top);
    path.lineTo(scanBox.left + cornerSize, scanBox.top);

    path.moveTo(scanBox.right - cornerSize, scanBox.top);
    path.lineTo(scanBox.right, scanBox.top);
    path.lineTo(scanBox.right, scanBox.top + cornerSize);

    path.moveTo(scanBox.right, scanBox.bottom - cornerSize);
    path.lineTo(scanBox.right, scanBox.bottom);
    path.lineTo(scanBox.right - cornerSize, scanBox.bottom);

    path.moveTo(scanBox.left + cornerSize, scanBox.bottom);
    path.lineTo(scanBox.left, scanBox.bottom);
    path.lineTo(scanBox.left, scanBox.bottom - cornerSize);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

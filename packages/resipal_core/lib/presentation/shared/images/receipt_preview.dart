import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/services/image_service.dart';

class ReceiptPreview extends StatelessWidget {
  final String receiptPath;
  final double height;

  const ReceiptPreview({
    required this.receiptPath,
    this.height = 300,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: FutureBuilder<String>(
        future: GetIt.I<ImageService>().getSignedUrl(receiptPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: height,
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return _buildErrorState();
          }

          return Image.network(
            snapshot.data!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: height,
            // Secondary error check for network issues
            errorBuilder: (context, error, stackTrace) => _buildErrorState(),
          );
        },
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: 120,
      color: Colors.grey[200],
      width: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, color: Colors.grey, size: 40),
          SizedBox(height: 8),
          Text(
            'No se pudo cargar el comprobante',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.05), width: 1),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sidebar indicator shimmer
              Container(width: 6, color: Colors.white),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Shimmer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [_shimmerBox(width: 20, height: 20, radius: 4), const SizedBox(width: 8), _shimmerBox(width: 120, height: 16)]),
                          _shimmerBox(width: 20, height: 20, radius: 10),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _shimmerBox(width: 200, height: 12),

                      const Divider(height: 24, thickness: 1, color: Colors.white),

                      // Footer Shimmer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [_shimmerBox(width: 80, height: 12), const SizedBox(height: 8), _shimmerBox(width: 60, height: 16, radius: 6)],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [_shimmerBox(width: 70, height: 11), const SizedBox(height: 4), _shimmerBox(width: 90, height: 22)],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height, double radius = 4}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius)),
    );
  }
}

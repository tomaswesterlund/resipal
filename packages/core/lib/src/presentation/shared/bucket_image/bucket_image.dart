import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/src/presentation/shared/bucket_image/bucket_image_cubit.dart';
import 'package:core/src/presentation/shared/bucket_image/bucket_image_state.dart';
import 'package:ui/lib.dart';

class BucketImage extends StatelessWidget {
  final String bucket;
  final String path;
  final double height;

  const BucketImage({required this.bucket, required this.path, this.height = 300, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // We use '..' to trigger the load immediately upon creation
      create: (_) => BucketImageCubit()..loadUrl(bucket: bucket, path: path),
      child: BlocBuilder<BucketImageCubit, BucketImageState>(
        builder: (context, state) {
          if (state is BucketImageLoaded) {
            return CachedNetworkImage(
              imageUrl: state.url,
              height: height,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              cacheKey: path,
            );
          }

          if (state is BucketImageError) {
            return ImageErrorState(height: 120, text: 'Error al cargar imagen');
          }

          // Default Loading State
          return SizedBox(
            height: height,
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
      ),
    );
  }
}

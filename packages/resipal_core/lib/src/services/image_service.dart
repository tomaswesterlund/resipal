import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal_core/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageService {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<String> uploadImage({required String bucket, required String folder, required XFile xFile}) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final path = '$folder/$fileName';

    final bytes = await xFile.readAsBytes();

    await _client.storage
        .from(bucket)
        .uploadBinary(path, bytes, fileOptions: const FileOptions(contentType: 'image/png', upsert: false));

    return path;
  }

  Future<ImagePath> uploadPaymentReceipt({
    required XFile xFile,
    required String communityId,
    required String residentId,
  }) async {
    final folder = 'receipts/$communityId/$residentId';
    return uploadImage(bucket: 'payments', folder: folder, xFile: xFile);
  }

  Future<String> uploadVisitorIdentification(XFile xFile) =>
      uploadImage(bucket: 'visitors', folder: 'identifications', xFile: xFile);

  Future<String> getSignedUrl({required String bucket, required String path}) async {
    try {
      final String signedUrl = await _client.storage
        .from(bucket)
        .createSignedUrl(path, 60); 
        
    return signedUrl;
    
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'ImageService.getSignedUrl', stackTrace: s, metadata: { 'path' : path});
      rethrow;
    }
  }
}

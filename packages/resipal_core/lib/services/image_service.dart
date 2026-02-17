import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageService {
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

  Future<String> uploadPaymentReceipt(XFile xFile) => uploadImage(bucket: 'payments', folder: 'receipts', xFile: xFile);

  Future<String> uploadVisitorIdentification(XFile xFile) =>
      uploadImage(bucket: 'visitors', folder: 'identifications', xFile: xFile);

  Future<String> getSignedUrl(String path) async {
    try {
      final url = _client.storage.from('payments').getPublicUrl(path);
      return url;
    } catch (e) {
      // Log error or rethrow so the UI can show the error state
      rethrow;
    }
  }
}

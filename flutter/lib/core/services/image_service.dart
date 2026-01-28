import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageService {
  final SupabaseClient _client = GetIt.I<SupabaseClient>();

  Future<String> uploadReceipt(XFile xFile, String userId) async {
    final supabase = Supabase.instance.client;

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final path = 'receipts/$fileName';

    // 2. Read bytes from XFile (Works on all platforms)
    final bytes = await xFile.readAsBytes();

    // 3. Upload to the bucket (Ensure your bucket name is correct, e.g., 'movements')
    await supabase.storage
        .from('payments')
        .uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(
            contentType: 'image/png',
            upsert: false,
          ),
        );

    return path;
  }

  Future<String> getSignedUrl(String path) async {
    try {
      final url = _client.storage
          .from('payments')
          .getPublicUrl(path);
      return url;
    } catch (e) {
      // Log error or rethrow so the UI can show the error state
      rethrow;
    }
  }
}

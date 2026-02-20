
import 'package:supabase_flutter/supabase_flutter.dart';

class ResipalSupabase {
  Future<void> init() async {
    await Supabase.initialize(
      url: 'https://xapfoiggbgutbmcqrgma.supabase.co',
      anonKey: 'sb_publishable_I1FzA8ioJ1zPOhpFjld_vA_p2Pip5pw',
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}

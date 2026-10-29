import 'package:flutter/material.dart';

import 'app.dart';
import 'services/supabase/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase (gracefully falls back if unconfigured)
  await SupabaseService.instance.initialize();

  runApp(const BrightFutureSchoolApp());
}

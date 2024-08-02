import 'dart:async';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class FakePathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '/fakepath';
  }

  @override
  Future<String?> getTemporaryPath() async {
    return '/fakepath/temp';
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return '/fakepath/support';
  }

  @override
  Future<String?> getLibraryPath() async {
    return '/fakepath/library';
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return '/fakepath/external';
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return ['/fakepath/external/cache'];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({StorageDirectory? type}) async {
    return ['/fakepath/external/storage'];
  }
}

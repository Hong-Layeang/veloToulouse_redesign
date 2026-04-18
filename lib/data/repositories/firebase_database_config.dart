class FirebaseDatabaseConfig {
  static const String databaseHost =
      'velotoullouse-default-rtdb.asia-southeast1.firebasedatabase.app';

  static Uri nodeUri(String path) {
    return Uri.https(databaseHost, '/$path.json');
  }
}

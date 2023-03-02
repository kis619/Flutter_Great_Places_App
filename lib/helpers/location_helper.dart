import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationHelper {
  static Future<String> generateLocationPreviewImage(
      {required double latitude, required double longitude}) async {
    await dotenv.load();
    String? apiKey = dotenv.env['API_KEY'];
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:K%7C$latitude,$longitude&key=$apiKey';
  }
}

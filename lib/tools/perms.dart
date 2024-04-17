import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermission() async {
  const video = Permission.videos;
  if (await video.isDenied) {
    await video.request();
    //openAppSettings();
  }
  const audio = Permission.audio;
  if (await audio.isDenied) {
    await audio.request();
    //openAppSettings();
  }

  const storage = Permission.storage;
  if (await storage.isDenied) {
    await storage.request();
    //openAppSettings();
  }
}

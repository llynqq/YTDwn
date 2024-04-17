import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'perms.dart';

final yt = YoutubeExplode();

Future<Video> downloadVideo(String url, String filePath, bool isAudioChecked,
    bool isVideoChecked) async {
  requestPermission();
  //print(url);
  final video = await yt.videos.get(url);
  final videoId = video.id;
  var manifest = await yt.videos.streamsClient.getManifest(videoId);
  //print(manifest);

  //var thumbnailUrl = video.thumbnails.highResUrl;

  var streamInfo = manifest.audioOnly.first;
  var videoStream = manifest.video.first;

  var audioStream = yt.videos.streamsClient.get(streamInfo);

  var videoFile = yt.videos.streamsClient.get(videoStream);

  //Download logic
  var videoStreamController = StreamController<List<int>>();
  videoFile.listen((List<int> chunk) {
    videoStreamController.add(chunk);
  }, onDone: () {
    videoStreamController.close();
  });

  var fileName = video.title
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '')
      .replaceAll(' ', '_');

  final BytesBuilder builder = BytesBuilder();
  await for (List<int> chunk in videoStreamController.stream) {
    builder.add(chunk);
  }
  final String savePath;
  if (isAudioChecked && !isVideoChecked) {
    savePath = '$filePath/$fileName.mp3';
  } else if (isVideoChecked && !isAudioChecked) {
    savePath = '$filePath/$fileName.mp4';
  } else {
    savePath = '$filePath/$fileName.mp4';
  }

  final Uint8List videoBytes = builder.toBytes();
  final File file = File(savePath);

  await file.writeAsBytes(videoBytes);

  return video;
}

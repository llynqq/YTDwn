import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';

import '../tools/ytdownload.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textController = TextEditingController();
  String _dlPath = "";
  bool isAudioChecked = false;
  bool isVideoChecked = false;
  String _videoId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YTDwn',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87, // Set background color here
      ),

      backgroundColor: Colors.black87, // Set background color here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.white), // Set text color to white
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
                hintText: 'Enter a YT URL',
                hintStyle: TextStyle(
                    color: Colors.grey), // Set hint text color to white
              ),
              onChanged: (value) {
                _videoId = ""; // Reset _videoId initially

                // Extract ID using multiple conditions:
                if (value.contains("watch?v=")) {
                  final parts = value.split("watch?v=");
                  if (parts.length > 1) {
                    _videoId = parts[1];
                  }
                } else if (value.contains("youtu.be/")) {
                  final parts = (value.split("youtu.be/")).last;
                  _videoId = (parts.split('?')).first;
                  print(_videoId);
                }

                // Inform user if no ID found (optional)
                if (_videoId.isEmpty) {
                  // Show error message or display a message indicating no video ID found
                }

                setState(() {}); // Update the UI
              },
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Center the contents horizontally
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: TextField(
                      controller: TextEditingController(text: _dlPath),
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Download Path",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w200),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.folder_open),
                    onPressed: () {
                      FilePicker.platform.getDirectoryPath().then((value) {
                        if (value != null) {
                          setState(() {
                            _dlPath = value;
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CheckboxListTile(
                    value: isAudioChecked,
                    onChanged: (value) =>
                        setState(() => isAudioChecked = value!),
                    title: Text(
                      "Audio",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                    width: 10), // Add horizontal spacing between checkboxes
                Expanded(
                  child: CheckboxListTile(
                    value: isVideoChecked,
                    onChanged: (value) =>
                        setState(() => isVideoChecked = value!),
                    title: Text(
                      "Video",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            // Display the thumbnail
            _videoId.isNotEmpty
                ? Image.network(
                    'https://img.youtube.com/vi/$_videoId/0.jpg',
                    height: 200.0,
                    width: 300.0,
                    fit: BoxFit.cover,
                  )
                : SizedBox(),
            SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: () async {
                final result = await showSimpleLoadingDialog<String>(
                  context: context,
                  future: () async {
                    try {
                      await downloadVideo(_textController.text, _dlPath,
                          isAudioChecked, isVideoChecked);
                      return 'File Downloaded!';
                    } catch (e) {
                      return 'Error Downloading File: $e';
                    }
                  },
                );

                if (context.mounted) {
                  context.showMessageSnackBar('Success result: $result');
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurple),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
}

extension BuildContextX on BuildContext {
  void showMessageSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 4000),
      ),
    );
  }
}

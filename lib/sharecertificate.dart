import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vaccinemgmt/share_button_widget.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShareCertificate extends StatelessWidget {
  static final String title = 'YOUR CERTIFICATE';
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                CachedNetworkImage(
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  imageUrl:
                      "https://immunoapi.radiantdaman.com/generateCerti?name=Janhavi Zarapkar&task=Covid Warrior ",
                ),
                CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl:
                      "https://immunoapi.radiantdaman.com/generateCerti?name=Janhavi Zarapkar&task=Quiz Master",
                ),
              ]),
            ),
            SizedBox(height: 32),
            ShareButtonWidget(onClicked: () async {
              var request = await HttpClient().getUrl(Uri.parse(
                  'https://immunoapi.radiantdaman.com/generateCerti?name=Janhavi Zarapkar&task=Covid Warrior'));
              var response = await request.close();
              Uint8List bytes =
                  await consolidateHttpClientResponseBytes(response);
              await Share.file('Certificate of Appreciation', 'Certificate.jpg',
                  bytes, 'image/jpg');
            }),
          ],
        ),
      ),
    );

    Future<List<String>> pickFile() async {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);

      return result == null ? <String>[] : result.paths;
    }
  }
}

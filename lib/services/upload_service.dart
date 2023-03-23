import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:messeenger_flutter/configs/http_config.dart';
import 'package:messeenger_flutter/utils/token_util.dart';

class UploadResponse {
  String fileUrl;

  UploadResponse({required this.fileUrl});

  factory UploadResponse.fromJson(json) {
    return UploadResponse(
      fileUrl: json['fileUrl'],
    );
  }
}

class UploadService {
  static Future<UploadResponse> upload(String filepath) async {
    final token = await TokenUtil.getToken();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload'),
    );
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      filepath,
    ));
    request.fields['path'] = 'chats';
    request.headers['authorization'] = 'Bearer $token';

    final res = await request.send();

    final jsonBody = jsonDecode(await res.stream.bytesToString());

    if (res.statusCode == 200) {
      return UploadResponse.fromJson(jsonBody);
    }

    throw jsonBody['message'];
  }
}

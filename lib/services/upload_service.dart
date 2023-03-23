import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
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
  static Future<UploadResponse> upload(dynamic file) async {
    final token = await TokenUtil.getToken();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload'),
    );
    if (kIsWeb) {
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        file.bytes,
      ));
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
      ));
    }

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

import 'package:messeenger_flutter/configs/http_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket = IO.io(
  socketUrl,
  IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
);

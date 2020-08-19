import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:duedex_order/models/base_model.dart';
import 'package:duedex_order/models/order.dart';
import 'package:equatable/equatable.dart';

import 'package:web_socket_channel/io.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final _api_key = "13f1ab93-771d-4d59-bb6a-fe96f6b609ea";
  final _secret = "2W2eSP3e0dp+lYMuY1MBUTqF2+8VbNRxDZ88zA7MliU=";

  IOWebSocketChannel _channel =
      IOWebSocketChannel.connect("wss://feed.duedex.com/v1/feed");

  @override
  OrderState get initialState => OrderInitial();

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is ConnectWebSocket) {
      try {
        _channel.stream.listen((message) {
          if (message != null) {
            final base = BaseModel.fromJson(jsonDecode(message));
            switch (base.type) {
              case "challenge":
                final answer =
                    _answer(Challenge.fromJson(jsonDecode(message)).challenge);
                break;
              case "snapshot":

                break;
              case "update":
                break;
            }
          }
        }, onError: (e) {
          print("======erro===${e}");
        });
        _subscribe();
      } catch (e) {
        print("=====erro===${e}");
      }
    }
  }

  void _subscribe() {
    _channel.sink.add(jsonEncode({
      "type": "subscribe",
      "channels": [
        {
          "name": "level2",
          "instruments": ["BTCUSD"]
        }
      ]
    }));
  }

  String _answer(String challenge) {
    final key = base64.decode(_secret);
    final bytes = utf8.encode(challenge);
    final digest = Hmac(sha256, key);
    return "${digest.convert(bytes)}";
  }
}

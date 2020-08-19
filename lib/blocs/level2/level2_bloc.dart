import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:duedex_order/models/base_model.dart';
import 'package:duedex_order/models/level2.dart';
import 'package:duedex_order/models/order.dart';
import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/io.dart';

part 'level2_event.dart';

part 'level2_state.dart';

class Level2Bloc extends Bloc<Level2Event, Level2State> {
  final _api_key = "13f1ab93-771d-4d59-bb6a-fe96f6b609ea";
  final _secret = "2W2eSP3e0dp+lYMuY1MBUTqF2+8VbNRxDZ88zA7MliU=";

  IOWebSocketChannel _channel =
      IOWebSocketChannel.connect("wss://feed.duedex.com/v1/feed");

  List<List<dynamic>> _bids = [];

  List<List<dynamic>> _asks = [];

  int _lastSequence = 0;

  @override
  // TODO: implement initialState
  Level2State get initialState => Level2Initial();

  @override
  Stream<Level2State> mapEventToState(
    Level2Event event,
  ) async* {
    if (event is Level2UpdateEvent) {
      yield Level2Update(event.bids, event.asks);
    }

    if (event is Subscribe) {
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
                final res = Level2.fromJson(base.data);
                _asks = res.asks;
                _bids = res.bids;
                _lastSequence = base.sequence;

                add(Level2UpdateEvent(_bids.toList().sublist(0, 5),
                    _asks.toList().sublist(0, 5).reversed.toList()));

                break;
              case "update":
                if (_lastSequence + 1 < base.sequence) {
                  _subscribe();
                  return;
                }
                _lastSequence = base.sequence;

                final res = Level2.fromJson(base.data);

                final List<List<dynamic>> asks_temp = res.asks;

                final List<List<dynamic>> bids_temp = res.bids;

                _asks.forEach((val) {
                  final v = res.asks.map((val) {
                    return val.first;
                  }).toList();

                  if (!v.contains(val.first) && val.last != 0) {
                    asks_temp.add(val);
                  }
                });

                asks_temp.sort((a, b) {
                  return double.parse(a.first).compareTo(double.parse(b.first));
                });

                _bids.forEach((val) {
                  final v = res.bids.map((val) {
                    return val.first;
                  }).toList();

                  if (!v.contains(val.first) && val.last != 0) {
                    bids_temp.add(val);
                  }
                });

                bids_temp.sort((a, b) {
                  return double.parse(a.first).compareTo(double.parse(b.first));
                });

                bids_temp.removeWhere((val) => val.last == 0);
                asks_temp.removeWhere((val) => val.last == 0);

                _bids = bids_temp;
                _asks = asks_temp;

                add(Level2UpdateEvent(_bids.reversed.toList().sublist(0, 5),
                    asks_temp.toList().sublist(0, 5).reversed.toList()));
                break;
            }
          }
        }, onError: (e) {
          print("======erro===${e}");
        });
        _subscribe();
      } catch (e) {
        print("erro: ${e}");
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

  void _unsubscribe() {
    _channel.sink.add(jsonEncode({
      "type": "subscriptions",
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

  @override
  Future<void> close() {
    _unsubscribe();
    return super.close();
  }
}

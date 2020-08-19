
import 'package:duedex_order/models/base_model.dart';

class Level2 extends BaseModel {
  List<List<dynamic>> bids;
  List<List<dynamic>> asks;

  Level2({this.bids, this.asks});

  Level2.fromJson(Map<String, dynamic> json) {
    if (json['bids'] != null) {
      bids = new List<List<dynamic>>();
      json['bids'].forEach((v) {
        bids.add(new List.from(v));
      });
    }
    if (json['asks'] != null) {
      asks = new List<List<dynamic>>();
      json['asks'].forEach((v) {
        asks.add(new List.from(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bids != null) {
      data['bids'] = this.bids.map((v) => v.toList()).toList();
    }
    if (this.asks != null) {
      data['asks'] = this.asks.map((v) => v.toString()).toList();
    }
    return data;
  }
}

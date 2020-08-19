class Challenge {
  String type;
  String challenge;

  Challenge({this.type, this.challenge});

  Challenge.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    challenge = json['challenge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['challenge'] = this.challenge;
    return data;
  }
}

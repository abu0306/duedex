class BaseModel {
  String type;
  Map<String, dynamic> data;
  int sequence;

  BaseModel({this.type, this.data});

  BaseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    sequence = json['sequence'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['sequence'] = this.sequence;
    data['data'] = this.data;
    return data;
  }
}

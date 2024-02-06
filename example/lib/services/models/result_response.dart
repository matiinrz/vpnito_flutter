class PostResultResponse {
  bool? status;
  String? message;
  int? totalItems;
  int? dt;

  PostResultResponse({this.status, this.message, this.totalItems, this.dt});

  PostResultResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalItems = json['totalItems'];
    dt = json['dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalItems'] = this.totalItems;
    data['dt'] = this.dt;
    return data;
  }
}


class GetResultResponse {
  dynamic data;
  bool? status;
  String? message;
  int? totalItems;
  int? dt;

  GetResultResponse(
      {this.data, this.status, this.message, this.totalItems, this.dt});

  GetResultResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    status = json['status'];
    message = json['message'];
    totalItems = json['totalItems'];
    dt = json['dt'];
  }

  Map<String, dynamic> toJson() {
    data['data'] = this.data;
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalItems'] = this.totalItems;
    data['dt'] = this.dt;
    return data;
  }
}
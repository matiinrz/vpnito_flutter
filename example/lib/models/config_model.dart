class ConfigModel {
  int? id;
  String? name;
  String? country;
  String? flag;
  String? config;
  int? sortOrder;
  String? createdAt;
  String? updatedAt;
  int? ping;

  ConfigModel({
    this.id,
    this.name,
    this.country,
    this.flag,
    this.config,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.ping,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    flag = json['flag'];
    config = json['config'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ping = json['ping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country'] = country;
    data['flag'] = flag;
    data['config'] = config;
    data['sort_order'] = sortOrder;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['ping'] = ping;
    return data;
  }
}

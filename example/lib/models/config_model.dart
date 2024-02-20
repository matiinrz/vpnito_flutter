class ConfigModel {
  int? id;
  String? name;
  String? country;
  String? flag;
  String? config;
  int? sortOrder;
  String? createdAt;
  String? updatedAt;

  ConfigModel(
      {this.id,
        this.name,
        this.country,
        this.flag,
        this.config,
        this.sortOrder,
        this.createdAt,
        this.updatedAt});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    flag = json['flag'];
    config = json['config'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['flag'] = this.flag;
    data['config'] = this.config;
    data['sort_order'] = this.sortOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
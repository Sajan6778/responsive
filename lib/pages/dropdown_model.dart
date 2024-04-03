class DropdownModel {
  int? categoryId;
  String? categoryName;
  Null? categoryImage;
  String? url;

  DropdownModel(
      {this.categoryId, this.categoryName, this.categoryImage, this.url});

  DropdownModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['categoryImage'] = this.categoryImage;
    data['url'] = this.url;
    return data;
  }
}

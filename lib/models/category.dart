class Category {
  int? categoryId;
  String? categoryName;
  String? categoryDesc;
  int? parent;
  CategoryImage? image;

  Category({
    this.categoryId,
    this.categoryName,
    this.categoryDesc,
    this.parent,
    this.image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name'];
    categoryDesc = json['description'];
    parent = json['parent'];
    image =
        json['image'] != null ? CategoryImage.fromJson(json['image']) : null;
  }
}

class CategoryImage {
  String? url;

  CategoryImage({this.url});

  CategoryImage.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }
}

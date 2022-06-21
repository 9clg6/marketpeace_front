class Advertisement {
  int? id;
  String? title;
  double? price;
  String? description;
  String? imageUrl;
  int? ownerId;

  Advertisement({
    this.id,
    this.title,
    this.price,
    this.description,
    this.imageUrl,
    this.ownerId,
  });

  Advertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    ownerId = json['ownerId'];
  }
}

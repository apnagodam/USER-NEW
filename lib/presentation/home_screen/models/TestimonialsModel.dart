class TestimonialsModel {
  TestimonialsModel({
      List<Testimonials>? testimonials,}){
    _testimonials = testimonials;
}

  TestimonialsModel.fromJson(dynamic json) {
    if (json['testimonials'] != null) {
      _testimonials = [];
      json['testimonials'].forEach((v) {
        _testimonials?.add(Testimonials.fromJson(v));
      });
    }
  }
  List<Testimonials>? _testimonials;
TestimonialsModel copyWith({  List<Testimonials>? testimonials,
}) => TestimonialsModel(  testimonials: testimonials ?? _testimonials,
);
  List<Testimonials>? get testimonials => _testimonials;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_testimonials != null) {
      map['testimonials'] = _testimonials?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Testimonials {
  Testimonials({
      int? id, 
      String? name, 
      String? description, 
      String? location, 
      String? image,}){
    _id = id;
    _name = name;
    _description = description;
    _location = location;
    _image = image;
}

  Testimonials.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _location = json['location'];
    _image = json['image'];
  }
  int? _id;
  String? _name;
  String? _description;
  String? _location;
  String? _image;
Testimonials copyWith({  int? id,
  String? name,
  String? description,
  String? location,
  String? image,
}) => Testimonials(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  location: location ?? _location,
  image: image ?? _image,
);
  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get location => _location;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['location'] = _location;
    map['image'] = _image;
    return map;
  }

}
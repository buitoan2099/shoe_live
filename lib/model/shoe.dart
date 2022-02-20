import 'dart:convert';
import 'dart:ui';

class Shoe {
  int id ;
  String image ;
  String name ;
  String description;
  double price;
  String color;
  bool isChoice;

  Shoe({
    this.id= 0,
    this.image= "",
    this.name="",
    this.description="",
    this.price=0,
    this.color="",
    this.isChoice = false,
  });
  Shoe.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        image = json['image'] ?? '',
        name = json['name'] ?? '',
        description = json['description'] ?? '',
        price = json['price'] ?? 0,
        isChoice = json['isChoice'] ??false,
        color = json['color'] ?? '';

  Shoe.newValue(Shoe value)
      : id = value.id,
        image = value.image,
        name = value.name,
        description = value.description,
        price = value.price,
        isChoice = value.isChoice,
        color = value.color;
  static Map<String, dynamic> toJson(Shoe shoes) => {
    'id': shoes.id,
    'image': shoes.image,
    'name': shoes.name,
    'description': shoes.description,
    'price': shoes.price,
    'isChoice': shoes.isChoice,
    'color': shoes.color,
  };
  static String encode(List<Shoe> shoes) => jsonEncode(
    shoes
        .map<Map<String, dynamic>>((shoe) => Shoe.toJson(shoe))
        .toList(),
  );

  static List<Shoe> decode(String shoes) {
    if(shoes == ""){
      return [];
    }else{
      return  (json.decode(shoes) as List<dynamic>)
          .map<Shoe>((item) => Shoe.fromJson(item))
          .toList();
    }
  }


}

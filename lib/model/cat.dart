class Cat {
  String? name;
  String? color;
  int? age;

  Cat({
    required this.name,
    required this.color,
    required this.age,
  });

  Cat.fromJson(Map<String, dynamic> map) {
    name = map["name"];
    color = map["color"];
    age = map["age"];
  }
  Map<String,dynamic> toJson()=>{
    "name":name,
    "color":color,
    "age":age,
  };
}

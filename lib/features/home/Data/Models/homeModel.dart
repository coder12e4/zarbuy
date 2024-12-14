class Menu {
  List<Category> categories;
  Menu({required this.categories});
  factory Menu.fromJson(Map<String, dynamic> json) {
    var list = json['categories'] as List;
    List<Category> categoriesList =
        list.map((i) => Category.fromJson(i)).toList();

    return Menu(categories: categoriesList);
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}

class Category {
  int id;
  String name;
  List<Dish> dishes;

  Category({required this.id, required this.name, required this.dishes});

  factory Category.fromJson(Map<String, dynamic> json) {
    var list = json['dishes'] as List;
    List<Dish> dishesList = list.map((i) => Dish.fromJson(i)).toList();

    return Category(id: json['id'], name: json['name'], dishes: dishesList);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dishes': dishes.map((dish) => dish.toJson()).toList(),
    };
  }
}

class Dish {
  int id;
  String name;
  String price;
  String currency;
  int calories;
  String description;
  List<Addon> addons;
  String imageUrl;
  bool customizationsAvailable;

  Dish(
      {required this.id,
      required this.name,
      required this.price,
      required this.currency,
      required this.calories,
      required this.description,
      required this.addons,
      required this.imageUrl,
      required this.customizationsAvailable});

  factory Dish.fromJson(Map<String, dynamic> json) {
    var list = json['addons'] as List;
    List<Addon> addonsList = list.map((i) => Addon.fromJson(i)).toList();

    return Dish(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        currency: json['currency'],
        calories: json['calories'],
        description: json['description'],
        addons: addonsList,
        imageUrl: json['image_url'],
        customizationsAvailable: json['customizations_available']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'calories': calories,
      'description': description,
      'addons': addons.map((addon) => addon.toJson()).toList(),
      'image_url': imageUrl,
      'customizations_available': customizationsAvailable,
    };
  }
}

class Addon {
  int id;
  String name;
  String price;

  Addon({required this.id, required this.name, required this.price});

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}

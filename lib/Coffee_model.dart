class CoffeeModel {
  String name;
  double price;
  String image;
  double rating;
  String description;
  CoffeeModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.rating = 0.0,
  });
}

List<CoffeeModel> coffeelist = [
  CoffeeModel(
      name: 'Cappuccino',
      price: 4.75,
      image: 'assets/image/10.png',
      rating: 5,
      description:
          'A cappuccino, brewed with roasted coffee beans and almond milk.'),
  CoffeeModel(
      name: 'Americano ',
      price: 3.75,
      image: 'assets/image/40.png',
      rating: 4,
      description:
          'Americano is rich, made by combining bold espresso with hot water.'),
  CoffeeModel(
      name: 'Latte ',
      price: 4.5,
      image: 'assets/image/21.png',
      rating: 3,
      description:
          'Latte combines espresso, milk, and foam for creamy indulgence.'),
  CoffeeModel(
      name: 'Black Coffee',
      price: 3.50,
      image: 'assets/image/31.png',
      rating: 5,
      description: 'Black Coffee is a bold brew with robust flavor and aroma.'),
];

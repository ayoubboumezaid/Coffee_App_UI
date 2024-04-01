import 'dart:math';
import 'package:flutter/material.dart';
import 'package:coffeapp/QuantitySelector.dart';
import 'package:coffeapp/Sizeselector.dart';
import 'package:coffeapp/Coffee_model.dart';

class cofeeScreen extends StatefulWidget {
  const cofeeScreen({Key? key}) : super(key: key);

  @override
  State<cofeeScreen> createState() => _cofeeScreenState();
}

class _cofeeScreenState extends State<cofeeScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  List<CoffeeModel> _coffeelist = coffeelist;

  late Animation<double> _nameAnimation;
  late Animation<double> _priceAnimation;
  late Animation<double>
      _descriptionAnimation; 

  double get _currentOffset {
    bool inited = _pageController.hasClients &&
        _pageController.position.hasContentDimensions;
    return inited ? _pageController.page! : _pageController.initialPage * 1.0;
  }

  int get _currentIndex => _currentOffset.round() % _coffeelist.length;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _coffeelist.length * 9999,
    );
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _nameAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _priceAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _descriptionAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut)); // Initialize description animation

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          _updateAnimations();
          return _buildScreen();
        },
      ),
    );
  }

  void _updateAnimations() {
    _animationController.reset();
    _animationController.forward();
  }

  Stack _buildScreen() {
    final Size size = MediaQuery.of(context).size;
    final CoffeeModel _currentCoffee = _coffeelist[_currentIndex];
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -size.width * 0.6,
          child: BgImage(
            currentIndex: _currentIndex,
            food: _currentCoffee,
            pageOffset: _currentOffset,
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Image.asset(
                        "assets/image/menu.png",
                        width: 32,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          Color.fromRGBO(202, 146, 99, 1).withOpacity(0.9),
                      child: Image.asset("assets/image/profile.png"),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.42,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedBuilder(
                          animation: _nameAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                  size.width * _nameAnimation.value, 0.0),
                              child: Text(
                                _currentCoffee.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                        AnimatedBuilder(
                          animation: _priceAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                  size.width * _priceAnimation.value, 0.0),
                              child: Text(
                                "\$${_currentCoffee.price}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Exo',
                                  color: Color.fromRGBO(202, 146, 99, 1),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: index < _currentCoffee.rating
                                  ? Colors.amber
                                  : Colors.grey,
                            );
                          }),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Product info',
                          style: TextStyle(
                              color: Color.fromRGBO(202, 146, 99, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    AnimatedBuilder(
                      // Wrap description with AnimatedBuilder
                      animation: _descriptionAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                              -size.width * _descriptionAnimation.value,
                              0.0), // Change to negative offset
                          child: Text(
                            _currentCoffee.description,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 17,
                              height: 1.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    QuantitySelector(),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Size ',
                          style: TextStyle(
                              color: Color.fromRGBO(202, 146, 99, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Exo'),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    SizeSelector(),
                    SizedBox(height: size.height * 0.05),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(202, 146, 99, 1),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.25,
                          vertical: size.height * 0.015,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Add To Cart",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Center(
          child: SizedBox(
            height: size.width,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                double _value = 0.0;
                double vp = 1;
                double scale = max(vp, (_currentOffset - index).abs());

                if (_pageController.position.haveDimensions) {
                  _value = index.toDouble() - (_pageController.page ?? 0);
                  _value = (_value * 0.7).clamp(-1, 1);
                }
                return Transform.rotate(
                  angle: pi * _value,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 200 - scale * 5),
                    child: FittedBox(
                      child: Image.asset(
                        _coffeelist[index % _coffeelist.length].image,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BgImage extends StatefulWidget {
  const BgImage({
    Key? key,
    required this.currentIndex,
    required this.food,
    required this.pageOffset,
  }) : super(key: key);

  final int currentIndex;
  final CoffeeModel food;
  final double pageOffset;

  @override
  State<BgImage> createState() => _BgImageState();
}

class _BgImageState extends State<BgImage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double _value = 0.0;
    _value = (widget.pageOffset - widget.currentIndex).abs();
    return Opacity(
      opacity: 0.2,
      child: Transform.rotate(
        angle: pi * _value + pi / 180,
        child: SizedBox(
          width: size.width * 1.5,
          height: size.width * 1.5,
          child: Image.asset(
            widget.food.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

void main() {
  runApp(const MaterialApp(
    home: StackedPhotosExample(),
  ));
}

class StackedPhotosExample extends StatefulWidget {
  const StackedPhotosExample({super.key});

  @override
  _StackedPhotosExampleState createState() => _StackedPhotosExampleState();
}

class _StackedPhotosExampleState extends State<StackedPhotosExample>
    with TickerProviderStateMixin {
  List<String> photos = [
    'https://picsum.photos/id/1011/200/300',
    'https://picsum.photos/id/1012/200/300',
    'https://picsum.photos/id/1013/200/300',
    'https://picsum.photos/id/1014/200/300',
    'https://picsum.photos/id/1015/200/300',
  ];

  final Map<int, AnimationController> _animationControllers = {};
  final Map<int, Animation<double>> _scaleAnimations = {};
  final Map<int, Animation<Offset>> _slideAnimations = {};
  final Map<int, Animation<double>> _rotationAnimations = {};

  void movePhotoToEnd(int index) {
    setState(() {
      final photo = photos.removeAt(index);
      photos.add(photo);
      _animationControllers[index]?.reset();
    });
  }

  @override
  void dispose() {
    for (var controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  ValueNotifier<double> firstPhotoPosition = ValueNotifier(20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: photos.asMap().entries.toList().reversed.map((entry) {
                  int index = entry.key;
                  String photo = entry.value;

                  if (!_animationControllers.containsKey(index)) {
                    _animationControllers[index] = AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1000),
                    );

                    // Animação de escala (diminuindo para simular a gravidade)
                    _scaleAnimations[index] = Tween<double>(
                      begin: 1.0,
                      end: 0.9,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationControllers[index]!,
                        curve: Curves.easeInOut,
                      ),
                    );

                    // Animação de movimento (subir a foto para fora da tela)
                    _slideAnimations[index] = Tween<Offset>(
                      begin: const Offset(0, 0),
                      end: const Offset(0, 300), // Subir para fora da tela
                    ).animate(
                      CurvedAnimation(
                        parent: _animationControllers[index]!,
                        curve: Curves.easeInOut,
                      ),
                    );

                    // Animação de rotação
                    _rotationAnimations[index] = Tween<double>(
                      begin: 0.0,
                      end: 2 * 3.1416,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationControllers[index]!,
                        curve: Curves.easeInOut,
                      ),
                    );

                    //TODO:Falta logica para deixar a foto atras do ultimo item
                  }

                  if (index == 0) {
                    firstPhotoPosition.value =
                        20.0 * (photos.length - 1 - index);
                    return ValueListenableBuilder(
                      valueListenable: firstPhotoPosition,
                      builder: (_, value, __) {
                        return Positioned(
                          top: value,
                          child: Draggable(
                            axis: Axis.vertical,
                            feedback: buildCard(photo, context, .9, index),
                            childWhenDragging: const SizedBox.shrink(),
                            onDragEnd: (details) {
                              log(details.offset.dy.toString());
                              // Jogar para cima (com velocidade inicial negativa)
                              firstPhotoPosition.value = -300;

                              // Iniciar animação de deslizar para cima
                              _animationControllers[index]!
                                  .forward(from: 0)
                                  .then((_) {
                                // Após o deslizar, move a foto
                                movePhotoToEnd(index);
                              });
                            },
                            child: buildAnimatedCard(photo, context, .9, index),
                          ),
                        );
                      },
                    );
                  } else {
                    return Positioned(
                      top: 20.0 * (photos.length - 1 - index),
                      child: buildCard(photo, context, .87, index),
                    );
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para criar o card com animações de rotação, escala e translação
  Widget buildAnimatedCard(
    String photo,
    BuildContext context,
    double width,
    int index,
  ) {
    return AnimatedBuilder(
      animation: _animationControllers[index]!,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimations[index]!.value,
          child: Transform.scale(
            scale: _scaleAnimations[index]!.value,
            child: Transform.rotate(
              angle: _rotationAnimations[index]!.value,
              child: buildCard(photo, context, width, index),
            ),
          ),
        );
      },
    );
  }

  // Função para criar o card simples
  Widget buildCard(
    String photo,
    BuildContext context,
    double width,
    int index,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: MediaQuery.of(context).size.width * width,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          photo,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

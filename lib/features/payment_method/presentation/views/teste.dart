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

  // Um mapa para controlar a rotação de cada foto individualmente
  final Map<int, AnimationController> _animationControllers = {};

  // Função para mover a foto selecionada para o final da lista após animação
  void movePhotoToEnd(int index) {
    setState(() {
      final photo = photos.removeAt(index);
      photos.add(photo);
      _animationControllers[index]?.reset();
    });
  }

  @override
  void dispose() {
    // Libera os controllers quando o widget for destruído
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        title: const Text('Fotos Empilhadas'),
      ),
      body: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: photos.asMap().entries.toList().reversed.map((entry) {
            int index = entry.key;
            String photo = entry.value;

            if (!_animationControllers.containsKey(index)) {
              _animationControllers[index] = AnimationController(
                vsync: this,
                duration: const Duration(seconds: 1),
              );
            }

            // Se for o item arrastado, queremos deixá-lo na posição onde foi solto
            if (index == 0) {
              firstPhotoPosition.value = 20.0 * (photos.length - 1 - index);
              return ValueListenableBuilder(
                  valueListenable: firstPhotoPosition,
                  builder: (_, value, __) {
                    return Positioned(
                      top: value,
                      child: Draggable(
                        axis: Axis.vertical,
                        feedback: buildCard(photo, context, .9, index),
                        childWhenDragging: const SizedBox.shrink(),
                        onDragUpdate: (details) {
                          log(details.delta.dy.toString());
                        },
                        onDragEnd: (details) {
                          if (details.offset.dy > 0) {
                            firstPhotoPosition.value = details.offset.dy;

                            // _animationControllers[index]
                            //     ?.forward(from: 0.0)
                            //     .then((_) {
                            //   movePhotoToEnd(index);
                            // });
                          }
                        },
                        child: buildCard(photo, context, .9, index),
                      ),
                    );
                  });
            } else {
              return Positioned(
                top: 20.0 * (photos.length - 1 - index),
                child: GestureDetector(
                  onTap: () => movePhotoToEnd(index),
                  child: buildCard(photo, context, .87, index),
                ),
              );
            }
          }).toList(),
        ),
      ),
    );
  }

  // Função auxiliar para criar o card com rotação animada
  Widget buildCard(
      String photo, BuildContext context, double width, int index) {
    return AnimatedBuilder(
      animation: _animationControllers[index]!,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationControllers[index]!.value * 2 * 3.1416, // 720 graus
          child: AnimatedContainer(
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
              borderRadius: BorderRadius.circular(7),
              child: Image.network(
                photo,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

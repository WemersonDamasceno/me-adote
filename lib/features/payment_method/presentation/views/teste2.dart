import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Foto com Efeito de Gravidade')),
        body: const GravityPhoto(),
      ),
    );
  }
}

class GravityPhoto extends StatefulWidget {
  const GravityPhoto({super.key});

  @override
  _GravityPhotoState createState() => _GravityPhotoState();
}

class _GravityPhotoState extends State<GravityPhoto>
    with TickerProviderStateMixin {
  double _positionY = 0; // Posição inicial da foto
  double _velocityY = 0; // Velocidade da foto (controle da gravidade)
  double _rotation =
      0; // Valor de rotação (controle da rotação durante a queda)
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (true) {
        setState(() {
          _velocityY += 0.5; // Aceleração devido à gravidade
          _positionY += _velocityY;
          _rotation += 0.1; // A cada tick, a rotação aumenta

          // Limitar a posição para evitar ultrapassar o fundo da tela
          if (_positionY > MediaQuery.of(context).size.height - 200) {
            _positionY = MediaQuery.of(context).size.height - 200;
            _velocityY = 0;
            _rotation = 0;
          }
        });
      }
    })
      ..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onSwipeUp(DragUpdateDetails details) {
    if (true) {
      setState(() {
        _velocityY = -17; // Velocidade inicial para o salto (controle do swipe)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onSwipeUp,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1),
            top: _positionY,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Transform.rotate(
              angle: _rotation,
              //TODO Mudar para a bola de basquete
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

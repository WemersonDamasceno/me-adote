import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../../../core/components/button/button_widget.dart';
import '../../../../core/components/cart_icon_with_counter.dart';
import '../../../../core/constants/colors_constants.dart';
import '../../../../core/utils/session/cart_session.dart';
import '../../data/models/product_model.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  final GlobalKey _cartKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  int _quantity = 1;

  final _buttonStateNotifier = ValueNotifier(ButtonStateEnum.enabled);

  late CartSession _cartSession;

  _addToCart(GlobalKey buttonKey) async {
    _buttonStateNotifier.value = ButtonStateEnum.loading;

    await Future.delayed(const Duration(seconds: 1));
    _buttonStateNotifier.value = ButtonStateEnum.success;
    _cartSession.productCount.value += _quantity;
    _initAnimation(buttonKey);
  }

  @override
  void initState() {
    super.initState();
    _cartSession = Provider.of<CartSession>(context, listen: false);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _initAnimation(GlobalKey buttonKey) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    final cartPosition = _getWidgetPosition(_cartKey);
    final buttonPosition = _getWidgetPosition(buttonKey);

    if (buttonPosition != null && cartPosition != null) {
      final overlay = Overlay.of(context);
      final entry = OverlayEntry(
        builder: (context) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final position = Offset.lerp(
                buttonPosition,
                cartPosition,
                _controller.value,
              )!;
              return Positioned(
                left: position.dx,
                top: position.dy,
                child: child!,
              );
            },
            child: SizedBox(
              height: 60,
              width: 60,
              child: Image.network(widget.product.imageUrl),
            ),
          );
        },
      );

      _overlayEntry = entry;
      overlay.insert(entry);

      _controller.reset();
      _controller.forward().whenComplete(() {
        _overlayEntry?.remove();
        _overlayEntry = null;

        _buttonStateNotifier.value = ButtonStateEnum.enabled;
      });
    }
  }

  Offset? _getWidgetPosition(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    return Offset(position.dx + size.width / 2, position.dy + size.height / 2);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();

    return Scaffold(
      backgroundColor: const Color(0xFF1b1f23),
      appBar: AppBar(
        surfaceTintColor: const Color(0xFF1b1f23),
        backgroundColor: const Color(0xFF1b1f23),
        foregroundColor: Colors.white,
        title: const Text(
          'Detalhes do produto',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          CartIconWithCounter(
            key: _cartKey,
            cartSession: _cartSession,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Hero(
                      tag: 'product_${widget.product.name}',
                      child: Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  );
                }),
              ),
              const SizedBox(height: 8),
              Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Quantidade: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: _quantity > 1
                        ? () {
                            setState(() {
                              _quantity--;
                            });
                          }
                        : null,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                key: buttonKey,
                child: ValueListenableBuilder<ButtonStateEnum>(
                  valueListenable: _buttonStateNotifier,
                  builder: (context, buttonState, child) {
                    return ButtonWidget(
                      onPressed: () async => await _addToCart(buttonKey),
                      textButton: 'Adicionar ao carrinho',
                      buttonState: buttonState,
                      backgroundColor: AppColors.primary,
                    );
                  },
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

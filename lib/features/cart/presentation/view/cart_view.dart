import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../../../core/components/button/button_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/extensions/money_extension.dart';
import '../../../../core/utils/session/cart_session.dart';
import '../../../payment_method/presentation/views/payment_method_view.dart';
import '../widget/bottom_item_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartSession cartSession;

  @override
  void initState() {
    super.initState();

    cartSession = Provider.of<CartSession>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        surfaceTintColor: AppColors.background,
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
                valueListenable: cartSession.productCount,
                builder: (context, value, child) {
                  if (value == 0) {
                    return const SizedBox.shrink();
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total de Itens: ($value)',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          cartSession.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Carrinho limpo!')),
                          );
                        },
                        child: const Text(
                          'Limpar Carrinho',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: cartSession.products,
              builder: (_, products, __) {
                if (products.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/icons/no-itens.png'),
                              const SizedBox(height: 16),
                              const Text(
                                'Nenhum item no carrinho',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Navegue pelas nossas ofertas incríveis agora!',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        ButtonWidget(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          textButton: 'Continuar comprando',
                          buttonState: ButtonStateEnum.enabled,
                          backgroundColor: AppColors.primary,
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (ctx, index) {
                            final product = products[index];
                            return ListTile(
                              leading: SizedBox(
                                height: 150,
                                width: 100,
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                product.price.toString().money,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.white),
                                onPressed: () {
                                  cartSession.removeProduct(product);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            BottomItemWidget(
                              label: 'Subtotal',
                              value: cartSession.totalAmount.value,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                bottom: 16,
                              ),
                              child: Divider(
                                color: AppColors.background.withOpacity(0.3),
                              ),
                            ),
                            const BottomItemWidget(label: 'Frete', value: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                bottom: 16,
                              ),
                              child: Divider(
                                color: AppColors.background.withOpacity(0.3),
                              ),
                            ),
                            BottomItemWidget(
                              label: 'Total',
                              value: cartSession.totalAmount.value + 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                bottom: 16,
                              ),
                              child: Divider(
                                color: AppColors.background.withOpacity(0.3),
                              ),
                            ),
                            ButtonWidget(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentMethodView(),
                                  ),
                                );
                              },
                              textButton: 'Finalizar Compra',
                              buttonState: ButtonStateEnum.enabled,
                              backgroundColor: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

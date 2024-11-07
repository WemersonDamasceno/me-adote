import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/cart_icon_with_counter.dart';
import '../../../../core/components/image_carousel.dart';
import '../../../../core/components/search_input/search_input.dart';
import '../../../../core/utils/extensions/money_extension.dart';
import '../../../../core/utils/session/cart_session.dart';
import '../../../cart/presentation/view/cart_view.dart';
import '../mocks/products_mock.dart';
import '../widgets/category_product.dart';
import 'product_detail_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late TextEditingController _searchController;
  late CartSession _cartSession;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _cartSession = Provider.of<CartSession>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SearchInput(
                      readOnly: true,
                      onTap: () => log('onTap'),
                      controller: _searchController,
                      hintText: 'Procure por um produto',
                    ),
                  ),
                  CartIconWithCounter(
                    cartSession: _cartSession,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Todas as Categorias
          const CategoryProduct(),

          // Carousel de coupons
          ImageCarousel(imageUrls: imageUrls),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Produtos para seu Pet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),

          // Lista de produtos
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: GridView.builder(
              shrinkWrap:
                  true, // Permite que o GridView role junto com o conteúdo acima
              physics:
                  const NeverScrollableScrollPhysics(), // Impede rolagem independente
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: listProductsPets.length,
              itemBuilder: (context, index) {
                final productKey = GlobalKey();
                final productItem = listProductsPets[index];

                return GestureDetector(
                  key: productKey,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailView(
                        product: productItem,
                      ),
                    ),
                  ),
                  child: Hero(
                    tag: 'product_${productItem.name}',
                    child: Card(
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 135,
                                width: 160,
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(productItem.imageUrl),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  productItem.name,
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              //Price
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  productItem.price.toString().money,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          //Banner de desconto
                          Visibility(
                            visible: productItem.promotion.isActive,
                            child: Positioned(
                                top: 10,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100),
                                      topLeft: Radius.circular(100),
                                    ),
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    '-${productItem.promotion.price.toInt()}%',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final List<String> imageUrls = [
    'assets/images/coupons/coupon_1.jpeg',
    'assets/images/coupons/coupon_2.jpg',
    'assets/images/coupons/coupon_3.jpg',
    'assets/images/coupons/coupon_4.jpg',
  ];
}

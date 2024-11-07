import 'package:flutter/material.dart';

class CategoryProduct extends StatelessWidget {
  const CategoryProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Todas Categorias',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.sort, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 110,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryItem(
                    iconData: Icons.fastfood,
                    label: 'Comida',
                  ),
                  CategoryItem(
                    iconData: Icons.toys,
                    label: 'Brinquedos',
                  ),
                  CategoryItem(
                    iconData: Icons.bathtub,
                    label: 'Banho',
                  ),
                  CategoryItem(
                    iconData: Icons.pets,
                    label: 'Adestramento',
                  ),
                  CategoryItem(
                    iconData: Icons.spa,
                    label: 'Perfumes',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class CategoryItem extends StatelessWidget {
  final IconData iconData;
  final String label;

  const CategoryItem({super.key, required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Icon(iconData, color: const Color(0xFF1b1f23)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

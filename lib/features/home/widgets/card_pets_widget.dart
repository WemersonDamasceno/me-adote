import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/data/models/pet_model.dart';

class CardPetsWidget extends StatelessWidget {
  final PetModel itemPet;
  final Function() onPressed;
  const CardPetsWidget({
    super.key,
    required this.itemPet,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.45,
      height: size.height * 0.36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 144, 27, 194),
            Color.fromARGB(255, 157, 68, 195),
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: 'pet_${itemPet.nomePet}',
                  child: Container(
                    height: size.height * 0.27,
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            itemPet.urlImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(100),
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  itemPet.nomePet,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.grey,
                  ),
                  Text(
                    'Distancia (${itemPet.quantidadeKms}Km)',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.grey,
                    ),
                  )
                ],
              )
            ],
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                itemPet.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color: AppColors.primary,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

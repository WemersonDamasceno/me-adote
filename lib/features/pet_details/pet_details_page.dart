import 'package:flutter/material.dart';

import '../../core/components/button_widget.dart';
import '../../core/data/models/pet_model.dart';

class PetDetailsPage extends StatefulWidget {
  final int idPet;
  final PetModel petModel;
  const PetDetailsPage({
    Key? key,
    required this.idPet,
    required this.petModel,
  }) : super(key: key);

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  late PetModel petModel;

  @override
  void initState() {
    super.initState();
    petModel = getPetModelById(widget.idPet);
  }

  getPetModelById(int id) {
    return widget.petModel;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            Positioned(
                child: SizedBox(
                    height: size.height * 0.55,
                    child: Hero(
                      tag: 'pet',
                      child: Image.network(
                        petModel.urlImage,
                        fit: BoxFit.cover,
                      ),
                    ))),
            Positioned(
              top: size.height * 0.5,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          petModel.nomePet,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/icons/ic_localizacao.png',
                            width: 35,
                          ),
                          Text(
                            petModel.endereco,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        petModel.descricao,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            cardDados('Idade', '${petModel.idade} Ano'),
                            cardDados('Genero', petModel.genero),
                            cardDados('Peso', '${petModel.peso} Kg'),
                          ],
                        ),
                      ),
                      ButtonWidget(
                        size: size,
                        onPressed: () {},
                        textoButton: 'Entrar em contato',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: size.height * 0.04,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300)),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      )),
                )),
          ],
        ),
      ),
    );
  }

  Widget cardDados(String titulo, String valor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Text(titulo,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              )),
          Text(valor),
        ],
      ),
    );
  }
}

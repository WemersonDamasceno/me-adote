import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/search_input/search_input.dart';
import '../../core/components/snackbar/snackbar_mixin.dart';
import '../../core/data/models/pet_model.dart';
import '../pet_details/pet_details_page.dart';
import 'controllers/home_controller.dart';
import 'models/card_categoria.dart';
import 'widgets/card_categoria_widget.dart';
import 'widgets/card_pets_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SnackbarMixin {
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();

    _homeController = Provider.of<HomeController>(context, listen: false);
    _homeController.getPets();
  }

  int indexCategoriaSelecionada = 0;
  final listaCategorias = [
    CardCategory(
        pathImage: 'assets/images/icons/ic_todos.png', titulo: 'Todos'),
    CardCategory(pathImage: 'assets/images/icons/ic_cao.png', titulo: 'Cães'),
    CardCategory(pathImage: 'assets/images/icons/ic_gato.png', titulo: 'Gatos'),
    CardCategory(
        pathImage: 'assets/images/icons/ic_passaros.png', titulo: 'Passáros'),
    CardCategory(
        pathImage: 'assets/images/icons/ic_roedores.png', titulo: 'Roedores'),
  ];

  final listPets = [
    PetModel(
        genero: 'Masculino',
        idade: 2,
        peso: 5,
        descricao:
            'Um adorável cachorro de 3 anos que está à procura de um lar cheio de amor. Ele tem uma pelagem curta, seu olhar calmo e seu jeitinho carinhoso. ',
        isFavorite: false,
        nomePet: 'Max',
        endereco: 'Av. José Caetano, 134',
        urlImage:
            'https://conteudo.imguol.com.br/c/entretenimento/54/2020/04/28/cachorro-pug-1588098472110_v2_1x1.jpg',
        quantidadeKms: '5'),
    PetModel(
        genero: 'Masculino',
        idade: 2,
        peso: 5,
        descricao:
            '“Au au au AU AU Au au Au au” \nOlá, não tenha medo, ele late quando fica feliz com alguém chegando.',
        isFavorite: false,
        endereco: 'Av. José Caetano, 134',
        nomePet: 'Lup',
        urlImage:
            'https://petfisio.com.br/wp-content/uploads/2017/06/nomes-para-cachorro-1.png',
        quantidadeKms: '5'),
  ];

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.25;
    final double itemWidth = size.width / 2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SearchInput(
              controller: searchController,
              hintText: 'Procure por um pet',
            ),
          ),
          categorias(size),
          Expanded(
            child: GridView.count(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: listPets.map((itemPet) {
                return InkWell(
                  onTap: () {
                    int index = listPets.indexOf(itemPet);
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => PetDetailsPage(
                          idPet: index,
                          petModel: listPets[index],
                        ),
                      ),
                    );
                  },
                  child: CardPetsWidget(
                    onPressed: () {
                      setState(
                        () {
                          int index = listPets.indexOf(itemPet);
                          listPets[index].isFavorite =
                              !listPets[index].isFavorite;
                        },
                      );
                    },
                    itemPet: itemPet,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget categorias(size) {
    return SizedBox(
      height: 75,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listaCategorias.length,
        itemBuilder: (_, index) {
          final item = listaCategorias[index];
          return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CardCategoryWidget(
                categorySelected: indexCategoriaSelecionada,
                pathImage: item.pathImage,
                title: item.titulo,
                index: index,
                onPressed: () {
                  setState(() {
                    indexCategoriaSelecionada = index;
                  });
                },
              ));
        },
      ),
    );
  }
}

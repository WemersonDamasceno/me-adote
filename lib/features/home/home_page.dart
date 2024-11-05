import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/data/models/pet_model.dart';
import '../../core/utils/extensions/name_extension.dart';
import '../../core/utils/session/user_session.dart';
import '../pet_details/pet_details_page.dart';
import 'models/card_categoria.dart';
import 'widgets/card_categoria_widget.dart';
import 'widgets/card_pets_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            '“Au au au AU AU Au au Au au” \nOlá, não tenha medo, ele late quando fica feliz com alguém chegando.',
        isFavorite: false,
        nomePet: 'Meião',
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

  final procurarController = TextEditingController();
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
            padding: const EdgeInsets.only(top: 20),
            child: cabecalho(size),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: campoDeBusca(size),
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
                        transitionDuration: const Duration(seconds: 5),
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

  Widget cabecalho(Size size) {
    final sessionUser = Provider.of<UserSession>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://i.pravatar.cc/332'),
                ),
              ),
              height: size.width * 0.12,
              width: size.width * 0.12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Olá, ${sessionUser.user?.name.firstName}!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.login_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
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

  Widget campoDeBusca(size) {
    return TextFormField(
      controller: procurarController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: -size.width * 0.05),
        hintText: 'Procure por um pet',
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        prefixIcon: const Icon(Icons.search_rounded),
      ),
    );
  }
}

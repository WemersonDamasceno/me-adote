class PetModel {
  String nomePet;
  String quantidadeKms;
  String descricao;
  bool isFavorite;
  String urlImage;
  String endereco;
  int idade;
  String genero;
  double peso;

  PetModel({
    required this.idade,
    required this.genero,
    required this.peso,
    required this.endereco,
    required this.descricao,
    required this.isFavorite,
    required this.nomePet,
    required this.urlImage,
    required this.quantidadeKms,
  });
}

import '../../data/models/product_model.dart';

final listProductsPets = [
  ProductModel(
    id: '1',
    name: 'Ração Premium',
    promotion: PromotionProductModel(id: '5', isActive: true, price: 50.0),
    description:
        'Ração de alta qualidade para cães, com nutrientes essenciais para uma dieta balanceada e saudável. Rica em proteínas e vitaminas, ajuda no desenvolvimento e manutenção da saúde do seu pet. Ideal para cães de todas as idades e raças.',
    price: 100,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK6juh32_eovb37a2-Sxc94zqoLNH1WRWgbg&s',
  ),
  ProductModel(
    id: '2',
    promotion: PromotionProductModel(id: '5', isActive: true, price: 10.0),
    name: 'Brinquedo de Corda',
    description:
        'Brinquedo de corda resistente e seguro para cães, ideal para brincadeiras de puxar e mastigar. Ajuda a manter os dentes limpos e saudáveis enquanto entretém seu pet. Feito com materiais duráveis e cores vibrantes para atrair a atenção do animal.',
    price: 50,
    imageUrl:
        'https://img.freepik.com/fotos-premium/corda-de-algodao-colorida-de-brinquedo-de-cachorro-para-jogos-isolados-em-fundo-branco-com-espaco-de-copia_323015-9940.jpg',
  ),
  ProductModel(
    id: '3',
    name: 'Coleira de Couro',
    promotion: PromotionProductModel(id: '5', isActive: true, price: 10),
    description:
        'Coleira de couro elegante e confortável para cães de médio porte. Ajustável para se adaptar perfeitamente ao pescoço do animal, proporcionando segurança e estilo durante os passeios. Fabricada com couro de alta qualidade, garantindo durabilidade.',
    price: 80,
    imageUrl:
        'https://img.freepik.com/fotos-premium/coleira-de-couro-para-cachorro_692498-5313.jpg',
  ),
  ProductModel(
    id: '4',
    name: 'Areia para Gato',
    promotion: PromotionProductModel(id: '5', isActive: false, price: 0.0),
    description:
        'Areia higiênica para gatos com grãos finos que absorvem rapidamente os líquidos, evitando odores desagradáveis. Ideal para manter o ambiente limpo e confortável para o seu gato. Fácil de limpar e segura para o uso diário.',
    price: 30,
    imageUrl:
        'https://a-static.mlcdn.com.br/1500x1500/areia-sanitaria-para-gatos-classica-graos-finos-areia-para-gato-pipi-pacote-4kg-adg/picodistribuidora/652/27e189d9f7a6129a83526cd2e8f07732.jpeg',
  ),
  ProductModel(
    id: '5',
    name: 'Comedouro Automático',
    promotion: PromotionProductModel(id: '5', isActive: true, price: 25),
    description:
        'Comedouro automático para pets que garante a alimentação na hora certa, mesmo na sua ausência. Possui temporizador ajustável para liberar a quantidade certa de ração. Feito com material resistente e fácil de limpar.',
    price: 150,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLdqMtHfs6Zz-AFvGQfrnOd8YtdU9fmisleQ&s',
  ),
  ProductModel(
    id: '6',
    name: 'Cama para Pet',
    promotion: PromotionProductModel(id: '5', isActive: true, price: 25),
    description:
        'Cama confortável e aconchegante para pets de todos os tamanhos. Feita com material macio e durável, proporciona uma noite de sono tranquila para o seu amigo peludo. Fácil de lavar e com design moderno que combina com qualquer ambiente.',
    price: 120,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJj9_FhuzBmMBXymg741anfSArTx3NktlSgw&s',
  ),
];

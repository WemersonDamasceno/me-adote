extension Money on String {
  String get money {
    final value = double.tryParse(this) ?? 0.0;
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}

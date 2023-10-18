import 'package:expense_tracker/models/categoria.dart';

class Orcamento {
  final String id;
  final String nome;
  final double valor;
  final Categoria categoria;
  final DateTime dataInicio;
  final DateTime dataFim;

  Orcamento ({
    required this.id,
    required this.nome,
    required this.valor,
    required this.categoria,
    required this.dataInicio,
    required this.dataFim,
  });
}

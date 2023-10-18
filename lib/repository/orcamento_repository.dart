import 'package:flutter/material.dart';
import '../models/orcamento.dart';
import '../models/categoria.dart';
import '../models/tipo_transacao.dart';

class OrcamentosRepository {
  Future<List<Orcamento>> listarOrcamentos() async {
    await Future.delayed(const Duration(seconds: 5));
    return [
      Orcamento(
        id: '1',
        nome: 'Orçamento de Casa',
        valor: 2000.00,
        categoria: Categoria(
          id: 1,
          descricao: 'Casa',
          cor: Colors.deepPurple,
          icone: Icons.home, tipoTransacao: TipoTransacao.despesa,
        ),
        dataInicio: DateTime(2023, 1, 1),
        dataFim: DateTime(2023, 12, 31),
      ),
      Orcamento(
        id: '2',
        nome: 'Orçamento de Alimentação',
        valor: 500.00,
        categoria: Categoria(
          id: 2,
          descricao: 'Alimentação',
          cor: Colors.red,
          icone: Icons.fastfood, tipoTransacao: TipoTransacao.despesa,
        ),
        dataInicio: DateTime(2023, 1, 1),
        dataFim: DateTime(2023, 12, 31),
      ),
      Orcamento(
        id: '3',
        nome: 'Orçamento de Lazer',
        valor: 300.00,
        categoria: Categoria(
          id: 3,
          descricao: 'Lazer',
          cor: Colors.orange,
          icone: Icons.gamepad, tipoTransacao: TipoTransacao.despesa,
        ),
        dataInicio: DateTime(2023, 1, 1),
        dataFim: DateTime(2023, 12, 31),
      ),
    ];
  }
}

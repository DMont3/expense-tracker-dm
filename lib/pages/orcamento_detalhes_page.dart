import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/categoria.dart';
import '../models/tipo_transacao.dart';
import '../models/orcamento.dart';

class OrcamentoDetalhesPage extends StatefulWidget {
  const OrcamentoDetalhesPage({super.key});

  @override
  State<OrcamentoDetalhesPage> createState() => _OrcamentoDetalhesPageState();
}

class _OrcamentoDetalhesPageState extends State<OrcamentoDetalhesPage> {
  @override
  Widget build(BuildContext context) {
    final orcamento = ModalRoute.of(context)!.settings.arguments as Orcamento;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(orcamento.nome),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildValor(orcamento.valor),
            _buildPeriodo(orcamento.dataInicio, orcamento.dataFim),
            _buildCategoriaSelect(),
          ],
        ),
      ),
    );
  }

  Widget _buildValor(double valor) {
    return ListTile(
      title: const Text('Valor do Orçamento'),
      subtitle: Text(
        NumberFormat.simpleCurrency(locale: 'pt_BR').format(valor),
      ),
    );
  }

  Widget _buildPeriodo(DateTime dataInicio, DateTime dataFim) {
    return ListTile(
      title: const Text('Período'),
      subtitle: Text(
        '${DateFormat('dd/MM/yyyy').format(dataInicio)} - ${DateFormat('dd/MM/yyyy').format(dataFim)}',
      ),
    );
  }

  Widget _buildCategoriaSelect() {
  final orcamento = ModalRoute.of(context)!.settings.arguments as Orcamento;
    return ListTile(
      title: Text('Categoria'),
      subtitle: Text(orcamento.categoria.descricao),
    );
  }

  Widget _buildObservacao(String observacao) {
    return ListTile(
      title: const Text('Observação'),
      subtitle: Text(observacao.isNotEmpty ? observacao : '-'),
    );
  }
}

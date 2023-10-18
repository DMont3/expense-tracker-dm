import 'package:flutter/material.dart';
import '../components/orcamento_item.dart';
import '../models/orcamento.dart';
import '../repository/orcamento_repository.dart';

class OrcamentosPage extends StatefulWidget {
  const OrcamentosPage({Key? key}) : super(key: key);

  @override
  _OrcamentosPageState createState() => _OrcamentosPageState();
}

class _OrcamentosPageState extends State<OrcamentosPage> {
  final orcamentosRepository = OrcamentosRepository();
  late Future<List<Orcamento>> futureOrcamentos;

  @override
  void initState() {
    futureOrcamentos = orcamentosRepository.listarOrcamentos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Orçamentos'),
      ),
      body: FutureBuilder<List<Orcamento>>(
        future: futureOrcamentos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar os orçamentos"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Nenhum orçamento encontrado"),
            );
          } else {
            final orcamentos = snapshot.data!;
            return ListView.separated(
              itemCount: orcamentos.length,
              itemBuilder: (context, index) {
                final orcamento = orcamentos[index];
                return OrcamentoItem(
                  orcamento: orcamento,
                  onTap: () {
                    Navigator.pushNamed(context, '/orcamento-detalhes',
                        arguments: orcamento);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/orcamento-cadastro');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

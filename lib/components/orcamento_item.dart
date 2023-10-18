import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/orcamento.dart';

class OrcamentoItem extends StatelessWidget {
  final Orcamento orcamento;
  final void Function()? onTap;
  const OrcamentoItem({Key? key, required this.orcamento, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.monetization_on,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Text(
          orcamento.nome,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Período: ${DateFormat('dd/MM/yyyy').format(orcamento.dataInicio)} - ${DateFormat('dd/MM/yyyy').format(orcamento.dataFim)}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              'Valor: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(orcamento.valor)}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          color: Colors.blue,
          onPressed: onTap,
        ),
        onTap: onTap,
      ),
    );
  }
}

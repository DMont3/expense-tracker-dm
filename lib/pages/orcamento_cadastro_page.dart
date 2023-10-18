import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../components/categoria_select.dart';
import '../models/categoria.dart';
import '../models/tipo_transacao.dart';
import 'categorias_select_page.dart';

class OrcamentoCadastroPage extends StatefulWidget {
  const OrcamentoCadastroPage({super.key});

  @override
  State<OrcamentoCadastroPage> createState() => _OrcamentoCadastroPageState();
}

class _OrcamentoCadastroPageState extends State<OrcamentoCadastroPage> {
  final nomeController = TextEditingController();
  final valorController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  final dataInicioController = TextEditingController();
  final dataFimController = TextEditingController();
  final detalhesController = TextEditingController();
  final dataController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  TipoTransacao tipoTransacaoSelecionada = TipoTransacao.despesa;

  Categoria? categoriaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Orçamento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNome(),
                const SizedBox(height: 30),
                _buildValor(),
                const SizedBox(height: 30),
                _buildCategoriaSelect(),
                const SizedBox(height: 30),
                _buildDataInicio(),
                const SizedBox(height: 30),
                _buildDataFim(),
                const SizedBox(height: 30),
                _buildObservacao(),
                const SizedBox(height: 30),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CategoriaSelect _buildCategoriaSelect() {
    return CategoriaSelect(
      categoria: categoriaSelecionada,
       onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoriesSelectPage(
              tipoTransacao: tipoTransacaoSelecionada,
            ),
          ),
        ) as Categoria?;

        if (result != null) {
          setState(() {
            categoriaSelecionada = result;
          });
        }
      },
    );
  }

  TextFormField _buildNome() {
    return TextFormField(
      controller: nomeController,
      decoration: const InputDecoration(
        hintText: 'Informe o nome do orçamento',
        labelText: 'Nome do Orçamento',
        prefixIcon: Icon(Icons.text_fields),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um nome para o orçamento';
        }
        return null;
      },
    );
  }

  TextFormField _buildValor() {
    return TextFormField(
      controller: valorController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Informe o valor do orçamento',
        labelText: 'Valor do Orçamento',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.monetization_on),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um valor para o orçamento';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(valorController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }
        return null;
      },
    );
  }

  TextFormField _buildDataInicio() {
    return TextFormField(
      controller: dataInicioController,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(
        hintText: 'Informe uma Data',
        labelText: 'Data',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Ionicons.calendar_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
      onTap: () async {
        //FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          dataInicioController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
    );
  }

  TextFormField _buildDataFim() {
    return TextFormField(
      controller: dataFimController,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(
        hintText: 'Informe uma Data',
        labelText: 'Data',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Ionicons.calendar_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
      onTap: () async {
        //FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          dataFimController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
    );
  }

  TextFormField _buildObservacao() {
    return TextFormField(
      controller: detalhesController,
      decoration: const InputDecoration(
        hintText: 'Informe alguma observação',
        labelText: 'Observação',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 2,
    );
  }



  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            final nome = nomeController.text;
            final valor = NumberFormat.currency(locale: 'pt_BR')
                .parse(valorController.text.replaceAll('R\$', ''));
            final dataInicio = DateFormat('dd/MM/yyyy')
                .parse(dataInicioController.text);
            final dataFim =
                DateFormat('dd/MM/yyyy').parse(dataFimController.text);
            final detalhes = detalhesController.text;

           
            print(nome);
            print(valor);
            print(dataInicio);
            print(dataFim);
            print(detalhes);
          }
        },
        child: const Text('Cadastrar Orçamento'),
      ),
    );
  }
}

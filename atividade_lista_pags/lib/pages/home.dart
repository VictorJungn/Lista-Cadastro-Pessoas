import 'package:atividade_lista_pags/models/pessoa.dart';
import 'package:atividade_lista_pags/pages/cadastro.dart';
import 'package:atividade_lista_pags/widgets/pessoa_lista.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Pessoa> listaPessoa = [];

  _sortList() {
    listaPessoa.sort((p1, p2) {
      return p1.nome.compareTo(p2.nome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                shrinkWrap: true,
                itemCount: listaPessoa.length,
                itemBuilder: (context, index) {
                  return PessoaLista(
                    pessoa: listaPessoa[index],
                    editarFunc: () {
                      _editar(index);
                    },
                    onDelete: () {
                      setState(() {
                        listaPessoa.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final pessoa = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cadastro(),
              ));
          if (pessoa != null) {
            listaPessoa.add(pessoa);

            setState(() {
              _sortList();
            });
          }
        },
        label: Text('Adicionar'),
      ),
    );
  }

  _editar(int index) async {
    Pessoa pessoaSelecionada = listaPessoa[index];

    Pessoa? pessoa = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Cadastro(
                  pessoaSelecionada: pessoaSelecionada,
                )));
    if (pessoa != null) {
      listaPessoa.add(pessoa);
      listaPessoa.removeAt(index);
      _sortList();
      setState(() {});
    }
  }
}

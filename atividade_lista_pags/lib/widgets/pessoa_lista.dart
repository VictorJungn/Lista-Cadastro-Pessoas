import 'package:atividade_lista_pags/models/pessoa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PessoaLista extends StatelessWidget {
  Pessoa pessoa;
  Function onDelete;
  Function editarFunc;

  PessoaLista(
      {required this.pessoa, required this.onDelete, required this.editarFunc});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      pessoa.nome,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    editarFunc();
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Excluir?'),
                              content: Text('Tem certeza que deseja excluir?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      onDelete();
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                        primary: Color(0xff00d7f3)),
                                    child: Text('Sim')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                        primary: Color(0xff00d7f3)),
                                    child: Text('Não')),
                              ],
                            ));
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(pessoa.email),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(pessoa.telefone),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text('${validadorEstadoCivil(pessoa)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

validadorEstadoCivil(Pessoa pessoa) {
  if (pessoa.estadoCivil == true) {
    return 'Casado(a)';
  } else {
    return 'Solteiro(a)';
  }
}

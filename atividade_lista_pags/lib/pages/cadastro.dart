import 'package:atividade_lista_pags/models/pessoa.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastro extends StatefulWidget {
  Pessoa? pessoaSelecionada;

  Cadastro({Key? key, this.pessoaSelecionada}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  bool validadorEstadoCivil = true;

  GlobalKey<FormState> _nomeFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _telefoneFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.pessoaSelecionada != null) {
      nomeController.text = widget.pessoaSelecionada!.nome;
      emailController.text = widget.pessoaSelecionada!.email;
      telefoneController.text = widget.pessoaSelecionada!.telefone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (nomeController.text != '' ||
            emailController.text != '' ||
            telefoneController.text != '') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Descartar?'),
              content: Text('Tem certeza?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(primary: Color(0xff00d7f3)),
                    child: Text('Sim')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(primary: Color(0xff00d7f3)),
                    child: Text('Não')),
              ],
            ),
          );
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tela de cadastro'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 400,
                    height: 450,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Column(
                        children: [
                          Form(
                            key: _nomeFormKey,
                            child: TextFormField(
                              onChanged: (value) {
                                if (_nomeFormKey.currentState!.validate()) {}
                              },
                              validator: (value) {
                                if (!RegExp(r'[A-Z]+[a-z]')
                                    .hasMatch(value ?? '')) {
                                  return 'A primeira letra deve ser maiúscula!';
                                } else if (value == '') {
                                  return 'Nome obrigatório!';
                                }
                              },
                              controller: nomeController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                label: Text('Nome'),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            key: _emailFormKey,
                            child: TextFormField(
                              onChanged: (value) {
                                if (_emailFormKey.currentState!.validate()) {}
                              },
                              validator: (value) {
                                if (!RegExp(
                                        r'[a-z-A-Z-0-9.-_]+@[a-z-A-Z-0-9-_]+\.(com)|(com.br)|(gov)|(dev)')
                                    .hasMatch(value ?? '')) {
                                  return 'Digite um e-mail válido!';
                                } else if (value == '') {
                                  return 'E-mail obrigatório!';
                                }
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                label: Text('E-mail'),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            key: _telefoneFormKey,
                            child: TextFormField(
                              onChanged: (value) {
                                if (_telefoneFormKey.currentState!
                                    .validate()) {}
                              },
                              validator: (value) {
                                if (!RegExp(
                                        r'(\(?\d{2}\)?\s)?(\d{4,5}\-\d{4})')
                                    .hasMatch(value ?? '')) {
                                  return 'Telefone obrigatório!';
                                }
                              },
                              controller: telefoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                MaskTextInputFormatter(
                                    mask: '(##) '
                                        '9-####-####'),
                              ],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                label: Text('Telefone'),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.tealAccent),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Casado(a)?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Switch(
                                value: validadorEstadoCivil,
                                onChanged: (bool value) {
                                  setState(
                                    () {
                                      validadorEstadoCivil = value;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.tealAccent,
                                fixedSize: Size(300, 40)),
                            onPressed: _salvar,
                            child: Text(
                              'Adicionar',
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _salvar() {
    bool nomeValido = _nomeFormKey.currentState!.validate();
    bool emailValido = _emailFormKey.currentState!.validate();
    bool telefoneValido = _telefoneFormKey.currentState!.validate();

    if (nomeValido && emailValido && telefoneValido) {
      _confirmaSalvar();
    }
  }

  _confirmaSalvar() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Salvar?'),
              content: Text('Tem certeza que deseja salvar?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Não')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _retornarNovaPessoa();
                    },
                    child: Text('Sim')),
              ],
            ));
  }

  _retornarNovaPessoa() {
    Pessoa pessoa = Pessoa(
        nome: nomeController.text,
        telefone: telefoneController.text,
        email: emailController.text,
        estadoCivil: validadorEstadoCivil);
    Navigator.pop(context, pessoa);
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Continuar?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              if (nomeController != null &&
                  telefoneController != null &&
                  emailController != null) {
                Navigator.pop(context);
                Navigator.pop(
                    context,
                    Pessoa(
                        nome: nomeController.text,
                        email: emailController.text,
                        estadoCivil: validadorEstadoCivil,
                        telefone: telefoneController.text));
              }
            });
          },
          child: Text(
            'OK',
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Voltar',
          ),
        ),
      ],
    );
  }
}

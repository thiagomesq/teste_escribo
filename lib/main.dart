import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Somatorio(),
    );
  }
}

class Somatorio extends StatefulWidget {
  @override
  _SomatorioState createState() => _SomatorioState();
}

class _SomatorioState extends State<Somatorio> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _valorFocusNode;
  late int valor;

  @override
  void initState() {
    super.initState();
    _valorFocusNode = FocusNode();
  }

  int somatorio(int valor) {
    int somatorio = 0;
    for (int i = 3; i < valor; i++) {
      if (i % 3 == 0 || i % 5 == 0) {
        somatorio += i;
      }
    }
    return somatorio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Somatório'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  focusNode: _valorFocusNode,
                  onChanged: (data) {
                    setState(() {
                      valor = int.parse(data);
                    });
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return value!.isEmpty || int.parse(value) < 0
                        ? 'Entre com um valor calculável.'
                        : null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    focusColor: Colors.lightBlue,
                  ),
                ),
                SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showGeneralDialog(
                        barrierColor: Colors.white.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          final curvedValue =
                              Curves.easeInOutBack.transform(a1.value) - 1.0;
                          return Transform(
                            transform: Matrix4.translationValues(
                                0.0, curvedValue * 200, 0.0),
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                title: Text('Somatório'),
                                content: Text(
                                  'O resultado do somatório é ${somatorio(valor)}.',
                                ),
                                titleTextStyle:
                                    const TextStyle(color: Colors.lightBlue),
                                contentTextStyle:
                                    const TextStyle(color: Colors.lightBlue),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      primary: Colors.lightBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(
                          seconds: 1,
                        ),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, a1, a2) {
                          final curvedValue =
                              Curves.easeInOutBack.transform(a1.value) - 1.0;
                          return Transform(
                            transform: Matrix4.translationValues(
                                0.0, curvedValue * 200, 0.0),
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                title: Text('Somatório'),
                                content: Text(
                                  'O resultado do somatório é ${somatorio(valor)}.',
                                ),
                                titleTextStyle:
                                    const TextStyle(color: Colors.lightBlue),
                                contentTextStyle:
                                    const TextStyle(color: Colors.lightBlue),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      primary: Colors.lightBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    primary: Colors.lightBlue,
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                  ),
                  child: const Text('Calcular'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

//Funcao principal do app
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Criando controlador peso
  TextEditingController weightController = TextEditingController();

  //Criando controlador altura
  TextEditingController heightController = TextEditingController();

  //Chave global para formulario
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Declarando String _infoText
  String _infoText = 'Informe seus dados!';

  //Funcao reset
  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  //Funcao calcular IMC
  void _calculate() {
    setState(() {
      double peso = double.parse(weightController.text);
      double altura = double.parse(heightController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso Ideal (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente Acima do Peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          //Botão resetar
          actions: [
            IconButton(
              onPressed: _resetFields,
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        //Cor de fundo App
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            //Chave formulario
            key: _formKey,
            child: Column(
              //Manipulando eixo horizontal para deixar da largura da tela
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.green,
                ),
                //texto para digitar numeros
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Insira seu peso';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Peso em (kg)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Insira sua altura';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Altura em (cm)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                ),
                //Criando botao calcular
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                ),
                //Texto informação abaixo do botao
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

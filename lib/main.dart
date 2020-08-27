import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    setState(() {
      _infoText = "Informe seus dados!";
    });
    weightController.text = "";
    heightController.text = "";
    _formKey = GlobalKey<FormState>();
  } //end _resetFields()

  void _calculate() {
    double weight = 0, height = 0;
    double imc = 0;

    setState(() {
      weight = double.parse(weightController.text);
      height = double.parse(heightController.text);
      imc = weight / (height * height);

      if (imc < 18.5) {
        _infoText = "Muito abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.5 && imc <= 24.99) {
        _infoText = "Peso normal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 25.0 && imc <= 29.99) {
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 30 && imc <= 34.99) {
        _infoText = "Obesidade I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 35 && imc <= 39.99) {
        _infoText = "Obesidade II, severa (${imc.toStringAsPrecision(4)})";
      } else if (imc > 40) {
        _infoText = "Obesidade III, mórbida (${imc.toStringAsPrecision(4)})";
      }
    });
  } //end calculate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso!";
                    }else if(double.parse(value) >= 600){
                      return "Seu peso supera o recorde mundial atual, de acordo com a Wikipedia!";
                    }else if(double.parse(value) <= 0){
                      return "Você não veria esta tela se não existisse!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (m)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  // ignore: missing_return
                  validator: (var value) {
                    if (value.isEmpty) {
                      return "Insira sua altura!";
                    }else if( double.parse(value) > 2.465){
                      return "Sua altura supera o recorde mundial de acordo com o G1!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text("Calcular",
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.0)),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ], //Children
            ),
          )),
    );
  }
}

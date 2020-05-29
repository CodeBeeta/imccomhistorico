import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
class Home extends StatefulWidget {

  var pesos = new List<String>();

  Home(){
    pesos = [];
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _info = "Informe seus dados.";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();


  void _resetFields()
  {
    pesoController.text = '';
    alturaController.text = '';
    nomeController.text = '';
    setState(() {
      _info = "Informe seus dados.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState(()
    {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / ( altura * altura);
      print(imc);
      if(imc < 18.6){
        _info = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
      } else if(imc >= 18.6 && imc < 24.9){
        _info = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
      } else if(imc >= 24.9 && imc < 29.9){
        _info = 'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})';
      } else if(imc >= 29.9 && imc < 34.9){
        _info = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      } else if(imc >= 34.9 && imc < 39.9){
        _info = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      } else if(imc >= 40){
        _info = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
      }

      widget.pesos.add(nomeController.text +' - '+ _info);


    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calcula IMC"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: Container (
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.local_hospital, size: 30.0, color: Colors.red),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: nomeController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira seu Nome!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: pesoController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (CM)",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: alturaController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira sua Altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _calcular();
                          }
                        },
                        child: Text('Calcular',style: TextStyle(color: Colors.white, fontSize: 25.0),),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text(_info,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                  Column(
                    children: <Widget>[
                      Text("HISTÓRICO DE CÁLCULOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                       ListView.builder(
                         shrinkWrap: true,
                        itemCount: widget.pesos.length,
                        itemBuilder: (BuildContext ctxt, int index){
                          final peso = widget.pesos[index];
                           return ListTile(
                             leading: Icon(Icons.favorite, color:Colors.pink ),

                             title: Text(peso),
                           );

                        },
                      ),
                    ],
                  ),

                ],
              ),

            )


        )

    );
  }


}
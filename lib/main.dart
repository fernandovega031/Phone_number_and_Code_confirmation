import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:international_phone_input/international_phone_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title:
          Text("Telefono",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Image.asset('assets/images/Flutter.jpeg', height: 200),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 120.0, 130.0, 40.0),
              child:  Text(
                'Ingresa tu numero telefonico y te enviaremos un codigo de registro',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    fontSize: 14
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: InternationalPhoneInput(
                onPhoneNumberChange: onPhoneNumberChange,
                initialPhoneNumber: phoneNumber,
                initialSelection: phoneIsoCode,
                enabledCountries: ['+233', '+1','+52','+57','+54'],
                hintText: "(962) 867-8397",
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
              child:Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 330.0,
                    height: 70.0,
                    child:RaisedButton(
                        onPressed: () {

                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePageConfirmation()
                              ));

                        },
                        child: Text('Continuar'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        textColor: Colors.white,
                        color: Colors.blue
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHomePageConfirmation extends StatefulWidget {


  @override
  _MyHomePageStateConfirmation createState() => _MyHomePageStateConfirmation();
}

class _MyHomePageStateConfirmation extends State<MyHomePageConfirmation> {

  /// PinInputTextFormField form-key
  final GlobalKey<FormFieldState<String>> _formKey =
  GlobalKey<FormFieldState<String>>(debugLabel: '_formkey');

  /// Control the input text field.
  TextEditingController _pinEditingController =
  TextEditingController(text: '');

  GlobalKey<ScaffoldState> _globalKey =
  GlobalKey<ScaffoldState>(debugLabel: 'home page global key');


  /// Indicate whether the PinInputTextFormField has error or not
  /// after being validated.
  bool _hasError = false;

  @override
  void initState() {
    _pinEditingController.addListener(() {
      debugPrint('controller execute. pin:${_pinEditingController.text}');
    });
    super.initState();
  }

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title:
          Text("Confirmacion",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 120.0, 100.0, 40.0),
              child:  Text(
                'Please enter the verification code from the sms we just send you,',
                textAlign: TextAlign.left,
                maxLines: 2,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: 14
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
              child:            SizedBox(
                height: 54.0,
                child: PinInputTextFormField(
                  key: _formKey,
                  pinLength: 4,
                  decoration: BoxLooseDecoration(
                    enteredColor: Colors.green,
                    solidColor: Colors.transparent,
                    hintText: "****",
                  ),
                  controller: _pinEditingController,
                  textInputAction: TextInputAction.go,
                  enabled: true,
                  onSubmit: (pin) {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                  },
                  onChanged: (pin) {
                    debugPrint('onChanged execute. pin:$pin');
                  },
                  onSaved: (pin) {
                    debugPrint('onSaved pin:$pin');
                  },
                  validator: (pin) {
                    if (pin.isEmpty) {
                      setState(() {
                        _hasError = true;
                      });
                      return 'Pin cannot empty.';
                    }
                    setState(() {
                      _hasError = false;
                    });
                    return null;
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
              child:Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 330.0,
                    height: 70.0,
                    child:RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                        child: Text('Continuar'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        textColor: Colors.white,
                        color: Colors.blue
                    ),
                  ),
                ],
              ),
            ),
      Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0,0.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '¿Aun no llega?',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: 12
                ),
              ),
              FlatButton(
                child: Text(
                  'Reenviar Codigo',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                  ),
                ),
                onPressed: () {

                },
              )
            ]

        )
      )

          ],
        ),
      )
    );
  }
}



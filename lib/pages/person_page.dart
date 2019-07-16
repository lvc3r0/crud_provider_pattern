import '../providers/person_provider.dart';
import '../providers/validator_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../model/person.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

class PersonPage extends StatefulWidget {
  final String appBarTitle;
  final Person person;

  PersonPage(this.person, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return PersonPageState(this.person, this.appBarTitle);
  }
}

class PersonPageState extends State<PersonPage> {
  final TextStyle textstyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  String appBarTitle;
  Person person;

  String sexSelected;

  List<Map<String, String>> sexList = [
    {'id': '1', 'name': 'Hombre'},
    {'id': '2', 'name': 'Mujer'},
    {'id': '3', 'name': 'Otro'}
  ];

  TextEditingController idController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  PersonPageState(this.person, this.appBarTitle);

  @override
  void initState() {
    super.initState();
    idController.text = person.id != null ? person.id.toString() : null;
    surnameController.text = person.surname;
    firstnameController.text = person.firstname;
    dniController.text = person.dni;
    addressController.text = person.address;

    if (person.sex != null) {
      sexList.forEach((map) {
        if (map['id'] == person.sex.toString()) {
          sexSelected = map['id'];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final PersonProvider personProvider = Provider.of<PersonProvider>(context);
    final ValidatorProvider validatorProvider =
        Provider.of<ValidatorProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.black,
              ),
              onPressed: () async {
                await submitForm(validatorProvider, personProvider);
              },
            ),
          ],
          title: Text(
            appBarTitle,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Apellidos",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    TextField(
                      controller: surnameController,
                      onChanged: validatorProvider.validateInputSurname,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.red),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          errorText: validatorProvider.invalidSurname),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nombres",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    TextField(
                      controller: firstnameController,
                      onChanged: validatorProvider.validateInputFirstName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.red),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          errorText: validatorProvider.invalidFirstname),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "DNI",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextField(
                      controller: dniController,
                      onChanged: validatorProvider.validateInputDNI,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorText: validatorProvider.invalidDNI,
                          errorStyle: TextStyle(color: Colors.red),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          errorMaxLines: 2),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sexo",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 60.0,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: validatorProvider.invalidSex == ''
                                  ? Colors.grey
                                  : Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("Seleccione"),
                          value: sexSelected,
                          items: sexList.map((sex) {
                            return DropdownMenuItem<String>(
                              value: sex['id'],
                              child: Text(sex['name']),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            validatorProvider.validateSex(value);
                            setState(() {
                              sexSelected = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          validatorProvider.invalidSex,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.left,
                        )),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dirección",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextField(
                      controller: addressController,
                      onChanged: validatorProvider.validateInputAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: validatorProvider.invalidAddress,
                        errorStyle: TextStyle(color: Colors.red),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  submitForm(validatorProvider, personProvider) async {
    person.surname = surnameController.text;
    person.firstname = firstnameController.text;
    person.dni = dniController.text;
    person.address = addressController.text;
    person.sex = sexSelected == null ? null : int.parse(sexSelected);
    await validatorProvider.validForm(person);
    if (validatorProvider.formValid) {
      await personProvider.saveOrUpdatePerson(person);
      Navigator.pop(context);
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Toast.show("Formulario incompleto", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}

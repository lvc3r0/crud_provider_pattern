import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import '../model/person.dart';
import '../pages/person_page.dart';
import '../providers/person_provider.dart';
import '../providers/validator_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListPageState();
  }
}

class ListPageState extends State<ListPage> {
  List<Person> personList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final PersonProvider personProvider = Provider.of<PersonProvider>(context);
    final ValidatorProvider validatorProvider =
        Provider.of<ValidatorProvider>(context);
    personProvider.updateListPerson();
    this.personList = personProvider.personList;
    this.count = personList.length;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                navigateToDetail(Person('', '', '', null, ''),
                    'Registrar Persona', validatorProvider);
              },
            ),
          ],
          title: Text(
            'Lista de Personas',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: getListPerson(context, personProvider, validatorProvider));
  }

  ListView getListPerson(context, personProvider, validatorProvider) {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text(
              '${personList[position].surname} ${personList[position].firstname}',
              style: titleStyle,
            ),
            subtitle: Text(
              '${personList[position].dni}',
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () async {
                _onAlertButtonsPressed(
                    context, personProvider, personList[position].id);
              },
            ),
            onTap: () {
              navigateToDetail(
                  personList[position], 'Editar Persona', validatorProvider);
            },
          ),
        );
      },
    );
  }

  _onAlertButtonsPressed(context, personProvider, int id) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "ATENCIÓN",
      desc: "¿ Desea eliminar este registro ?",
      buttons: [
        DialogButton(
          child: Text(
            "SI",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            await personProvider.deletePerson(id);
            Navigator.pop(context);
          },
          color: Colors.red,
        ),
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.blue,
        )
      ],
    ).show();
  }

  void navigateToDetail(Person person, String title, validatorBloc) async {
    await validatorBloc.resetForm();
    await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade, child: PersonPage(person, title)));
  }
}

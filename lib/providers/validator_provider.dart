import 'package:flutter/material.dart';
import '../model/person.dart';

class ValidatorProvider extends ChangeNotifier {
  bool formValid = false;
  String invalidSurname = null;
  String invalidFirstname = null;
  String invalidDNI = null;
  String invalidSex = '';
  String invalidAddress = null;

  validateInputSurname(String value) {
    invalidSurname = null;
    if (value == '') {
      invalidSurname = 'Ingrese un apellido';
    }
    notifyListeners();
  }

  validateInputFirstName(String value) {
    invalidFirstname = null;
    if (value == '') {
      invalidFirstname = 'Ingrese un nombre';
    }
    notifyListeners();
  }

  validateInputDNI(String value) {
    invalidDNI = null;
    int maxLength = 8;
    if (value == '') {
      invalidDNI = 'Ingrese un número DNI valido';
    } else if (value.length < maxLength) {
      invalidDNI = 'El numero mínimo es de ${maxLength} números';
    } else if (value.length > maxLength) {
      invalidDNI = 'El numero máximo es de ${maxLength} números';
    }
    notifyListeners();
  }

  validateSex(String value) {
    invalidSex = '';
    if (value == '' || value == null) {
      invalidSex = '\nSeleccione una opción';
    }
    notifyListeners();
  }

  validateInputAddress(String value) {
    invalidAddress = null;
    if (value == '') {
      invalidAddress = 'Ingrese una dirección';
    }
    notifyListeners();
  }

  resetForm() async {
    formValid = false;
    invalidSurname = null;
    invalidFirstname = null;
    invalidDNI = null;
    invalidSex = '';
    invalidAddress = null;
    notifyListeners();
  }

  validForm(Person person) async {
    int maxLength = 8;
    bool result = true;
    if (person.surname == '' || person.surname == null) {
      result = false;
      invalidSurname = 'Ingrese un apellido';
    }
    if (person.firstname == '' || person.firstname == null) {
      result = false;
      invalidFirstname = 'Ingrese un nombre';
    }
    if (person.dni == '' || person.dni == null) {
      result = false;
      invalidDNI = 'Ingrese un número DNI valido';
    } else if (person.dni.length < maxLength) {
      result = false;
      invalidDNI = 'El numero mínimo es de ${maxLength} números';
    } else if (person.dni.length > maxLength) {
      result = false;
      invalidDNI = 'El numero máximo es de ${maxLength} números';
    }
    if (person.sex == '' || person.sex == null) {
      result = false;
      invalidSex = '\nSeleccione una opción';
    }
    if (person.address == '') {
      result = false;
      invalidAddress = 'Ingrese una dirección';
    }
    if (result) {
      formValid = true;
    }
    notifyListeners();
  }
}

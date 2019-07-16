class Person {
  int _id;
  String _surname;
  String _firstname;
  String _dni;
  int _sex;
  String _address;

  Person(this._surname, this._firstname, this._dni, this._sex, this._address);

  Person.withId(this._id, this._surname, this._firstname, this._dni, this._sex,
      this._address);

  int get id => _id;
  String get surname => _surname;
  String get firstname => _firstname;
  String get dni => _dni;
  int get sex => _sex;
  String get address => _address;

  set id(int id) => this._id = id;

  set surname(String surname) => this._surname = surname;

  set firstname(String firstname) => this._firstname = firstname;

  set dni(String dni) => this._dni = dni;

  set sex(int sex) => this._sex = sex;

  set address(String address) => this._address = address;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['surname'] = _surname;
    map['firstname'] = _firstname;
    map['dni'] = _dni;
    map['sex'] = _sex;
    map['address'] = _address;
    return map;
  }

  Person.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    surname = map['surname'];
    firstname = map['firstname'];
    dni = map['dni'];
    sex = map['sex'];
    address = map['address'];
  }
}

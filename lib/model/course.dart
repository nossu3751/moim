class Course {
  String _id;
  String _name;

  Course(this._id, this._name);

  getName() => this._name;
  setName(name) => this._name = name;
}
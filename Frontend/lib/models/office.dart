class Office {
  String _name;
  Set<String> _timeTables;
  Office(String name, Set<String> timeTables) {
    this._name = name;
    this._timeTables = timeTables;
  }

  String getName() {
    return _name;
  }

  Set<String> getTimeTables() {
    return _timeTables;
  }
}

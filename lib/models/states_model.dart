class States {
  List<StateModel> states;
  String message;
  String statusCode;

  States({
    required this.states,
    required this.message,
    required this.statusCode,
  });

  factory States.fromJson(Map<String, dynamic> json) {
    var stateList = json['states'] as List<dynamic>;
    List<StateModel> states = stateList.map((item) => StateModel.fromJson(item)).toList();

    return States(
      states: states,
      message: json['message'],
      statusCode: json['status_code'],
    );
  }
}

class StateModel {
  int id;
  String name;

  StateModel({
    required this.id,
    required this.name,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

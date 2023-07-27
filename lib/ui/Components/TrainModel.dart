class TrainModel{
  String? name;


  TrainModel(
      {this.name,});
}

class CourseList {
  static List<TrainModel> list = [
    TrainModel(
        name: "Data Science"),
    TrainModel(
        name: "Big Data",
       ),
  ];
}

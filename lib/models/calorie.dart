class CalorieModel {
  Result? result;

  CalorieModel({this.result});

  CalorieModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? protein;
  int? fat;
  int? carbs;
  int? calories;

  Result({this.protein, this.fat, this.carbs, this.calories});

  Result.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbs = json['carbs'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbs'] = this.carbs;
    data['calories'] = this.calories;
    return data;
  }
}
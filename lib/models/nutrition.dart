class NutritionModel {
  int? recipesUsed;
  Calories? calories;
  Calories? fat;
  Calories? protein;
  Calories? carbs;

  NutritionModel(
      {this.recipesUsed, this.calories, this.fat, this.protein, this.carbs});

  NutritionModel.fromJson(Map<String, dynamic> json) {
    recipesUsed = json['recipesUsed'];
    calories = json['calories'] != null
        ? new Calories.fromJson(json['calories'])
        : null;
    fat = json['fat'] != null ? new Calories.fromJson(json['fat']) : null;
    protein =
        json['protein'] != null ? new Calories.fromJson(json['protein']) : null;
    carbs = json['carbs'] != null ? new Calories.fromJson(json['carbs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipesUsed'] = this.recipesUsed;
    if (this.calories != null) {
      data['calories'] = this.calories!.toJson();
    }
    if (this.fat != null) {
      data['fat'] = this.fat!.toJson();
    }
    if (this.protein != null) {
      data['protein'] = this.protein!.toJson();
    }
    if (this.carbs != null) {
      data['carbs'] = this.carbs!.toJson();
    }
    return data;
  }
}

class Calories {
  double? value;
  String? unit;
  ConfidenceRange95Percent? confidenceRange95Percent;
  double? standardDeviation;

  Calories(
      {this.value,
      this.unit,
      this.confidenceRange95Percent,
      this.standardDeviation});

  Calories.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
    confidenceRange95Percent = json['confidenceRange95Percent'] != null
        ? new ConfidenceRange95Percent.fromJson(
            json['confidenceRange95Percent'])
        : null;
    standardDeviation = json['standardDeviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    if (this.confidenceRange95Percent != null) {
      data['confidenceRange95Percent'] =
          this.confidenceRange95Percent!.toJson();
    }
    data['standardDeviation'] = this.standardDeviation;
    return data;
  }
}

class ConfidenceRange95Percent {
  double? min;
  double? max;

  ConfidenceRange95Percent({this.min, this.max});

  ConfidenceRange95Percent.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}
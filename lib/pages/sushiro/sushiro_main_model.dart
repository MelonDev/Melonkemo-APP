class PeopleModel {
  String id;
  String name;
  late List<SideDishPlateModel> plates;
  late SushiPlateModel copper;
  late SushiPlateModel silver;
  late SushiPlateModel gold;
  late SushiPlateModel black;

  PeopleModel(this.id, this.name,
      {List<SideDishPlateModel>? plates,
      SushiPlateModel? copper,
      SushiPlateModel? silver,
      SushiPlateModel? gold,
      SushiPlateModel? black}) {
    this.plates = plates ?? [];
    this.copper = copper ?? SushiPlateModel(SushiPlateType.copper, 0);
    this.silver = silver ?? SushiPlateModel(SushiPlateType.silver, 0);
    this.gold = gold ?? SushiPlateModel(SushiPlateType.gold, 0);
    this.black = black ?? SushiPlateModel(SushiPlateType.black, 0);
  }

  PeopleModel copy() {
    return PeopleModel(
      id,
      name,
      plates: plates
          .map((plate) => SideDishPlateModel(
              plate.name, plate.price, plate.value,
              shared: plate.shared
                  .map((shared) => PeopleShareModel(shared.peopleId))
                  .toList()))
          .toList(),
      copper: SushiPlateModel(copper.type, copper.value),
      silver: SushiPlateModel(silver.type, silver.value),
      gold: SushiPlateModel(gold.type, gold.value),
      black: SushiPlateModel(black.type, black.value),
    );
  }
}

class PeopleShareModel {
  String peopleId;

  PeopleShareModel(this.peopleId);
}

class PeopleSharePercentModel extends PeopleShareModel {
  double percent;

  PeopleSharePercentModel(super.peopleId, this.percent);
}

class PeopleSharePartialModel extends PeopleShareModel {
  double price;

  PeopleSharePartialModel(super.peopleId, this.price);
}

class PlateModel {
  List<PeopleShareModel> shared;
  int value;

  PlateModel(this.value, {List<PeopleShareModel>? shared})
      : shared = shared ?? [];
}

enum SushiPlateType { copper, silver, gold, black }

class SushiPlateModel extends PlateModel {
  SushiPlateType type;

  SushiPlateModel(this.type, super.value, {super.shared});
}

class SideDishPlateModel extends PlateModel {
  String? name;
  double price;

  SideDishPlateModel(this.name, this.price, super.value, {super.shared});

  SideDishPlateModel copy() {
    return SideDishPlateModel(name, price, value,
        shared:
            shared.map((shared) => PeopleShareModel(shared.peopleId)).toList());
  }
}

class SushiroModel {
  List<PlateModel> plates;

  SushiroModel({List<PlateModel>? plates}) : plates = plates ?? [];
}

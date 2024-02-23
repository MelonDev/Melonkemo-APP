class PeopleModel {
  String id;
  String name;
  List<PlateModel> plates;

  PeopleModel(this.id,this.name, {List<PlateModel>? plates}) : plates = plates ?? [];
}

class PeopleShareModel {
  String peopleId;
  PeopleShareModel(this.peopleId);
}

class PeopleSharePercentModel extends PeopleShareModel {
  double percent;
  PeopleSharePercentModel(super.peopleId,this.percent);
}

class PeopleSharePartialModel extends PeopleShareModel {
  double price;
  PeopleSharePartialModel(super.peopleId,this.price);
}

class PlateModel {
  String ownerId;
  List<PeopleShareModel> shared;

  PlateModel(this.ownerId,{List<PeopleShareModel>? shared}) : shared = shared ?? [];
}

enum SushiPlateType { copper, silver, gold, black }

class SushiPlateModel extends PlateModel {
  SushiPlateType type;

  SushiPlateModel(super.ownerId,this.type,{super.shared});
}

class SideDishPlateModel extends PlateModel {
  String? name;
  double price;

  SideDishPlateModel(super.ownerId,this.name, this.price,{super.shared});
}

class SushiroModel {
  List<PlateModel> plates;

  SushiroModel({List<PlateModel>? plates}) : plates = plates ?? [];
}

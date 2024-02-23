import 'package:flutter/material.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';

class SushiroMainProvider extends ChangeNotifier {
  List<PeopleModel> peoples = [
    PeopleModel("1", "ทดสอบ 1"),
    PeopleModel("2", "ทดสอบ 2"),
    PeopleModel("3", "ทดสอบ 3")
  ];
  List<PlateModel> plates = [
    SushiPlateModel("1", SushiPlateType.copper),
    SushiPlateModel("1", SushiPlateType.copper),
    SushiPlateModel("2", SushiPlateType.copper),
    SideDishPlateModel("2", "Ramen", 150.0),
    SushiPlateModel("1", SushiPlateType.silver),
    SushiPlateModel("3", SushiPlateType.black),
  ];

  initialGroup(List<PeopleModel> peoples) {
    this.peoples = peoples;
    notifyListeners();
  }

  addPeople(PeopleModel people) {
    peoples.add(people);
    notifyListeners();
  }

  updatePeople(int position, PeopleModel people) {
    peoples[position] = people;
    notifyListeners();
  }

  removePeople(int position) {
    peoples.removeAt(position);
    notifyListeners();
  }

  addSushi(String peopleId, SushiPlateType type,
      {List<PeopleShareModel>? share}) {
    plates.add(SushiPlateModel(peopleId, type, shared: share));
    notifyListeners();
  }

  addSideDish(String peopleId, String sideDishName, double price,
      {List<PeopleShareModel>? share}) {
    plates
        .add(SideDishPlateModel(peopleId, sideDishName, price, shared: share));
    notifyListeners();
  }

  List<PlateModel> getPlateFromPeopleId(String peopleId) {
    return plates.where((element) => element.ownerId == peopleId).toList();
  }

  updatePlate(int position, PlateModel plate) {
    if (position >= plates.length) return;
    plates[position] = plate;
    notifyListeners;
  }

  removePlate(int position) {
    if (position >= plates.length) return;
    plates.removeAt(position);
    notifyListeners;
  }

  static double calculateSushi(SushiPlateType type, int plateCount) {
    int basePrice = 0;
    if (type == SushiPlateType.copper) {
      basePrice = 40;
    } else if (type == SushiPlateType.silver) {
      basePrice = 60;
    } else if (type == SushiPlateType.gold) {
      basePrice = 80;
    } else if (type == SushiPlateType.black) {
      basePrice = 120;
    }
    return (plateCount * basePrice).toDouble();
  }

  static double calculateSideDish(List<PlateModel> plates) {
    double price = 0.0;
    for (PlateModel plate in plates) {
      if(plate is SideDishPlateModel){
        price += plate.price;
      }
    }
    return price;
  }

  double calculatePrice({String? peopleId,bool includeServiceCharge = false}){
    double price = 0.0;

    for(PlateModel plate in peopleId != null ? plates.where((element) => element.ownerId == peopleId) : plates){
      if(plate is SushiPlateModel){
        price += calculateSushi(plate.type,1);
      }else if (plate is SideDishPlateModel) {
        price += plate.price;
      }
    }

    return price * (includeServiceCharge ? 1.1 : 1);
  }
}

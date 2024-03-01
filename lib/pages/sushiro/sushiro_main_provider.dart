import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_model.dart';

class SushiroMainProvider extends ChangeNotifier {
  List<PeopleModel> peoples = [
    PeopleModel("0", "คนที่ 1",
        copper: SushiPlateModel(SushiPlateType.copper, 2),
        silver: SushiPlateModel(SushiPlateType.silver, 1),
        plates: []),
    // PeopleModel("2", "คนที่ 2",
    //     copper: SushiPlateModel(SushiPlateType.copper, 1),
    //     plates: [
    //       SideDishPlateModel("Ramen", 150.0, 1),
    //     ]),
    // PeopleModel("3", "คนที่ 3",
    //     black: SushiPlateModel(SushiPlateType.black, 1), plates: [])
  ];

  initialGroup(List<PeopleModel> peoples) {
    this.peoples = peoples;
    notifyListeners();
  }

  addPeople(PeopleModel people) {
    peoples.add(people);
    notifyListeners();
  }

  updatePeople(PeopleModel people) {
    int index = peoples.indexWhere((element) => element.id == people.id);
    if(index != -1){
      peoples[index] = people;
    }
    notifyListeners();
  }

  removePeople(PeopleModel people) {
    int index = peoples.indexWhere((element) => element.id == people.id);
    peoples.removeAt(index);
    notifyListeners();
  }

  addSushi(String peopleId, SushiPlateType type,
      {List<PeopleShareModel>? share}) {
    //plates.add(SushiPlateModel(peopleId, type, shared: share));
    notifyListeners();
  }

  addSideDish(String peopleId, String sideDishName, double price,
      {List<PeopleShareModel>? share}) {
    // plates
    //     .add(SideDishPlateModel(peopleId, sideDishName, price, shared: share));
    notifyListeners();
  }

  List<PlateModel> getPlateFromPeopleId(String peopleId) {
    return peoples
        .where((element) => element.id == peopleId)
        .toList()
        .first
        .plates;
  }

  updatePlate(int position, PlateModel plate) {
    // if (position >= plates.length) return;
    // plates[position] = plate;
    notifyListeners;
  }

  removePlate(int position) {
    // if (position >= plates.length) return;
    // plates.removeAt(position);
    notifyListeners;
  }

  static double getSushiPlatePrice(SushiPlateType type){
    if (type == SushiPlateType.copper) {
      return 40;
    } else if (type == SushiPlateType.silver) {
      return 60;
    } else if (type == SushiPlateType.gold) {
      return 80;
    } else if (type == SushiPlateType.black) {
      return 120;
    }else {
      return 0;
    }
  }

  static double calculateSushi(SushiPlateType type, int plateCount) {
    double basePrice = SushiroMainProvider.getSushiPlatePrice(type);
    return plateCount.toDouble() * basePrice;
  }

  static double calculate(List<PlateModel> plates) {
    double price = 0.0;
    for (PlateModel plate in plates) {
      if (plate is SideDishPlateModel) {
        price += ((plate.price) * plate.value);
      }
      if (plate is SushiPlateModel) {
        price += calculateSushi(plate.type, plate.value);
      }
    }
    return price;
  }

  double calculatePrice({String? peopleId, bool includeServiceCharge = false}) {
    double price = 0.0;

    for (PeopleModel people in peopleId != null
        ? peoples.where((element) => element.id == peopleId)
        : peoples) {
      for (SideDishPlateModel plate in people.plates) {
        price += (plate.price * plate.value);
      }
      price += calculateSushi(SushiPlateType.copper,people.copper.value);
      price += calculateSushi(SushiPlateType.silver,people.silver.value);
      price += calculateSushi(SushiPlateType.gold,people.gold.value);
      price += calculateSushi(SushiPlateType.black,people.black.value);

    }

    return price * (includeServiceCharge ? 1.1 : 1);
  }
}

// ignore_for_file: avoid_print

import 'package:ktcarmaintenanceflutter/src/models/database.dart';
import 'package:ktcarmaintenanceflutter/src/models/maintenances.dart';
import 'package:ktcarmaintenanceflutter/src/models/query/maintenance_query.dart';
import 'package:ktcarmaintenanceflutter/src/models/query/vehicle_query.dart';
import 'package:ktcarmaintenanceflutter/src/models/vehicles.dart';

class VehicleRepository {
  
  // create vehicle
  Future<Vehicle> createVehicle({
    required String name,
    String? brands,
    String? matricule,
    String? image
  }) async {
    try{
      final vehicle = Vehicle();
      vehicle.name = name;
      if(brands != null) vehicle.brands = brands;
      if(matricule != null) vehicle.matricule = matricule;
      if(image != null) vehicle.image = image;
      await vehicle.save();
      return vehicle;
    }catch(e){
      print('error create vehicle ${e.toString()}');
      throw Exception('Error create vehicle');
    }
  }

  // update vehicle
  Future<Vehicle> updateVehicle(int id, {
    String? name,
    String? brands,
    String? matricule,
    String? image
  }) async {
    try{
      final vehicle = await VehicleQuery().find(id);
      if(vehicle == null) throw Exception('Vehicle not exist');

      if(name != null) vehicle.name = name;
      if(brands != null) vehicle.brands = brands;
      if(matricule != null) vehicle.matricule = matricule;
      if(image != null) vehicle.image = image;

      await vehicle.save();
      return vehicle;
    }catch(e){
      print('error update vehicle ${e.toString()}');
      throw Exception('Error update vehicle');
    }
  }

  // delete vehicle
  Future<bool>deleteVehicle(int id) async {
    try{
      final vehicle = await VehicleQuery().find(id);
      if(vehicle == null) throw Exception('Vehicle not exist');

      await vehicle.delete();
      return true;
    }catch(e){
      print('error delete vehicle ${e.toString()}');
      throw Exception('Error delete vehicle');
    }
  }

  // get list vehicle with pagination
  Future<VehiclePaginate>getListVehicles({
    int page = 1,
    int perPage = 10
  }) async{
    VehicleQuery query = VehicleQuery();
    try{
      final result = await query.paginate(page: page, perPage: perPage);
      return result;
    }catch(e){
      print('error get list vehicle ${e.toString()}');
      throw Exception('Error get list vehicle');
    }
  }

  // get vehicle by id
  Future<Vehicle>getVehicle(int id) async{
    try{
      final vehicle = await VehicleQuery().find(id);
      if(vehicle != null) return vehicle;
      throw Exception('Vehicle not found');
    }catch(e){
      print('error get vehicle ${e.toString()}');
      throw Exception('Error get vehicle');
    }
  }

  // get list maintenance of vehicle with pagination
  Future<MaintenancePaginate>getVehicleMaintenanceList({
    required Vehicle vehicle,
    int page = 1,
    int perPage = 10
  }) async{
    MaintenanceQuery query = MaintenanceQuery();
    try{
      final maintenances = await query.fromVehicle(vehicle).paginate(page: page, perPage: perPage);
      return maintenances;
    }catch(e){
      print('error get vehicle ${e.toString()}');
      throw Exception('Error get vehicle');
    }
  }
}
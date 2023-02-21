// ignore_for_file: avoid_print
// class for query builder maintenance

import 'package:ktcarmaintenanceflutter/src/models/database.dart';
import 'package:ktcarmaintenanceflutter/src/models/maintenances.dart';

class MaintenanceQuery {
  MaintenanceQuery();
  
  Maintenance query = Maintenance(); // init query with Maintenance model query
  MaintenanceFilterBuilder _select = Maintenance().select(); // init query builder select vehicle

  // get vehicle by id
  Future<Maintenance?> find(id) async {
    try {
      final vehicle = await query.getById(id);
      return vehicle;
    } catch (e) {
      print('error find MaintenanceQuery ${e.toString()}');
      throw Exception('Error find MaintenanceQuery');
    }
  }

  // set select params in filter builder
  MaintenanceQuery select({
    List<String>? columnsToSelect, 
    bool? getIsDeleted
  }) {
    _select = query.select(
      columnsToSelect: columnsToSelect, 
      getIsDeleted: getIsDeleted
    );
    return this;
  }

  // execute query and get all data using select filter
  Future<List<Maintenance>> get() async {
    try {
      final result = await _select.toList();
      return result;
    } catch (e) {
      print('error get MaintenanceQuery ${e.toString()}');
      throw Exception('Error get MaintenanceQuery');
    }
  }

  // execute query and get data with pagination using select filter
  Future<MaintenancePaginate> paginate({
    int page = 1, 
    int perPage = 10
  }) async {
    try {
      final vehicles = await _select.page(page, perPage).toList();
      final totalCount = await _select.toCount();
      final totalPages = (totalCount / perPage).ceil();
      final result = MaintenancePaginate(
        page: page,
        perPage: perPage,
        totalCount: totalCount,
        totalPages: totalPages,
        data: vehicles
      );
      return result;
    } catch (e) {
      print('error paginate MaintenanceQuery ${e.toString()}');
      throw Exception('Error paginate MaintenanceQuery');
    }
  }

  // select from vehicle
  MaintenanceQuery fromVehicle(Vehicle vehicle) {
    final fromVehicle = vehicle.getMaintenances();
    if(fromVehicle != null) _select = fromVehicle;
    return this;
  }
}

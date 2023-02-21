// ignore_for_file: avoid_print

import 'package:ktcarmaintenanceflutter/src/models/database.dart';
import 'package:ktcarmaintenanceflutter/src/models/vehicles.dart';

// class for query builder vehicle

class VehicleQuery {
  VehicleQuery();
  
  Vehicle query = Vehicle(); // init query with Vehicle model query
  VehicleFilterBuilder _select = Vehicle().select(); // init query builder select vehicle

  // get vehicle by id
  Future<Vehicle?> find(id) async {
    try {
      final vehicle = await query.getById(id);
      return vehicle;
    } catch (e) {
      print('error find VehicleQuery ${e.toString()}');
      throw Exception('Error find VehicleQuery');
    }
  }

  // set select params in filter builder
  VehicleQuery select({
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
  Future<List<Vehicle>> get() async {
    try {
      final result = await _select.toList();
      return result;
    } catch (e) {
      print('error get VehicleQuery ${e.toString()}');
      throw Exception('Error get VehicleQuery');
    }
  }

  // execute query and get data with pagination using select filter
  Future<VehiclePaginate> paginate({
    int page = 1, 
    int perPage = 10
  }) async {
    try {
      final vehicles = await _select.page(page, perPage).toList();
      final totalCount = await _select.toCount();
      final totalPages = (totalCount / perPage).ceil();
      final result = VehiclePaginate(
        page: page,
        perPage: perPage,
        totalCount: totalCount,
        totalPages: totalPages,
        data: vehicles
      );
      return result;
    } catch (e) {
      print('error paginate VehicleQuery ${e.toString()}');
      throw Exception('Error paginate VehicleQuery');
    }
  }
}

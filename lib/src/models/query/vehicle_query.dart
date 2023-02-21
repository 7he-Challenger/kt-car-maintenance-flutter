// ignore_for_file: avoid_print

import 'package:ktcarmaintenanceflutter/src/models/database.dart';
import 'package:ktcarmaintenanceflutter/src/models/vehicles.dart';

// class for query builder vehicle

class VehicleQuery {
  VehicleQuery();

  Vehicle query = Vehicle();
  VehicleFilterBuilder _select = Vehicle().select();

  Future<Vehicle?> find(id) async {
    try {
      final vehicle = await query.getById(id);
      return vehicle;
    } catch (e) {
      print('error find VehicleQuery ${e.toString()}');
      throw Exception('Error find VehicleQuery');
    }
  }

  VehicleQuery select({List<String>? columnsToSelect, bool? getIsDeleted}) {
    _select = query.select(
        columnsToSelect: columnsToSelect, getIsDeleted: getIsDeleted);
    return this;
  }

  Future<List<Vehicle>> get() async {
    try {
      final result = await _select.toList();
      return result;
    } catch (e) {
      print('error get VehicleQuery ${e.toString()}');
      throw Exception('Error get VehicleQuery');
    }
  }

  Future<VehiclePaginate> paginate({int page = 1, int perPage = 10}) async {
    try {
      final vehicles = await _select.page(page, perPage).toList();
      final totalCount = await _select.toCount();
      final totalPages = (totalCount / perPage).ceil();
      final result = VehiclePaginate(
          page: page,
          perPage: perPage,
          totalCount: totalCount,
          totalPages: totalPages,
          data: vehicles);
      return result;
    } catch (e) {
      print('error paginate VehicleQuery ${e.toString()}');
      throw Exception('Error paginate VehicleQuery');
    }
  }
}

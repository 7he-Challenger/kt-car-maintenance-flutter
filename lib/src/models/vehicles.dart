import 'package:ktcarmaintenanceflutter/src/models/database.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

const tableVehicle = SqfEntityTable(
  tableName: 'vehicles',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  modelName: null,
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('brands', DbType.text, isNotNull: false),
    SqfEntityField('matricule', DbType.text, isNotNull: false),
    SqfEntityField('image', DbType.text, isNotNull: false),
  ]
);

class VehiclePaginate {
  VehiclePaginate({
    required this.page,
    required this.perPage,
    required this.totalCount,
    required this.totalPages,
    required this.data 
  });

  int page;
  int perPage;
  int totalCount;
  int totalPages;
  List<Vehicle> data;
}
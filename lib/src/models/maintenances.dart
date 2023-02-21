import 'package:ktcarmaintenanceflutter/src/models/database.dart';
import 'package:ktcarmaintenanceflutter/src/models/vehicles.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

const tableMaintenance = SqfEntityTable(
  tableName: 'maintenances',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  modelName: null,
  fields: [
    SqfEntityField('date', DbType.datetime),
    SqfEntityFieldRelationship(
      parentTable: tableVehicle,
      deleteRule: DeleteRule.CASCADE,
      fieldName: 'idVehicle',
      relationType: RelationType.ONE_TO_MANY
    )
  ]
);

class MaintenancePaginate {
  MaintenancePaginate({
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
  List<Maintenance> data;
}
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ktcarmaintenanceflutter/src/models/maintenances.dart';
import 'package:ktcarmaintenanceflutter/src/models/vehicles.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'database.g.dart';

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'MyVehicle', // optional
  databaseName: 'myvehicle.db',
  password: null,
  databaseTables: [tableVehicle, tableMaintenance],
  // put defined sequences into the sequences list.
  sequences: [],
  bundledDatabasePath: null, // 'assets/sample.db' // This value is optional. When bundledDatabasePath is empty then EntityBase creats a new database when initializing the database
  // This value is optional. When databasePath is null then
  // EntityBase uses the default path from sqflite.getDatabasesPath()
  // If you want to set a physically path just set a directory like: '/Volumes/Repo/MyProject/db',
  databasePath: 'lib/assets/database.db',
);
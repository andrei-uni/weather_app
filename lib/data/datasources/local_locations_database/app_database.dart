import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:weather_app/data/datasources/local_locations_database/tables/location_table.dart';

part '_open_connection.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    LocationTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<LocationTableData> addLocationReturning(LocationTableCompanion locationItem) async {
    return await into(locationTable).insertReturning(locationItem);
  }

  Future<void> changeDefaultLocation(int id) async {
    await transaction(() async {
      final LocationTableData? defaultLocation = await getDefaultLocation();

      if (defaultLocation != null) {
        await (update(locationTable).replace(
          defaultLocation.copyWith(
            isDefault: false,
          ),
        ));
      }

      await (update(locationTable)..where((location) => location.id.equals(id))).write(
        const LocationTableCompanion(
          isDefault: Value(true),
        ),
      );
    });
  }

  Future<List<LocationTableData>> getAllLocations() async {
    return await select(locationTable).get();
  }

  Future<LocationTableData?> getDefaultLocation() async {
    return await (select(locationTable)
          ..where((location) => location.isDefault)
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> deleteLocation(int id) async {
    await (delete(locationTable)..where((location) => location.id.equals(id))).go();
  }

  Future<void> deleteAllData() async {
    await transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}

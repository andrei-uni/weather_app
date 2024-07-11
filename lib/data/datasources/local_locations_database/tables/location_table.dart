import 'package:drift/drift.dart';

class LocationTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  BoolColumn get isDefault => boolean()();
}

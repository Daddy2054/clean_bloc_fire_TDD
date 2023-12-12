import 'package:hive/hive.dart';

class LocalDataSource<T> {
  final String boxName;
  final Type boxType;

  LocalDataSource({
    required this.boxName,
    required this.boxType,
  });

  Future<Box> openBox() async {
    return Hive.openBox<T>(boxName);
  }

  Future<void> addOne(
    T value,
    dynamic Function(T) getId,
  ) async {
    final box = await openBox();
    await box.put(getId(value), value);
  }

  Future<void> addAll(
    List<T> values,
    dynamic Function(T) getId,
  ) async {
    final box = await openBox();
    for (final value in values) {
      await box.put(getId(value), value);
    }
  }

  Future<T?> getOne(String id) async {
    final box = await openBox();
    return box.get(id) as T?;
  }

  Future<List<T>> getAll() async {
    final box = await openBox();
    return box.values.toList().cast<T>();
  }

  Stream<T?> streamOne(String id) async* {
    final box = await openBox();

    // Emit the current value
    yield box.get(id) as T?;

    // Emit new values when changes occur
    yield* box.watch(key: id).map((boxEvent) => boxEvent.value as T?);
  }

  Stream<List<T>> streamAll() async* {
    final box = await openBox();
    // Emit the current value
    yield box.values.toList().cast<T>();

    // Emit new values when changes occur
    yield* box.watch().map((boxEvent) => box.values.toList().cast<T>());
  }
}

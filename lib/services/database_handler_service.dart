import 'dart:io';

import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DatabaseHandlerService implements DatabaseService {
  final DatabaseService _localDatabaseService = LocalDatabaseService();

  @override
  Future<MindMap> loadMindMap(String mindMapUuid) async {
    return await _localDatabaseService.loadMindMap(mindMapUuid);
  }

  @override
  Future<List<MindMap>> loadMindMaps() async {
    return await _localDatabaseService.loadMindMaps();
  }

  @override
  Future<void> saveMindMap(MindMap mindMap) async {
    await _localDatabaseService.saveMindMap(mindMap);
  }

  @override
  Future<void> saveMindMaps(List<MindMap> mindMaps) async {
    await _localDatabaseService.saveMindMaps(mindMaps);
  }
}

/// The database service. This class should be implemented in a local and in a
/// public version. All mind map's are stored by their uuid.
sealed class DatabaseService {
  /// Load all mind maps from the database
  Future<List<MindMap>> loadMindMaps();

  /// Load a single mind map from the database
  Future<MindMap> loadMindMap(String mindMapUuid);

  /// Save all mind maps to the database
  Future<void> saveMindMaps(List<MindMap> mindMaps);

  /// Save a single mind map to the database
  Future<void> saveMindMap(MindMap mindMap);
}

class LocalDatabaseService implements DatabaseService {
  /// Loads a single mind map by it's uuid from the local database. Optionally
  /// it can be the application documents directory specified. This is useful, when
  /// loading multiple mind maps at once.
  @override
  Future<MindMap> loadMindMap(
    String mindMapUuid, {
    Directory? applicationDocumentsDirectory,
  }) async {
    final appDocDir = applicationDocumentsDirectory ??
        await _getApplicationDocumentsDirectory();

    // Create the data file
    File dataFile = File(path.join(appDocDir.path, mindMapUuid, 'data.json'));

    if (!dataFile.existsSync()) {
      throw MindMapDoesNotExistException(mindMapUuid: mindMapUuid);
    }

    // Read and parse the data
    String data = await dataFile.readAsString();
    return MindMap.fromJson(data);
  }

  /// Loads all mind maps from the local database.
  @override
  Future<List<MindMap>> loadMindMaps() async {
    final appDocDir = await _getApplicationDocumentsDirectory();

    // Get all mind map uuids
    final List<String?> mindMapUuids = appDocDir.listSync().map(
      (e) {
        if (e is Directory) {
          return path.basename(e.path);
        } else {
          return null;
        }
      },
    ).toList();

    List<MindMap> mindMaps = [];

    // Load all mind maps
    for (String? mindMapUuid in mindMapUuids) {
      if (mindMapUuid != null) {
        mindMaps.add(
          await loadMindMap(
            mindMapUuid,
            applicationDocumentsDirectory: appDocDir,
          ),
        );
      }
    }

    return mindMaps;
  }

  /// Saves a single mind map to the local database. Optionally it can be the
  /// application documents directory specified. This is useful, when saving
  /// multiple mind maps at once.
  @override
  Future<void> saveMindMap(
    MindMap mindMap, {
    Directory? applicationDocumentsDirectory,
  }) async {
    final appDocDir = applicationDocumentsDirectory ??
        await _getApplicationDocumentsDirectory();

    // Create the data file
    File dataFile = File(path.join(appDocDir.path, mindMap.uuid, 'data.json'));
    await _checkDirectoryOrFile(dataFile);

    // Write the data
    await dataFile.writeAsString(mindMap.toJson());
  }

  /// Saves all mind maps to the local database.
  @override
  Future<void> saveMindMaps(List<MindMap> mindMaps) async {
    final appDocDir = await _getApplicationDocumentsDirectory();

    for (MindMap mindMap in mindMaps) {
      await saveMindMap(mindMap, applicationDocumentsDirectory: appDocDir);
    }
  }

  /// Get the application documents directory, then checks if it exists. If not
  /// it creates it recursively.
  Future<Directory> _getApplicationDocumentsDirectory() async {
    final appDocDir = Directory(path.join(
        (await getApplicationDocumentsDirectory()).path, 'Open Mind'));
    await _checkDirectoryOrFile(appDocDir);

    return appDocDir;
  }

  /// Check if the provided directory exists. If not, create it recursively, if
  /// not disabled via the [recursive] parameter. It will return the directory
  /// wich was checked.
  Future<T> _checkDirectoryOrFile<T>(
    T directoryOrFile, {
    bool recursive = true,
  }) async {
    switch (T) {
      case Directory:
        if (!(await (directoryOrFile as Directory).exists())) {
          await (directoryOrFile as Directory).create(
            recursive: recursive,
          );
        }
      case File:
        if (!(await (directoryOrFile as File).exists())) {
          await (directoryOrFile as File).create(
            recursive: recursive,
          );
        }
      default:
        throw UnimplementedError();
    }

    return directoryOrFile;
  }
}

class MindMapDoesNotExistException implements Exception {
  final String mindMapUuid;

  const MindMapDoesNotExistException({required this.mindMapUuid});

  @override
  String toString() {
    return 'The mind map with the uuid $mindMapUuid does not exist.';
  }
}

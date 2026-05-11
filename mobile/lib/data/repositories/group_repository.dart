import 'package:uuid/uuid.dart';
import '../models/password_group.dart';

class GroupRepository {
  final List<PasswordGroup> _groups = [];
  final _uuid = const Uuid();

  Future<List<PasswordGroup>> getGroups() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_groups);
  }

  Future<PasswordGroup?> getGroupById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      return _groups.firstWhere((g) => g.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<PasswordGroup> createGroup(String name) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final group = PasswordGroup(
      id: _uuid.v4(),
      name: name,
    );
    _groups.add(group);
    return group;
  }

  Future<PasswordGroup> updateGroup(String id, String name) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _groups.indexWhere((g) => g.id == id);
    if (index == -1) {
      throw Exception('Group not found');
    }
    final updatedGroup = _groups[index].copyWith(
      name: name,
      updatedAt: DateTime.now(),
    );
    _groups[index] = updatedGroup;
    return updatedGroup;
  }

  Future<void> deleteGroup(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _groups.removeWhere((g) => g.id == id);
  }

  Future<void> updateGroupItemCount(String id, int count) async {
    final index = _groups.indexWhere((g) => g.id == id);
    if (index != -1) {
      _groups[index] = _groups[index].copyWith(itemCount: count);
    }
  }
}

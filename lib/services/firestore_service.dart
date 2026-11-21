import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo.dart';

class FirestoreService {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo(String taskName) async {
    final newTodo = Todo(
      id: '',
      task: taskName,
      isDone: false,
      createdAt: null,
    );
    await _todosCollection.add(newTodo.toMap());
  }

  // Mmembaca atau mengambil tugas dari Firestore
  Stream<List<Todo>> getTodos() {
    return _todosCollection
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => 
      snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList());
  }

  // Update status Todo
  Future<void> updateTodoStatus(String id, bool currentStatus) async {
    await _todosCollection.doc(id).update({'isDone': !currentStatus});
  }

  // Delete Tugas atau Todo
  Future <void> deleteTodo(String id) async {
    await _todosCollection.doc(id).delete();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class NoteRepository {
  final CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('notes');

  // Fetch notes from Firestore
  Stream<List<Note>> getNotes() {
    return notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Note.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Add a new note to Firestore
  Future<void> addNote(Note note) async {
    await notesCollection.add(note.toMap());
  }

  // Delete a note from Firestore
  Future<void> deleteNote(String noteId) async {
    await notesCollection.doc(noteId).delete();
  }

  // Update an existing note in Firestore
  Future<void> updateNote(Note note) async {
    await notesCollection.doc(note.id).update(note.toMap());
  }
}

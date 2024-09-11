import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/note_model.dart';
import '../../data/repositories/note_repository.dart';

class HomeScreen extends StatelessWidget {
  final NoteRepository noteRepository = NoteRepository(); // Create an instance of NoteRepository

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((_) {
                context.go('/login'); // Navigate to Login Screen after logout
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Note>>(
        stream: noteRepository.getNotes(),  // Fetch notes using Firestore stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notes available'));
          }
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    noteRepository.deleteNote(note.id);  // Delete note functionality
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add_note'); // Navigate to Add Notes Screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

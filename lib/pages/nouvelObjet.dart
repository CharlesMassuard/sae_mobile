import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/pages/widget/informationPopup.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NouvelObjet extends StatefulWidget {
  const NouvelObjet({Key? key}) : super(key: key);

  @override
  _NouvelObjetState createState() => _NouvelObjetState();
}

class _NouvelObjetState extends State<NouvelObjet> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final db = await getDatabase();
        await db.insert(
          'MesObjets',
          {
            'nomObjet': _title,
            'descriptionObjet': _description,
          },
        );
        // Navigate back to the previous page or show a success message
      } catch (e) {
        // Handle the exception. You might want to show an error message to the user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un objet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "Nom de l'objet"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  suffixIcon: InfoButton(infoText: 'Veuillez entrer une description de votre objet'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/mesObjets'),
                    child: const Text("Annuler"),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text("Créer l'objet"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
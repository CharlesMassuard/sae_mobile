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
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE MesObjets(id INTEGER PRIMARY KEY, nomObjet TEXT, descriptionObjet TEXT)",
        );
      },
    );
  }

  void _submitForm(BuildContext context) async {
    print('Submit form called');
    if (_formKey.currentState!.validate()) {
      print('Form is valid');
      _formKey.currentState!.save();
      print('Form saved');
      try {
        final db = await getDatabase();
        print('Database opened');
        await db.insert('MesObjets', {
          'nomObjet': _title,
          'descriptionObjet': _description,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Objet ajouté avec succès!')),
        );
        context.go('/mesObjets');
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'ajout: $e')),
        );
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
                    onPressed: () => _submitForm(context),
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
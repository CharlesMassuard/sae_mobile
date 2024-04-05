import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sae_mobile/pages/widget/informationPopup.dart';
import 'package:sae_mobile/utils/supabaseService.dart';

class NouvelleAnnonce extends StatefulWidget {
  const NouvelleAnnonce({Key? key}) : super(key: key);

  @override
  _NouvelleAnnonceState createState() => _NouvelleAnnonceState();
}

class _NouvelleAnnonceState extends State<NouvelleAnnonce> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  final SupabaseService _supabaseService = SupabaseService();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _supabaseService.insertAnnouncement(_title, _description);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Annonce publiée avec succès!')),
        );
        context.go('/');
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la publication: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer une annonce'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "Titre de l'annonce"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
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
                  suffixIcon: InfoButton(infoText: 'Veillez entrer ce que vous recherchez et expliquer brièvement votre besoin'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veillez entrer une description';
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
                    onPressed: () => context.go('/'),
                    child: const Text('Annuler'),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Poster l\'annonce'),
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
import 'package:flutter/material.dart';

class Commentaire {
  final String utilisateur;
  final String texte;
  final DateTime date;
  final String imageUrl; // Ajout de l'URL de l'image utilisateur

  Commentaire({
    required this.utilisateur,
    required this.texte,
    required this.date,
    this.imageUrl = '', // Valeur par défaut pour l'image utilisateur
  });
}

class ListeCommentairesWidget extends StatefulWidget {
  final List<Commentaire> commentaires;

  const ListeCommentairesWidget({super.key, required this.commentaires});

  @override
  _ListeCommentairesWidgetState createState() =>
      _ListeCommentairesWidgetState();
}

class _ListeCommentairesWidgetState extends State<ListeCommentairesWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.commentaires.length,
            itemBuilder: (context, index) {
              Commentaire commentaire = widget.commentaires[index];
              return ListTile(
                leading: commentaire.imageUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(commentaire.imageUrl),
                      )
                    : const Icon(
                        Icons.person), // icône par défaut si pas d'image

                subtitle: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(commentaire.utilisateur),
                      const SizedBox(height: 5),
                      Text(commentaire.texte),
                      const SizedBox(height: 5),
                      Text(
                        'Date: ${commentaire.date}',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Ajouter un commentaire...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Ajouter un nouveau commentaire
                  setState(() {
                    widget.commentaires.insert(
                      0,
                      Commentaire(
                        utilisateur: 'Utilisateur3', // Nom d'utilisateur fictif
                        texte: _controller.text,
                        date: DateTime.now(),
                      ),
                    );
                    _controller.clear();
                  });
                },
                child: const Text('Envoyer'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CommentairesPage extends StatelessWidget {
  final List<Commentaire> listeCommentaires = [
    Commentaire(
      utilisateur: 'Utilisateur1',
      texte: 'Premier commentaire',
      date: DateTime.now(),
      imageUrl: 'https://example.com/user1.jpg', // URL de l'image utilisateur
    ),
    Commentaire(
      utilisateur: 'Utilisateur2',
      texte: 'Deuxième commentaire',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Commentaire(
      utilisateur: 'Utilisateur2',
      texte: 'Deuxième commentaire',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Commentaire(
      utilisateur: 'Utilisateur2',
      texte: 'Deuxième commentaire',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Commentaire(
      utilisateur: 'Utilisateur2',
      texte: 'Deuxième commentaire',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Commentaire(
      utilisateur: 'Utilisateur2',
      texte: 'Deuxième commentaire',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Commentaire(
      utilisateur: 'Utilisateur2',
      texte: 'Deuxième commentaire',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Commentaire(
      utilisateur: 'Utilisateur2',
      texte: 'Deuxième commentaire',
      date: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    // Ajoutez d'autres commentaires ici si nécessaire
  ];

  CommentairesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des commentaires'),
      ),
      body: ListeCommentairesWidget(
        commentaires: listeCommentaires,
      ),
    );
  }
}

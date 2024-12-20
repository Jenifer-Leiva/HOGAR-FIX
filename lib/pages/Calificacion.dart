import 'package:flutter/material.dart';


class Calificacion extends StatefulWidget {
  const Calificacion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<Calificacion> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  void _submitRating() {
  final comment = _commentController.text;

  print("Calificación: $_rating");
  print("Comentario: $comment");

  // Aquí puedes agregar lógica para enviar la calificación al backend.

  // Redirigir al historial del cliente
  Navigator.pushNamed(context, '/historialcliente');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildProfileSection(),
            const SizedBox(height: 20),
            _buildRatingStars(),
            const SizedBox(height: 20),
            _buildCommentBox(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          'Tu servicio ha sido completado con éxito',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: Colors.orange),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '¡Califica el perfil del contratista!',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: Colors.orange),
            ),
          ],
        ),
        SizedBox(height: 20),
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 80,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: index < _rating ? Colors.orange : Colors.grey,
            size: 36,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildCommentBox() {
    return TextField(
      controller: _commentController,
      maxLines: 4,
      decoration: const InputDecoration(
        hintText: 'Deja un comentario (opcional)',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitRating,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Enviar calificación',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
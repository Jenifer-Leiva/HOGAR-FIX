import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  // Enviar mensaje y simular respuesta
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(isSentByMe: true, message: _controller.text));

        // Simular respuesta después de enviar el mensaje
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _messages.add(const ChatMessage(isSentByMe: false, message: "Respuesta automática"));
          });
        });
        _controller.clear(); // Limpiar el campo de texto después de enviar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.orange),
            ),
            SizedBox(width: 10),
            Text("Cliente"),
          ],
        ),
        actions: [
          
          IconButton(
            icon: const Icon(Icons.phone,color: Colors.black ),
            onPressed: () {
              //Accion para llamar
            },
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [

          // Mensajes
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),

          // Barra de entrada
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                // Icono de imagen
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    // Acción para seleccionar imagen
                  },
                ),

                // Campo de texto para escribir mensaje
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Escribe un mensaje...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                  ),
                ),
                
                // Icono de micrófono
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // Acción para grabar mensaje de voz
                  },
                ),

                // Botón para enviar mensaje
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage, // Enviar el mensaje
                ),
              ],
            ),
          ),

          // Flecha hacia atrás para regresar
          Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Navegar hacia atrás
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final bool isSentByMe;
  final String message;

  const ChatMessage({super.key, required this.isSentByMe, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.orange : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: Chat()));
}
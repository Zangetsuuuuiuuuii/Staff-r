import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  final bool isClient;
  final String participantName;

  const ChatPage({
    super.key,
    required this.isClient,
    required this.participantName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> messages = [];

  double _proposedPrice = 300;
  bool _clientHandshake = false;
  bool _proHandshake = false;

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.insert(0, text);
        _messageController.clear();
      });
    }
  }

  void _toggleHandshake() {
    setState(() {
      if (widget.isClient) {
        _clientHandshake = !_clientHandshake;
      } else {
        _proHandshake = !_proHandshake;
      }
    });
  }

  bool get bothAgreed => _clientHandshake && _proHandshake;

  @override
  Widget build(BuildContext context) {
    final name = widget.participantName;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color(0xFF123458),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 💬 Chat messages
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = index % 2 == 0;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xFF123458)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message,
                      style: GoogleFonts.poppins(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 💵 Price Negotiation Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Proposed Price: ₹${_proposedPrice.toInt()} /hr",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Slider(
                  value: _proposedPrice,
                  min: 100,
                  max: 1000,
                  divisions: 18,
                  label: "₹${_proposedPrice.toInt()}",
                  activeColor: Colors.teal,
                  onChanged: (value) {
                    setState(() => _proposedPrice = value);
                  },
                ),

                // 🤝 Handshake + Propose New (for client)
                Row(
                  children: [
                    // Accept Button
                    ElevatedButton.icon(
                      onPressed: _toggleHandshake,
                      icon: Icon(
                        widget.isClient
                            ? (_clientHandshake
                                ? Icons.check
                                : Icons.pan_tool_alt)
                            : (_proHandshake
                                ? Icons.check
                                : Icons.pan_tool_alt),
                      ),
                      label: Text(widget.isClient
                          ? "Accept ₹550"
                          : "Professional Handshake"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.isClient
                            ? (_clientHandshake
                                ? const Color.fromARGB(255, 246, 246, 246)
                                : const Color(0xFF123458))
                            : (_proHandshake
                                ? const Color.fromARGB(255, 251, 255, 252)
                                : const Color(0xFF123458)),
                        foregroundColor: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Propose New Button
                    if (widget.isClient)
                      OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "You proposed ₹${_proposedPrice.toInt()} /hr to the professional.",
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.teal),
                        ),
                        child: const Text("Propose New"),
                      ),

                    const SizedBox(width: 12),

                    // Confirmation Text
                    if (bothAgreed)
                      const Text(
                        "✔ Booking Confirmed!",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                  ],
                )
              ],
            ),
          ),

          // 📩 Message Input Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF123458)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
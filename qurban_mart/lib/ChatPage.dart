import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final Map<String, dynamic> animal;

  const ChatPage({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF9F8F4,
      ), // Warna krem muda khas chat Whatsapp/desain Figma
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: const AssetImage(
                  'Asset/image/Sapi.png',
                ), // Gambar Peternakan
                backgroundColor: Colors.grey.shade200,
                radius: 20,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Peternakan Berkah',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.black),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildChatBubble(
                  message: 'Assalamualaikum, apakah sapi ini masih tersedia?',
                  time: '09:12',
                  isMe: true,
                ),
                _buildChatBubble(
                  message: 'Waalaikumsalam, masih tersedia ya kak. Bisa saya kirim video terbarunya.',
                  time: '09:14',
                  isMe: false,
                ),
                _buildVideoBubble(
                  imagePath: 'Asset/image/Sapi.png', // Fallback image jika video tidak ada
                  duration: '0:45',
                  time: '09:15',
                ),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // --- KOMPONEN BUBBLE CHAT TEXT ---
  Widget _buildChatBubble({
    required String message,
    required String time,
    required bool isMe,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFFD3EADD)
              : Colors.white, // Hijau pudar untuk user, putih untuk penjual
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe
                ? const Radius.circular(16)
                : const Radius.circular(4),
            bottomRight: isMe
                ? const Radius.circular(4)
                : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                time,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- KOMPONEN BUBBLE CHAT VIDEO ---
  Widget _buildVideoBubble({
    required String imagePath,
    required String duration,
    required String time,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    width: 250,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                  // Ikon Play
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  // Durasi
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 6, top: 4),
              child: Text(
                time,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- KOMPONEN INPUT BAWAH ---
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Colors.grey.shade600,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Ketik pesan...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey.shade600,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey.shade600,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}

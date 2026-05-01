import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class FloScreen extends StatefulWidget {
  const FloScreen({super.key});

  @override
  State<FloScreen> createState() => _FloScreenState();
}

class _FloScreenState extends State<FloScreen> {
  String _selectedChannel = 'general';
  final TextEditingController _messageController = TextEditingController();
  
  final Map<String, List<Message>> _messages = {
    'general': [
      Message(sender: 'Dispatch', text: 'Morning team, 3 priority calls today', time: '8:42 AM'),
      Message(sender: 'You', text: 'Got it, heading to First National now', time: '8:45 AM'),
    ],
    'dispatch': [
      Message(sender: 'Sarah (Dispatch)', text: 'Can you pick up currency counter from warehouse?', time: '9:15 AM'),
    ],
    'regional': [
      Message(sender: 'Mike (FT)', text: 'Anyone have spare canister keys?', time: '10:20 AM'),
    ],
  };

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages[_selectedChannel]?.add(
        Message(
          sender: 'You',
          text: _messageController.text,
          time: TimeOfDay.now().format(context),
        ),
      );
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      body: Row(
        children: [
          // Channel List
          Container(
            width: 260,
            color: isDark ? ThemeProvider.darkSidebar : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'FLO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                    ),
                  ),
                ),
                _buildChannelItem('general', 'General', LucideIcons.hash, isDark),
                _buildChannelItem('dispatch', 'Dispatch', LucideIcons.radio, isDark),
                _buildChannelItem('regional', 'Regional Techs', LucideIcons.users, isDark),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'DIRECT MESSAGES',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                    ),
                  ),
                ),
                _buildDMItem('Sarah Miller', true, isDark),
                _buildDMItem('Mike Johnson', false, isDark),
              ],
            ),
          ),
          
          // Chat Panel
          Expanded(
            child: Column(
              children: [
                // Header
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: isDark ? ThemeProvider.darkSidebar : Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.hash,
                        size: 20,
                        color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedChannel,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(LucideIcons.video, size: 20),
                        onPressed: () {
                          // Video call
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Starting video call...')),
                          );
                        },
                        color: ThemeProvider.fscBlue,
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(LucideIcons.phone, size: 20),
                        onPressed: () {
                          // Audio call
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Starting audio call...')),
                          );
                        },
                        color: ThemeProvider.fscBlue,
                      ),
                    ],
                  ),
                ),
                
                // Messages
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: _messages[_selectedChannel]?.length ?? 0,
                    itemBuilder: (context, index) {
                      final msg = _messages[_selectedChannel]![index];
                      return _buildMessage(msg, isDark);
                    },
                  ),
                ),
                
                // Message Input
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? ThemeProvider.darkSidebar : Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                            ),
                            filled: true,
                            fillColor: isDark ? ThemeProvider.darkBackground : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          style: TextStyle(
                            color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _sendMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeProvider.fscBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelItem(String id, String name, IconData icon, bool isDark) {
    final isSelected = _selectedChannel == id;
    return InkWell(
      onTap: () => setState(() => _selectedChannel = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        color: isSelected ? ThemeProvider.fscBlue : Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : (isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary),
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.white : (isDark ? ThemeProvider.darkText : ThemeProvider.lightText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDMItem(String name, bool online, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                ),
              ),
              if (online)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Message msg, bool isDark) {
    final isMe = msg.sender == 'You';
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 18,
              backgroundColor: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
              child: Icon(
                Icons.person,
                size: 18,
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isMe)
                      Text(
                        msg.sender,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      msg.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? ThemeProvider.fscBlue : (isDark ? ThemeProvider.darkSidebar : Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: isMe ? Colors.white : (isDark ? ThemeProvider.darkText : ThemeProvider.lightText),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final String time;

  Message({required this.sender, required this.text, required this.time});
}

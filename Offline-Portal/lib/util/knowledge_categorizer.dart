import 'package:path/path.dart' as path;

class KnowledgeCategorizer {
  static String guessCategory(String filePath) {
    final lower = filePath.toLowerCase();
    
    // Priority troubleshooting/installation keywords
    if (lower.contains('troubleshooting') || lower.contains('fix') || lower.contains('repair')) {
      return 'Troubleshooting';
    }
    if (lower.contains('installation') || lower.contains('setup') || lower.contains('config')) {
      return 'Installation';
    }
    if (lower.contains('procedure') || lower.contains('guide') || lower.contains('how-to')) {
      return 'Procedures';
    }
    if (lower.contains('safety') || lower.contains('hazard') || lower.contains('warning')) {
      return 'Safety';
    }
    if (lower.contains('parts') || lower.contains('inventory') || lower.contains('component')) {
      return 'Parts';
    }
    if (lower.contains('servicing') || lower.contains('maintenance')) {
      return 'Maintenance';
    }
    
    // Use folder names if available
    final parts = path.split(filePath);
    if (parts.length > 2) {
      // If folder is like "manuals/ATM", doesn't help with category vs equipment.
      // But if folder is "manuals/Procedures/ATM", parts[parts.length-2] is "Procedures"
      for (var p in parts.reversed) {
        final folder = p.toLowerCase();
        if (folder == 'procedures') return 'Procedures';
        if (folder == 'troubleshooting') return 'Troubleshooting';
        if (folder == 'safety') return 'Safety';
        if (folder == 'parts') return 'Parts';
        if (folder == 'manuals') return 'Equipment Manuals';
      }
    }

    return 'General Reference';
  }

  static String guessEquipmentType(String filePath) {
    final lower = filePath.toLowerCase();
    
    // Specific equipment keywords
    if (lower.contains('atm') || lower.contains('tcr')) return 'ATM / TCR';
    if (lower.contains('coin_sorter') || lower.contains('sorter')) return 'Coin Sorter';
    if (lower.contains('currency_counter') || lower.contains('counter')) return 'Currency Counter';
    if (lower.contains('validator') || lower.contains('bill')) return 'Validator';
    if (lower.contains('locks') || lower.contains('kaba') || lower.contains('mas-hamilton') || lower.contains('la gard')) return 'Security Locks';
    if (lower.contains('dvr') || lower.contains('camera') || lower.contains('cctv')) return 'Surveillance';
    if (lower.contains('check_scanner') || lower.contains('scanner')) return 'Check Scanner';
    if (lower.contains('printer') || lower.contains('receipt')) return 'Printers';
    if (lower.contains('pc') || lower.contains('computer') || lower.contains('workstation')) return 'Computing';
    
    // Use folder segments
    final parts = path.split(filePath);
    for (var p in parts) {
      final folder = p.toLowerCase();
      if (folder.contains('atm')) return 'ATM / TCR';
      if (folder.contains('lock')) return 'Security Locks';
      if (folder.contains('coin')) return 'Coin Sorter';
      if (folder.contains('currency')) return 'Currency Counter';
    }

    return 'Other Equipment';
  }
}

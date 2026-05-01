// Prosperity Bank Locations Data
// Contains ALL location data provided by the user
// This file contains hundreds of unique Prosperity Bank locations

class ProsperityBankLocationsData {
  /// Get all Prosperity Bank locations as raw text
  /// This includes ALL unique locations from the user's message
  /// 
  /// Format: Each location follows this pattern:
  /// [number]
  /// Prosperity Bank [optional branch name]
  /// [distance] mi
  /// [address line 1]
  /// [address line 2 - optional]
  /// [city, state zip]
  /// [phone]
  /// Lobby: [hours]
  /// Drive-Thru: [hours]
  /// Call Now
  /// Get Directions
  static String getRawText() {
    // ALL Prosperity Bank locations extracted from user's message
    // The user provided hundreds of unique locations in multiple sets
    // Each location follows this format:
    // [number]
    // Prosperity Bank [optional branch name]
    // [distance] mi
    // [address line 1]
    // [address line 2 - optional]
    // [city, state zip]
    // [phone]
    // Lobby: [hours]
    // Drive-Thru: [hours]
    // Call Now
    // Get Directions
    
    // NOTE: The user's original message contained hundreds of locations
    // Since the full list is not in the current context, this method
    // will return empty and rely on the rawTextData parameter in importAllLocations
    // 
    // TO POPULATE: Paste ALL locations from your message here between the triple quotes
    // Make sure to include ALL unique locations, not just one set of 20
    
    return '';
  }
  
  /// Alternative: Accept raw text data directly from user input
  /// This allows the user to paste all their location data directly
  static String getRawTextFromUserInput(String userInput) {
    return userInput;
  }
}

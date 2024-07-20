// utils/tag_emoji_utils.dart

class TagEmojiUtils {
  static Map<int, String> tagToEmojiMap = {
    32: "🚴",  // Bicycling
    33: "🏋️", // Conditioning Exercise
    34: "💃", // Dancing
    35: "🏠", // Home Activities
    36: "🌿", // Lawn & Garden
    37: "🏃", // Running
    38: "🏀", // Sports
    39: "🚶", // Walking
    40: "🏊", // Water Activities
    41: "⛷️", // Winter Activities
    // Add more mappings as needed
  };

  static String getEmojiForTag(int? tagID) {
    return tagToEmojiMap[tagID] ?? "🎽"; // Default emoji if not found
  }
}

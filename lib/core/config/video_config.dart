class VideoConfig {
  static const String databaseVideoUrl = "https://www.youtube.com/watch?v=EkGGsT2v1Z0";
  static const String flutterVideoUrl = "https://www.youtube.com/watch?v=VlxpNPyVdxc";
  static const String webVideoUrl = "https://www.youtube.com/watch?v=t6lDFEFbnhw";
  static const String softwareEngineeringVideoUrl = "https://www.youtube.com/watch?v=JwCeoLGg6-U";
  static const String networksVideoUrl = "https://www.youtube.com/watch?v=61kRxdZ5p-o";
  static const String operatingSystemsVideoUrl = "https://www.youtube.com/watch?v=_WWp1r56Bc4";
  static const String dataStructuresVideoUrl = "https://www.youtube.com/watch?v=PB9qL1UaTIE";

  /// Helper to extract video ID from YouTube URL
  static String extractVideoId(String url) {
    if (url.contains('v=')) {
      final parts = url.split('v=');
      if (parts.length > 1) {
        final idPart = parts[1].split('&').first;
        return idPart;
      }
    } else if (url.contains('youtu.be/')) {
      final parts = url.split('youtu.be/');
      if (parts.length > 1) {
        final idPart = parts[1].split('?').first;
        return idPart;
      }
    }
    return url; // fallback to return the string itself if parsing fails
  }
}

import '../database/app_database.dart';
import '../util/log.dart';

class EvaResponse {
  final String text;
  final List<KnowledgeEntry> sources;

  EvaResponse(this.text, {this.sources = const []});
}

class EvaService {
  final AppDatabase _db;

  EvaService(this._db);

  /// Process a user query and return a structured response
  Future<EvaResponse> processQuery(String query) async {
    Log.info('EVA: Processing query: "$query"');

    // Handle greetings
    if (_isGreeting(query)) {
      return EvaResponse(
        "Hello! I'm EVA, your Embedded Intelligence Assistant. I can help you find information from the knowledge base. "
        "Ask me about equipment manuals, safety procedures, troubleshooting guides, or any topic in our knowledge base.",
      );
    }

    // Handle IT support requests
    if (_isITSupportRequest(query)) {
      return EvaResponse(
        "For IT support, please contact:\n\n"
        "**Joseph White**\n"
        "Email: Joseph.white@fincialsystemscorp.com\n"
        "Phone: (210) 937-2876\n\n"
        "I can also help you search the knowledge base for IT-related procedures or troubleshooting guides.",
      );
    }

    // 1. Search knowledge base using FTS5 (with fallback to basic search)
    List<KnowledgeEntry> entries;
    try {
      final ftsResults = await _db.searchKnowledgeFTS5(query, limit: 10);
      entries = ftsResults.map((r) => r.entry).toList();
    } catch (e) {
      Log.info('EVA: FTS5 search failed, falling back to basic: $e');
      entries = await _db.searchKnowledge(query);
    }

    if (entries.isEmpty) {
      return EvaResponse(
        "I couldn't find any documents matching '$query' in the knowledge base. "
        "Try searching for specific equipment models, procedures, or topics. "
        "You can also browse categories in the Knowledge section.",
      );
    }

    // 2. Extract and synthesize content from top results
    final topResults = entries.take(5).toList();
    final synthesizedAnswer = _synthesizeAnswer(query, topResults);

    // 3. Return synthesized answer with sources
    return EvaResponse(
      synthesizedAnswer,
      sources: topResults.take(3).toList(),
    );
  }

  /// Check if query is a greeting
  bool _isGreeting(String query) {
    final lower = query.toLowerCase().trim();
    return lower.contains('hello') ||
        lower.contains('hi') ||
        lower.contains('hey') ||
        lower == 'eva' ||
        lower.startsWith('what can you');
  }

  /// Check if query is an IT support request
  bool _isITSupportRequest(String query) {
    final lower = query.toLowerCase().trim();
    return lower.contains('it support') ||
        lower.contains('contact it') ||
        lower.contains('it help') ||
        lower.contains('technical support') ||
        lower.contains('tech support') ||
        lower.contains('i need it') ||
        lower.contains('it department') ||
        (lower.contains('support') &&
            (lower.contains('need') || lower.contains('help')));
  }

  /// Synthesize an answer from multiple knowledge entries
  String _synthesizeAnswer(String query, List<KnowledgeEntry> entries) {
    if (entries.isEmpty) return '';

    final buffer = StringBuffer();

    // If single result, provide direct answer
    if (entries.length == 1) {
      final entry = entries.first;
      buffer.writeln('Based on **${entry.title}** (${entry.category}):\n');
      buffer.writeln(_extractRelevantContent(entry.content, query));
      return buffer.toString();
    }

    // Multiple results - synthesize
    buffer.writeln(
        'I found ${entries.length} relevant documents. Here\'s what I found:\n');

    for (var i = 0; i < entries.length && i < 3; i++) {
      final entry = entries[i];
      buffer.writeln('**${entry.title}** (${entry.category}):');
      buffer.writeln(_extractRelevantContent(entry.content, query));
      if (i < entries.length - 1 && i < 2) {
        buffer.writeln('\n---\n');
      }
    }

    if (entries.length > 3) {
      buffer
          .writeln('\n*...and ${entries.length - 3} more matching documents.*');
    }

    return buffer.toString();
  }

  /// Extract relevant content from markdown body
  /// Tries to find sections containing query keywords, otherwise returns first meaningful chunk
  String _extractRelevantContent(String markdown, String query) {
    if (markdown.isEmpty) return 'No content available.';

    final queryWords =
        query.toLowerCase().split(' ').where((w) => w.length > 2).toList();

    // Try to find a section containing query keywords
    final lines = markdown.split('\n');
    int bestStart = 0;
    int bestScore = 0;

    // Score each potential starting point
    for (int i = 0; i < lines.length; i++) {
      int score = 0;
      final lineLower = lines[i].toLowerCase();

      for (final word in queryWords) {
        if (lineLower.contains(word)) {
          score += 2; // Higher weight for title/header matches
        }
      }

      // Check next few lines too
      for (int j = i + 1; j < lines.length && j < i + 5; j++) {
        final nextLineLower = lines[j].toLowerCase();
        for (final word in queryWords) {
          if (nextLineLower.contains(word)) {
            score += 1;
          }
        }
      }

      if (score > bestScore) {
        bestScore = score;
        bestStart = i;
      }
    }

    // Extract content starting from best match
    final startIndex = bestScore > 0 ? bestStart : 0;
    final relevantLines =
        lines.skip(startIndex).take(20).toList(); // ~20 lines max
    var content = relevantLines.join('\n').trim();

    // Clean up markdown headers if we're starting mid-document
    if (startIndex > 0 && content.startsWith('#')) {
      // Remove leading headers
      content = content
          .split('\n')
          .skipWhile((line) => line.trim().startsWith('#'))
          .join('\n');
    }

    // Limit length and add ellipsis if truncated
    const maxLength = 800;
    if (content.length > maxLength) {
      // Try to cut at sentence boundary
      final truncated = content.substring(0, maxLength);
      final lastPeriod = truncated.lastIndexOf('.');
      final lastNewline = truncated.lastIndexOf('\n');
      final cutPoint = lastPeriod > lastNewline ? lastPeriod + 1 : maxLength;
      content = '${content.substring(0, cutPoint).trim()}...';
    }

    return content.isEmpty
        ? '${markdown.substring(0, markdown.length > 500 ? 500 : markdown.length)}...'
        : content;
  }
}

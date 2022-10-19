import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AndroidConversationShortcut {
  static const MethodChannel _channel =
      MethodChannel('android_conversation_shortcut');

  static Future<String?> createConversationShortcut(Person person,
      [bool rounded = true]) async {
    if (person.key == null || person.name == null) {
      throw ArgumentError.notNull('Person key and name must not be null');
    }
    try {
      Uint8List? _iconBytes = person.icon?.data as Uint8List?;

      final String? shortcutID =
          await _channel.invokeMethod('createConversationShortcut', {
        'personName': person.name,
        'personKey': person.key,
        'personIcon':
            _iconBytes != null ? String.fromCharCodes(_iconBytes) : null,
        'personBot': person.bot,
        'personImportant': person.important,
        'personUri': person.uri,
        'roundedIcon': rounded
      });
      return shortcutID;
    } on PlatformException catch (_) {
      return null;
    }
  }
}

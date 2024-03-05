import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'swipeintro_platform_interface.dart';

/// An implementation of [SwipeintroPlatform] that uses method channels.
class MethodChannelSwipeintro extends SwipeintroPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('swipeintro');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'swipeintro_method_channel.dart';

abstract class SwipeintroPlatform extends PlatformInterface {
  /// Constructs a SwipeintroPlatform.
  SwipeintroPlatform() : super(token: _token);

  static final Object _token = Object();

  static SwipeintroPlatform _instance = MethodChannelSwipeintro();

  /// The default instance of [SwipeintroPlatform] to use.
  ///
  /// Defaults to [MethodChannelSwipeintro].
  static SwipeintroPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SwipeintroPlatform] when
  /// they register themselves.
  static set instance(SwipeintroPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

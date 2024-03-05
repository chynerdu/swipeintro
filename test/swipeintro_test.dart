import 'package:flutter_test/flutter_test.dart';
import 'package:swipeintro/swipeintro.dart';
import 'package:swipeintro/swipeintro_platform_interface.dart';
import 'package:swipeintro/swipeintro_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSwipeintroPlatform
    with MockPlatformInterfaceMixin
    implements SwipeintroPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SwipeintroPlatform initialPlatform = SwipeintroPlatform.instance;

  test('$MethodChannelSwipeintro is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSwipeintro>());
  });

  test('getPlatformVersion', () async {
    Swipeintro swipeintroPlugin = Swipeintro();
    MockSwipeintroPlatform fakePlatform = MockSwipeintroPlatform();
    SwipeintroPlatform.instance = fakePlatform;

    expect(await swipeintroPlugin.getPlatformVersion(), '42');
  });
}

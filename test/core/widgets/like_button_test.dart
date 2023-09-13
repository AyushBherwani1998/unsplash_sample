import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unsplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unsplash_sample/core/config/unleash_config.dart';
import 'package:unsplash_sample/core/widgets/like_button.dart';

import '../../service_locator_mock.dart';

void main() {
  group('Like button test', () {
    late final MixpanelConfig mixpanelConfig;
    late final ValueNotifier<bool> isLikedNotifier;

    Widget pumpLikeButton() {
      return MaterialApp(
        home: Scaffold(
          body: LikeButton(
            isLikedNotifier: isLikedNotifier,
            likeButtonPosition: LikeButtonPosition.gridTile,
            photoId: 'id',
          ),
        ),
      );
    }

    setUpAll(() {
      SerivceLocatorMock.initialize();
      mixpanelConfig = SerivceLocatorMock.getIt<MixpanelConfig>();
      isLikedNotifier = ValueNotifier<bool>(false);
    });

    testWidgets('by default state should be unlike', (tester) async {
      await tester.pumpWidget(pumpLikeButton());

      expect(find.byIcon(CupertinoIcons.heart), findsOneWidget);
    });

    testWidgets('like button onTap test', (tester) async {
      await tester.pumpWidget(pumpLikeButton());

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(isLikedNotifier.value, isTrue);
      verify(() => mixpanelConfig.trackLikeEventForExperimentation(
          likeButtonPosition: LikeButtonPosition.gridTile,
          photoId: 'id')).called(1);
    });
  });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/widgets/like_button.dart';

import '../../mock_dependency_injection.dart';

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
      MockDependencyInjection.initialize();
      mixpanelConfig = MockDependencyInjection.getIt<MixpanelConfig>();
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

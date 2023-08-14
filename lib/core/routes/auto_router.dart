import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:unplash_sample/features/home/presentation/pages/home_page.dart';
import 'package:unplash_sample/features/image_details/presentation/pages/image_details_page.dart';

part 'auto_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class UnsplashSampleRouter extends _$UnsplashSampleRouter {

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/'),
        AutoRoute(page: ImageDetailsRoute.page),
      ];
}

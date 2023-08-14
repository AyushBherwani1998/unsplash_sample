// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_router.dart';

abstract class _$UnsplashSampleRouter extends RootStackRouter {
  // ignore: unused_element
  _$UnsplashSampleRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ImageDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ImageDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ImageDetailsPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImageDetailsPage]
class ImageDetailsRoute extends PageRouteInfo<ImageDetailsRouteArgs> {
  ImageDetailsRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
          ImageDetailsRoute.name,
          args: ImageDetailsRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ImageDetailsRoute';

  static const PageInfo<ImageDetailsRouteArgs> page =
      PageInfo<ImageDetailsRouteArgs>(name);
}

class ImageDetailsRouteArgs {
  const ImageDetailsRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'ImageDetailsRouteArgs{key: $key, id: $id}';
  }
}

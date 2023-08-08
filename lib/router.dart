import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './screen/ImgPreview.dart';
import './screen/Camera.dart';
import './screen/Gallery.dart';
import './screen/DetailGallery.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MyCamera();
      }
    ),
    GoRoute(
      path: '/generation',
      builder: (BuildContext context, GoRouterState state) {
        return ImgPreview(state.extra);
      }
    ),
    GoRoute(
      path: '/gallery',
      builder: (BuildContext context, GoRouterState state) {
        return Gallery();
      }
    ),
    GoRoute(
      path: '/detail-gallery',
      builder: (BuildContext context, GoRouterState state) {
        return DetailGallery();
      }
    )
  ]
);
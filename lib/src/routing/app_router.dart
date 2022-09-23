import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';
import '../features/shopping_cart/shopping_cart_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ProductsListScreen(), routes: [
      GoRoute(
        path: 'cart',
        // builder: (context, state) => const ShoppingCartScreen(),
        // We replaced the builder argument with pageBuilder so we can use fullscreenDialog. This control the transition into the new route.
        // with builder, the transition was right to left. With pageBuilder + fullscreenDialog, the transition is bottom-up.
        // This also turns the back button into a close button (<- to X).
        pageBuilder: (context, state) => const MaterialPage(
          child: const ShoppingCartScreen(),
          fullscreenDialog: true,
        ),
      ),
    ]),
  ],
);

import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';
import '../features/shopping_cart/shopping_cart_screen.dart';

enum AppRoute { home, cart, orders, account, signIn, product }

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const ProductsListScreen(),
        name: AppRoute.home.name,
        routes: [
          GoRoute(
            path: 'cart',
            name: AppRoute.cart.name,
            // builder: (context, state) => const ShoppingCartScreen(),
            // We replaced the builder argument with pageBuilder so we can use fullscreenDialog. This control the transition into the new route.
            // with builder, the transition was right to left. With pageBuilder + fullscreenDialog, the transition is bottom-up.
            // This also turns the back button into a close button (<- to X).
            pageBuilder: (context, state) => const MaterialPage(
              child: const ShoppingCartScreen(),
              fullscreenDialog: true,
            ),
          ),
          GoRoute(
            path: 'orders',
            name: AppRoute.orders.name,
            pageBuilder: (context, state) => const MaterialPage(
              child: const OrdersListScreen(),
              fullscreenDialog: true,
            ),
          ),
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => const MaterialPage(
              child: const AccountScreen(),
              fullscreenDialog: true,
            ),
          ),
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => const MaterialPage(
              child: EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
              fullscreenDialog: true,
            ),
          ),
          GoRoute(
            path: 'product/:id',
            name: AppRoute.product.name,
            builder: (context, state) {
              final productId = state.params['id']!;
              return ProductScreen(productId: productId);
            },
          ),
        ]),
  ],
);

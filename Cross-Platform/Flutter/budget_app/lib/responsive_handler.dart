import 'package:budget_app/mobile/expense_view_mobile.dart';
import 'package:budget_app/mobile/login_view_mobile.dart';
import 'package:budget_app/web/expense_view_web.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'view_model.dart';
import 'web/login_view_web.dart';

class ResponsiveHandler extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final viewModelProvider = ref.watch(viewModel);
    // viewModelProvider.isLoggedIn();

    final _authState = ref.watch(authStateProvider);
    return _authState.when(
        data: (data) {
          if (data != null) {
            return LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return ExpenseViewWeb();
              } else {
                return ExpenseViewMobile();
              }
            });
          }
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return LoginViewWeb();
            } else {
              return LoginViewMobile();
            }
          });
        },
        error: (err, trace) {
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return LoginViewWeb();
            } else {
              return LoginViewMobile();
            }
          });
        },
        loading: () => LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return LoginViewWeb();
              } else {
                return LoginViewMobile();
              }
            }));

    // if (viewModelProvider.isSignedIn == true) {
    //   return LayoutBuilder(builder: (context, constraints) {
    //     if (constraints.maxWidth > 600) {
    //       return ExpenseViewWeb();
    //     } else {
    //       return ExpenseViewMobile();
    //     }
    //   });
    // } else {
    //   return LayoutBuilder(builder: (context, constraints) {
    //     if (constraints.maxWidth > 600) {
    //       return LoginViewWeb();
    //     } else {
    //       return LoginViewMobile();
    //     }
    //   });
    // }
  }
}

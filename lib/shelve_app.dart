import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelve/app/category/presenter/controller/category_controller.dart';
import 'package:shelve/app/category/presenter/pages/category_page.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/utils/extensions.dart';
import 'package:shelve/core/values/keys.dart';
import 'package:shelve/core/values/routes.dart';
import 'package:shelve/core/widgets/error/error_widget.dart';
import 'package:shelve/core/widgets/flow/flow.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/auth/domain/entities/user_entity.dart';
import 'app/auth/presenter/controller/auth_controller.dart';
import 'app/auth/presenter/flows/signin_flow_page.dart';
import 'app/auth/presenter/flows/signup_flow_page.dart';
import 'app/auth/presenter/pages/auth_page.dart';
import 'app/auth/presenter/widgets/greeting_appbar.dart';
import 'app/category/presenter/flows/category_selection_flow.dart';
import 'core/services/dependency/dependency_service.dart';

class ShelveApp {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => navigatorKey.currentContext!;

  static final router = GoRouter(
    initialLocation: Routes.auth,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: Routes.auth,
        builder: (context, state) => AuthPage(
          controller: Dependency.get<AuthController>(),
        ),
        routes: [
          GoRoute(
            path: Routes.signin,
            name: Routes.signin,
            builder: (context, state) => const SigninFlow(),
          ),
          GoRoute(
            path: Routes.signup,
            name: Routes.signup,
            builder: (context, state) => const SignupFlow(),
          ),
        ],
        redirect: (context, state) {
          final supabase = Supabase.instance.client;
          final session = supabase.auth.currentSession;
          if (session != null) {
            Dependency.get<AuthController>().user = UserEntity(
              id: session.user.id,
              email: session.user.email ?? '',
              name: session.user.userMetadata?['username'] ?? '',
              photoUrl: '',
            );
          }
          return session == null ? null : Routes.dashboard;
        },
      ),
      GoRoute(
        path: Routes.dashboard,
        name: Routes.dashboard,
        builder: (context, state) {
          return ShelveHome(
            controller: Dependency.get<CategoryController>(),
          );
        },
        redirect: (context, state) {
          final supabase = Supabase.instance.client;
          final session = supabase.auth.currentSession;
          return session == null ? Routes.auth : null;
        },
        routes: [
          GoRoute(
            path: Routes.categories,
            name: Routes.categories,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const CategoryPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            },
          ),
          GoRoute(
            path: Routes.newItem,
            name: Routes.newItem,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: CategorySelectionFlow(
                  categoryController: Dependency.get<CategoryController>(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}

class ShelveHome extends StatefulWidget {
  final CategoryController controller;

  const ShelveHome({
    required this.controller,
    super.key,
  });

  @override
  State<ShelveHome> createState() => _ShelveHomeState();
}

class _ShelveHomeState extends State<ShelveHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GreetingAppBar(
              authController: Dependency.get<AuthController>(),
              onCategoriesChanged: (categories) {
                if (categories == null) return;
                Future.delayed(const Duration(milliseconds: 130), () {
                  widget.controller.categories.changeToSuccessState(categories);
                  widget.controller.currentIndex.value = 0;
                });
              },
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              child: FeatureFlow.build(
                context: context,
                tag: Keys.categoryList,
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: widget.controller.categories,
                  builder: (context, state, child) {
                    if (state.isError) {
                      return FailureWidget(
                        title: context.strings.categoryErrorTitle,
                        description: context.strings.categoryErrorMessage,
                        onTryAgain: () {
                          widget.controller.fetchCategories();
                        },
                      );
                    }
                    if (state.isSuccess) {
                      return PageView.builder(
                        controller: widget.controller.pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.data.length,
                        onPageChanged: (page) {
                          if (widget.controller.userSwiped) {
                            widget.controller.currentIndex.value = page;
                          }
                          Future.delayed(const Duration(milliseconds: 100), () {
                            widget.controller.scrollController.scrollTo(
                              index: page + 1,
                              alignment: 0.5,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear,
                            );
                          });
                        },
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(state.data[index].name),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.theme.primaryColor,
        child: Icon(
          Iconcino.add,
          size: 28,
          color: context.scheme.onPrimary,
        ),
        onPressed: () {
          context.pushNamed(Routes.newItem);
        },
      ),
    );
  }
}

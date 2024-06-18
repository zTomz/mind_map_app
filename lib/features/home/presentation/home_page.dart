import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_map_app/core/config/design/design.dart';
import 'package:mind_map_app/core/config/router/app_router.dart';
import 'package:mind_map_app/core/cubits/app_info.dart';
import 'package:mind_map_app/core/extensions/theme.dart';
import 'package:mind_map_app/features/mind_map/data/models/mind_map.dart';
import 'package:package_info_plus/package_info_plus.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          context.router.push(
            MindMapRoute(
              mindMap: MindMap.fromName(name: 'New Mind Map'),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: context.colorScheme.primary,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.medium),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: BlocBuilder<AppInfoCubit, PackageInfo>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(Radii.medium),
                          ),
                        ),
                        const SizedBox(height: Spacing.large),
                        Text(
                          state.appName,
                          style: context.textTheme.displayLarge,
                        ),
                        Text(
                          state.version,
                          style: context.textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: Spacing.medium),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Settings"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(Spacing.medium),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(Radii.medium),
                  ),
                  child: Material(
                    color: context.colorScheme.surfaceContainer,
                    child: ListView.separated(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Item $index"),
                          subtitle: const Text("16.06.2024 12:47"),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_outlined),
                          ),
                          onTap: () {},
                          tileColor: context.colorScheme.surfaceContainerLow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Radii.medium),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(
                        height: Spacing.small,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

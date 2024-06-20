import 'package:flutter/material.dart';
import 'package:open_mind/app/app.dialogs.dart';
import 'package:open_mind/app/app.locator.dart';
import 'package:open_mind/app/app.router.dart';
import 'package:open_mind/services/app_info_service.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/common/ui_helpers.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          final result =
              await locator<DialogService>().showCustomDialog<String, String>(
            variant: DialogType.textField,
            title: "Create New Mind Map",
            data: "Mind Map Name",
          );

          if (result != null && result.confirmed && result.data != null) {
            locator<NavigationService>().navigateToMindMapView(
              mindMap: MindMap.fromName(name: result.data!),
            );
          }
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
                child: Column(
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
                      locator<AppInfoService>().packageInfo.appName,
                      style: context.textTheme.displayLarge,
                    ),
                    Text(
                      locator<AppInfoService>().packageInfo.version,
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
                            onPressed: () {
                              // TODO: Delete mind map
                            },
                            icon: const Icon(Icons.delete_outlined),
                          ),
                          onTap: () {
                            locator<NavigationService>().navigateToMindMapView(
                              mindMap: MindMap.fromName(name: 'Item $index'),
                            );
                          },
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

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

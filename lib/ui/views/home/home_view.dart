import 'package:flutter/material.dart';
import 'package:open_mind/app/app.dialogs.dart';
import 'package:open_mind/app/app.locator.dart';
import 'package:open_mind/app/app.router.dart';
import 'package:open_mind/services/app_info_service.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/common/ui_helpers.dart';
import 'package:open_mind/ui/dialogs/text_field/text_field_dialog_request_data.dart';
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
          final result = await locator<DialogService>()
              .showCustomDialog<String, TextFieldDialogRequestData>(
            variant: DialogType.textField,
            title: "Create New Mind Map",
            data: const TextFieldDialogRequestData(
              title: 'Create New Mind Map',
              hintText: 'Mind Map Name',
            ),
          );

          if (result != null && result.confirmed && result.data != null) {
            final newMindMap = MindMap.fromName(name: result.data!);
            await viewModel.createNewMindMap(newMindMap);

            locator<NavigationService>().navigateToMindMapView(
              mindMap: newMindMap,
            );
          }
        },
        child: Icon(
          Icons.add_rounded,
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
                  child: viewModel.isBusy
                      ? const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: Spacing.medium),
                              Text("Loading Mind Maps..."),
                            ],
                          ),
                        )
                      : Material(
                          color: context.colorScheme.surfaceContainer,
                          child: ListView.separated(
                            itemCount: viewModel.mindMaps.length,
                            itemBuilder: (context, index) {
                              final mindMap = viewModel.mindMaps[index];

                              return ListTile(
                                title: Text(mindMap.name),
                                subtitle: Text(
                                  formatDateTime(mindMap.lastEditedAt),
                                ),
                                trailing: IconButton(
                                  onPressed: () async {
                                    await viewModel.deleteMindMap(mindMap);
                                  },
                                  icon: const Icon(Icons.delete_outlined),
                                ),
                                onTap: () {
                                  locator<NavigationService>()
                                      .navigateToMindMapView(
                                    mindMap: mindMap,
                                  );
                                },
                                tileColor:
                                    context.colorScheme.surfaceContainerLow,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Radii.medium),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => const SizedBox(
                              height: Spacing.medium / 2,
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

  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    await viewModel.init();

    super.onViewModelReady(viewModel);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/presentation/providers/settings_provoider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var settingsProvider = Get.put(SettingController());
  @override
  void initState() {
    settingsProvider.loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        leadingWidth: 15,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 22,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Settings",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Celsius',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Obx(
                () => Switch(
                  value: settingsProvider.isCelsius.value,
                  onChanged: (value) {
                    settingsProvider.toggleTemperatureUnit();
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Fahrenheit',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Obx(
                () => Switch(
                  value: !settingsProvider.isCelsius.value,
                  onChanged: (value) {
                    settingsProvider.toggleTemperatureUnit();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: Text(
                'News Categories',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Obx(
                    () => CheckboxListTile(
                      side: const BorderSide(),
                      title: Text(
                        'Business News',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: settingsProvider.selectedCategories
                          .contains('business'),
                      onChanged: (value) {
                        settingsProvider.toggleCategory('business', context);
                      },
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      side: const BorderSide(),
                      title: Text(
                        'Entertainment News',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: settingsProvider.selectedCategories
                          .contains('entertainment'),
                      onChanged: (value) {
                        settingsProvider.toggleCategory(
                            'entertainment', context);
                      },
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      side: const BorderSide(),
                      title: Text(
                        'General News',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: settingsProvider.selectedCategories
                          .contains('general'),
                      onChanged: (value) {
                        settingsProvider.toggleCategory('general', context);
                      },
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      side: const BorderSide(),
                      title: Text(
                        'Health News',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: settingsProvider.selectedCategories
                          .contains('health'),
                      onChanged: (value) {
                        settingsProvider.toggleCategory('health', context);
                      },
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      side: const BorderSide(),
                      title: Text(
                        'Science News',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: settingsProvider.selectedCategories
                          .contains('science'),
                      onChanged: (value) {
                        settingsProvider.toggleCategory('science', context);
                      },
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      side: const BorderSide(),
                      title: Text(
                        'Sports News',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: settingsProvider.selectedCategories
                          .contains('sports'),
                      onChanged: (value) {
                        settingsProvider.toggleCategory('sports', context);
                      },
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      side: const BorderSide(),
                      title: Text(
                        'Technology News',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: settingsProvider.selectedCategories
                          .contains('technology'),
                      onChanged: (value) {
                        settingsProvider.toggleCategory('technology', context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

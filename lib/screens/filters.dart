import 'package:flutter/material.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/Providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filtetrs'),
      ),

      body: Column(
          children: [
            SwitchListTile(
              value: activeFilters[Filters.glutenfree]!,
              onChanged: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(Filters.glutenfree,isChecked);
              },
              title: Text(
                'Gluen-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Gluen-Free Only',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filters.lactosfree]!,
              onChanged: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(Filters.lactosfree,isChecked);
              },
              title: Text(
                'Lactos-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Lactos-Free only',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filters.vegetarian]!,
              onChanged: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(Filters.vegetarian,isChecked);
              },
              title: Text(
                'Vegiterian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Vegiterian',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filters.vegan]!,
              onChanged: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(Filters.vegan, isChecked);
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Vegan diary free foods',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_package_name_here/viewmodels/goals_view_model.dart'; // Replace with your actual package name
import 'package:your_package_name_here/components/rootine_item.dart'; // Import your RootineItem widget

class GoalsInProgressScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(goalsViewModelProvider);
    final state = viewModel.uiState;

    useEffect(() {
      viewModel.getInProgress();
      viewModel.calculateEndOfWeek(); // and check for milestone
      viewModel.calculateDaysUntilEndOfWeek();
      return null;
    }, const []);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.inProgress.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RootineItem(
                        rootine: state.inProgress[index],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          end: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              // Navigate to rootinesModificationNavigation route
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

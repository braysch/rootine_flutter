import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_package_name_here/viewmodels/goals_view_model.dart'; // Replace with your actual package name

class GoalsCompletedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(goalsViewModelProvider);
    final state = viewModel.uiState;

    useEffect(() {
      viewModel.getCompleted();
      return null;
    }, const []);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.completed.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RootineItem(
                        rootine: state.completed[index],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

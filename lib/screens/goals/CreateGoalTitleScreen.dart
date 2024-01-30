import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_package_name_here/viewmodels/rootine_modification_view_model.dart'; // Replace with your actual package name
import 'package:your_package_name_here/util/date_constants.dart'; // Replace with your actual package name
import 'package:joda_time/joda_time.dart'; // Import the JodaTime package

class CreateGoalTitleScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(rootineModificationViewModelProvider);
    final state = viewModel.uiState;

    var name = useState("");
    var scope = useMemoized(() => ScopedCoroutine());

    useEffect(() {
      if (state.valid) {
        state.valid = false;
        // Go to the next screen
      }
      return null;
    }, [state.valid]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("New Goal!", style: TextStyle(fontSize: 36)),
        Text("Give your goal a title", style: TextStyle(fontSize: 24)),
        SizedBox(height: 32),
        Text("What are you going to accomplish?"),
        TextField(
          controller: TextEditingController(text: name.value),
          onChanged: (value) {
            name.value = value;
          },
          decoration: InputDecoration(labelText: "Goal Title"),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            scope.launch(() => viewModel.validateTitle());
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.infinity, 60),
          ),
          child: Text("Continue"),
        ),
        SizedBox(height: 8),
        Text(state.errorMessage),
        Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: Text("Go Back"),
        ),
      ],
    );
  }
}

class ScopedCoroutine {
  void launch(void Function() callback) {
    callback();
  }
}

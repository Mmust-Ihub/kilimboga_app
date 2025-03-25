import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class GenreSelectionScreen extends StatefulWidget {
  const GenreSelectionScreen({super.key});

  @override
  State<GenreSelectionScreen> createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  final List<String> genres = [
    "Pop",
    "Rock",
    "Hip-hop",
    "Jazz",
    "Classical",
    "EDM",
    "Reggae",
    "R&B"
  ];

  List<String> selectedGenres = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(2.0),
      child: MultiSelectChipField<String?>(
        initialValue: selectedGenres,
        items: genres.map((e) => MultiSelectItem<String>(e, e)).toList(),
        title: const Text("Select Music Genres"),
        onTap: (List<String?>? values) {
          setState(() {
            selectedGenres = values?.whereType<String>().toList() ?? [];
          });
        },
        selectedChipColor: Theme.of(context).colorScheme.secondary,
        scroll: false,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textsStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_filter_outlined, color: colors.primary),
            const SizedBox(width: 5),
            Text(
              'Cinemapedia',
              style: textsStyle,
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
      ),
    ));
  }
}
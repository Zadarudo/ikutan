
import 'package:flutter/material.dart';


class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  'https',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Some Random Events',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium
                  ),
                ),
                const SizedBox(width: 8,),
                Text('2024-51-12'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

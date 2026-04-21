import 'package:flutter/material.dart';
import 'package:ikutan/widgets/ticket_tile.dart';

class MyTicketsTab extends StatelessWidget {
  const MyTicketsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.confirmation_num),
                    const SizedBox(width: 8),
                    Text(
                      'My Tickets',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                //active
                const Divider(height: 24,),
                ExpansionTile(
                  title: Text('Cancelled tickets'),
                  initiallyExpanded: true,
                childrenPadding: const EdgeInsets.only(left:16, right: 16, top: 16, bottom: 16),
                children: [
                 ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TicketTile();
                  }
                 )
                ]
                ),
                //canceled
                const Divider(height: 24,),
                ExpansionTile(
                  title: Text('Cancelled tickets'),
                  backgroundColor: Colors.red.withAlpha(50),
                childrenPadding: const EdgeInsets.only(left:16, right: 16, top: 16, bottom: 16),
                children: [
                 ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TicketTile();
                  }
                 )
                ]
                ),
                //used
                const Divider(height: 24,),
                ExpansionTile(
                  title: Text('Active tickets'),
                  backgroundColor: Colors.yellow.withAlpha(50),
                  initiallyExpanded: true,
                childrenPadding: const EdgeInsets.only(left:16, right: 16, top: 16, bottom: 16),
                children: [
                 ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TicketTile();
                  }
                 )
                ]
                ),
                TicketTile()
              ],
            ),
          )
        ),
      )
    );
  }
}


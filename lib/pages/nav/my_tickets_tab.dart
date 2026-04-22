import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikutan/controller/ticket_controller.dart';
import 'package:ikutan/models/ticket_model.dart';
import 'package:ikutan/utils/helper.dart';

class MyTicketsTab extends StatelessWidget {
  const MyTicketsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TicketController>();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(controller.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchTickets,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.tickets.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.confirmation_num_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text('No tickets yet', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchTickets,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.confirmation_num),
                      const SizedBox(width: 8),
                      Text(
                        'My Tickets',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Active Tickets
                  if (controller.activeTickets.isNotEmpty)
                    _TicketSection(
                      title: 'Active Tickets',
                      tickets: controller.activeTickets,
                      color: Colors.green,
                      icon: Icons.confirmation_num,
                      initiallyExpanded: true,
                      onCancel: (id) =>
                          _showCancelDialog(context, id, controller),
                    ),

                  // Used Tickets
                  if (controller.usedTickets.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _TicketSection(
                      title: 'Used Tickets',
                      tickets: controller.usedTickets,
                      color: Colors.blue,
                      icon: Icons.check_circle,
                      initiallyExpanded: false,
                    ),
                  ],

                  // Cancelled Tickets
                  if (controller.canceledTickets.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _TicketSection(
                      title: 'Cancelled Tickets',
                      tickets: controller.canceledTickets,
                      color: Colors.red,
                      icon: Icons.cancel,
                      initiallyExpanded: false,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _showCancelDialog(
    BuildContext context,
    String ticketId,
    TicketController controller,
  ) {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Ticket'),
        content: const Text(
          'Are you sure you want to cancel this ticket? This cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Keep')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.cancelTicket(ticketId);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cancel Ticket'),
          ),
        ],
      ),
    );
  }
}

class _TicketSection extends StatelessWidget {
  final String title;
  final List<Ticket> tickets;
  final Color color;
  final IconData icon;
  final bool initiallyExpanded;
  final void Function(String ticketId)? onCancel;

  const _TicketSection({
    required this.title,
    required this.tickets,
    required this.color,
    required this.icon,
    required this.initiallyExpanded,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(icon, color: color),
        title: Text('$title (${tickets.length})'),
        initiallyExpanded: initiallyExpanded,
        children: tickets
            .map(
              (ticket) => _TicketCard(
                ticket: ticket,
                accentColor: color,
                onCancel: onCancel,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final Ticket ticket;
  final Color accentColor;
  final void Function(String ticketId)? onCancel;

  const _TicketCard({
    required this.ticket,
    required this.accentColor,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: accentColor.withAlpha(80)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Ticket #${ticket.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    ticket.isUsed
                        ? 'Used'
                        : ticket.isCanceled
                        ? 'Cancelled'
                        : 'Active',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.qr_code, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    ticket.code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (ticket.checkedAt != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    'Used: ${Helper.formatDate(ticket.checkedAt!)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
            if (ticket.createdAt != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Booked: ${Helper.formatDate(ticket.createdAt!)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
            if (ticket.isActive && onCancel != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => onCancel!(ticket.id),
                  icon: const Icon(Icons.cancel_outlined, size: 16),
                  label: const Text('Cancel Ticket'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

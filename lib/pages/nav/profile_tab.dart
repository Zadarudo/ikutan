import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikutan/services/auth_service.dart';
import 'package:ikutan/utils/helper.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  final _authServices = Get.find<AuthServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person, size: 36),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _authServices.user.value!.name!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        _authServices.user.value!.email!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Chip(
                        label: Text(_authServices.user.value!.role!),
                        backgroundColor:
                            _authServices.user.value!.role == 'admin'
                            ? Colors.blue
                            : Colors.green,
                        labelStyle: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white),
                      ),
                      const Divider(height: 20),
                      Text('Joined on'),
                      Text(
                        Helper.formatDate(
                          _authServices.user.value!.createdAt
                              ?.toIso8601String(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _authServices.logout(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

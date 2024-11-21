import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testproject/home_controller.dart';

class HomeUI extends StatelessWidget {
  HomeUI({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedFirstName.value.isEmpty
                          ? null
                          : controller.selectedFirstName.value,
                      hint: const Text('Select First Name'),
                      items: controller.users
                          .map((user) => DropdownMenuItem<String>(
                        value: user.firstName!,
                        child: Text(user.firstName!),
                      ))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedFirstName.value = value!;
                      },
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() {
                    return DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedLastName.value.isEmpty
                          ? null
                          : controller.selectedLastName.value,
                      hint: const Text('Select Last Name'),
                      items: controller.users
                          .map((user) => DropdownMenuItem<String>(
                        value: user.lastName!,
                        child: Text(user.lastName!),
                      ))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedLastName.value = value!;
                      },
                    );
                  }),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.orange),
                  onPressed: () => controller.incrementCount(),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.userCounts.isEmpty) {
                  return const Center(child: Text('No items added.'));
                }
                return ListView(
                  children: controller.userCounts.entries.map((entry) {
                    return ListTile(
                      title: Text(entry.key),
                      trailing: Text('Count: ${entry.value}'),
                    );
                  }).toList(),
                );
              }),
            ),

            const Divider(),

            Obx(() {
              int totalCount = controller.userCounts.values.fold(0, (sum, count) => sum + count);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Total Count: $totalCount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

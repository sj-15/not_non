import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/features/search/controller/search_controller.dart';
import 'package:not_non/model/user_model.dart';

class RecomendedUser extends ConsumerWidget {
  static const routeName = '/recomended-user';
  final String topic;

  const RecomendedUser({super.key, required this.topic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // int index = 0;
    List<InterestsModel?> interestedUser = [];
    ref
        .watch(getInterestsControllerProvider)
        .getInterest(topic, context)
        .then((value) {
      interestedUser = value;
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var user in interestedUser)
            Text(
              user!.notid,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}

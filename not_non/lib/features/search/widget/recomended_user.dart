import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import '../../../common/utils/colors.dart';
import '../../../common/widgets/loader.dart';
import '../../../model/user_model.dart';
import '../controller/search_controller.dart';

class RecomendedUsers extends StatelessWidget {
  final String interest;
  const RecomendedUsers({super.key, required this.interest});

  @override
  Widget build(BuildContext context) {
    return riverpod.Consumer(
      builder: (context, ref, child) {
        final controller = ref.watch(getInterestsControllerProvider);
        return FutureBuilder<List<InterestsModel?>>(
          future: controller.getInterest(interest.toLowerCase(), context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Loader(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final users = snapshot.data ?? [];
            final filteredUsers = users
                .where(
                    (user) => user!.interests.contains(interest.toLowerCase()))
                .toList();
            if (filteredUsers.isEmpty) {
              return Center(
                child: Text('No users found with $interest in common'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                final matches = user!.interests
                    .where((topic) =>
                        topic.toLowerCase() == interest.toLowerCase())
                    .toString();
                return RecommendedUser(
                  notid: user.notid,
                  profilePic: user.profilePic,
                  interests: user.interests,
                  matches: matches,
                );
              },
            );
          },
        );
      },
    );
  }
}

class RecommendedUser extends StatelessWidget {
  final String notid;
  final String profilePic;
  final List<String> interests;
  final String matches;

  const RecommendedUser({
    super.key,
    required this.notid,
    required this.profilePic,
    required this.interests,
    required this.matches,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profilePic),
        radius: 30,
      ),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '!',
              style: TextStyle(
                color: logocolor,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            TextSpan(
              text: notid,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text('$matches matches'),
      trailing: IconButton(
        icon: const Icon(Icons.message_outlined),
        onPressed: () {},
      ),
    );
  }
}

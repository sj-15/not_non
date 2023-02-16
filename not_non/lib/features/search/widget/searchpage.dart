import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/error.dart';
import '../../../common/widgets/loader.dart';
import '../../../model/user_model.dart';
import '../controller/search_controller.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ref.watch(searchControllerProvider).when(
            data: (interestsList) => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: interestsList!.interests.length,
              itemBuilder: (context, index) {
                String interest = interestsList.interests[index];
                return riverpod.Consumer(
                  builder: (context, ref, child) {
                    final controller =
                        ref.watch(getInterestsControllerProvider);
                    return FutureBuilder<List<InterestsModel?>>(
                      future: controller.getInterest(
                          interest.toLowerCase(), context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                            .where((user) => user!.interests
                                .contains(interest.toLowerCase()))
                            .toList();
                        if (filteredUsers.isEmpty) {
                          return Center(
                            child:
                                Text('No users found with $interest in common'),
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
                                    topic.toLowerCase() ==
                                    interest.toLowerCase())
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
              },
            ),
            error: (error, stackTrace) => ErrorScreen(error: error.toString()),
            loading: () => const Loader(),
          ),
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
      title: Text('!$notid'),
      subtitle: Text('$matches matches'),
      trailing: IconButton(
        icon: const Icon(Icons.switch_account_rounded),
        onPressed: () {},
      ),
    );
  }
}

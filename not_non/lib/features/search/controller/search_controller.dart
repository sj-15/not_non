import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/features/search/repository/search_repo.dart';
import 'package:not_non/model/user_model.dart';

final searchControllerProvider = FutureProvider((ref) {
  final searchInterestRepository = ref.watch(searchRepositoryProvider);
  return searchInterestRepository.getInterest();
});
final getInterestsControllerProvider = Provider((ref) {
  final searchInterestRepository = ref.watch(searchRepositoryProvider);
  return GetInterestsController(
      ref: ref, searchRepository: searchInterestRepository);
});

class GetInterestsController {
  final ProviderRef ref;
  final SearchRepository searchRepository;

  GetInterestsController({required this.ref, required this.searchRepository});

  Future<List<InterestsModel?>> getInterest(
      String topic, BuildContext context) async {
    List<InterestsModel?> users =
        await searchRepository.searchUser(topic, context);
    return users;
  }
}

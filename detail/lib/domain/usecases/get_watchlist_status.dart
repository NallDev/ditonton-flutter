import 'package:detail/domain/repositories/detail_repository.dart';

class GetWatchListStatus {
  final DetailRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}

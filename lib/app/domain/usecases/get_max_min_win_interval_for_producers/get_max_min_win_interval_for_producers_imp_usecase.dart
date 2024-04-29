import '../../models/dtos/awards_interval/awards_interval_dto.dart';
import 'get_max_min_win_interval_for_producers_usecase.dart';
import '../../repositories/get_max_min_win_interval_for_producers/get_max_min_win_interval_for_producers_repository.dart';

class GetMaxMinWinIntervalForProducersImpUsecase
    implements GetMaxMinWinIntervalForProducersUsecase {
  final GetMaxMinWinIntervalForProducersRepository
      _getMaxMinWinIntervalForProducersRepository;

  GetMaxMinWinIntervalForProducersImpUsecase(
    this._getMaxMinWinIntervalForProducersRepository,
  );

  @override
  Future<AwardsIntervalDto> call() async {
    return await _getMaxMinWinIntervalForProducersRepository();
  }
}

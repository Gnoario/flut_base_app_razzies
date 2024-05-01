import '../../models/dtos/awards_interval/awards_interval_dto.dart';

abstract class GetMaxMinWinIntervalForProducersRepository {
  Future<AwardsIntervalDto> call();
}

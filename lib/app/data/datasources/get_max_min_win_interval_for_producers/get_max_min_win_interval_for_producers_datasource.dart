import 'package:flut_base_app_razzies/app/domain/models/dtos/awards_interval/awards_interval_dto.dart';

abstract class GetMaxMinWinIntervalForProducersDatasource {
  Future<AwardsIntervalDto> call();
}

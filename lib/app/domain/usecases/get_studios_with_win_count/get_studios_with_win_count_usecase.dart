import '../../models/dtos/studio_win_count/studio_win_count_dto.dart';

abstract class GetStudiosWithWinCountUsecase {
  Future<List<StudioWinCountDto>> call();
}

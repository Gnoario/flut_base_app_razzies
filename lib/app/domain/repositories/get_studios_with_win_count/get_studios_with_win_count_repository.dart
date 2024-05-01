import 'package:flut_base_app_razzies/app/domain/models/dtos/studio_win_count/studio_win_count_dto.dart';

abstract class GetStudiosWithWinCountRepository {
  Future<List<StudioWinCountDto>> call();
}

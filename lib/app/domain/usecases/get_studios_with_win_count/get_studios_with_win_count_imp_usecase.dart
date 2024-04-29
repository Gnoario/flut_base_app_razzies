import '../../models/dtos/studio_win_count/studio_win_count_dto.dart';
import 'get_studios_with_win_count_usecase.dart';
import '../../repositories/get_studios_with_win_count/get_studios_with_win_count_repository.dart';

class GetStudionsWithWinCountImpUsecase
    implements GetStudiosWithWinCountUsecase {
  final GetStudiosWithWinCountRepository _getStudionsWithWinCountRepository;

  GetStudionsWithWinCountImpUsecase(this._getStudionsWithWinCountRepository);

  @override
  Future<List<StudioWinCountDto>> call() async {
    return await _getStudionsWithWinCountRepository();
  }
}

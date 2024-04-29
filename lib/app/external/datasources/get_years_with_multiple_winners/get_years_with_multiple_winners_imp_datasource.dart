import 'package:flut_base_app_razzies/app/domain/models/dtos/yearly_winners_count_dto/yearly_winners_count_dto.dart';
import '../../../data/datasources/get_years_with_multiple_winners/get_years_with_multiple_winners_datasource.dart';
import 'package:flut_base_app_razzies/core/services/services.dart';

class GetYearsWithMultipleWinnersImpDatasource
    implements GetYearsWithMultipleWinnersDatasource {
  final ClientHttps _clientHttps;

  GetYearsWithMultipleWinnersImpDatasource(this._clientHttps);

  final _endpoint = '/movies?projection=years-with-multiple-winners';

  @override
  Future<List<YearlyWinnersCountDto>> call() async {
    final response = await _clientHttps.get(_endpoint);
    final data = response.data as List;
    return data.map((e) => YearlyWinnersCountDto.fromJson(e)).toList();
  }
}

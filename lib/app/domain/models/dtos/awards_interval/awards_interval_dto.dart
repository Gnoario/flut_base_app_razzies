import 'package:flut_base_app_razzies/app/domain/models/dtos/producer_awards_interval/producer_awards_interval_dto.dart';

class AwardsIntervalDto {
  final List<ProducerAwardsIntervalDto> max;
  final List<ProducerAwardsIntervalDto> min;
  AwardsIntervalDto({
    required this.max,
    required this.min,
  });

  factory AwardsIntervalDto.fromJson(Map<String, dynamic> json) {
    final max = json['max'] as List;
    final min = json['min'] as List;
    return AwardsIntervalDto(
      max: max.map((e) => ProducerAwardsIntervalDto.fromJson(e)).toList(),
      min: min.map((e) => ProducerAwardsIntervalDto.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max': max.map((e) => e.toJson()).toList(),
      'min': min.map((e) => e.toJson()).toList(),
    };
  }
}

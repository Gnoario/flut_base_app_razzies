class BaseStringHelper {
  final String baseUrl;
  final String protocol;
  final Duration timeout;

  BaseStringHelper({
    this.baseUrl = "#",
    this.protocol = "https",
    this.timeout = const Duration(seconds: 10),
  });

  factory BaseStringHelper.dev() {
    const baseUrl = "https://tools.texoit.com/backend-java/api";
    return BaseStringHelper(baseUrl: baseUrl);
  }

  String get fullUrl => "$protocol://$baseUrl";
}

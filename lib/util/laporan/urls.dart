import 'package:p3l_gah_android/util/laporan/app_helper.dart';

class Urls {
  static const flChartUrl = 'https://flchart.dev';
  static const flChartGithubUrl = 'https://github.com/imaNNeo/fl_chart';

  static String get aboutUrl => '$flChartUrl/about';

  static String getChartSourceCodeUrl(ChartType chartType, int sampleNumber) {
    final chartDir = chartType.name.toLowerCase();
    return 'https://github.com/imaNNeo/fl_chart/blob/master/example/lib/presentation/samples/$chartDir/${chartDir}_chart_sample$sampleNumber.dart';
  }

  static String getChartDocumentationUrl(ChartType chartType) {
    final chartDir = chartType.name.toLowerCase();
    return 'https://github.com/imaNNeo/fl_chart/blob/master/repo_files/documentations/${chartDir}_chart.md';
  }

  static String getVersionReleaseUrl(String version) =>
      '$flChartGithubUrl/releases/tag/$version';
}

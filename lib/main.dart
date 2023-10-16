import 'package:style_generate/generate.dart';

//Template
//   static const colorBaseGray = '#677484';
//   static const colorTransperent = '#677484';
//   static const colorPalettePink25 = '#677484';
//   static const colorPalettePink50 = '#677484';

//   static const textFontSize1 = 10;
//   static const textFontSize2 = 10;

//   static const spacingPercentPill = 50;
//   static const spacingXS1 = 10;
//   static const spacingXS2 = 10;

Future<void> main(List<String> args) async {
  final generate = Generates();
  final outputPath = '/Users/hung.v/KIOTVIET/kv-booking-mobile-man/lib';

  final foundationOutputDir = '$outputPath/style_guide/foundation';
  final foudationInputPath = 'assets/foundation';

  final componentOutputDir = '$outputPath/style_guide/component';
  final componentInputPath = 'assets/mobile_component';

  Future.wait([
    generate.execute(foudationInputPath, foundationOutputDir),
    generate.execute(componentInputPath, componentOutputDir),
  ]).then((value) => print('\x1B[32m<DPZ>DONE!\x1B[32m'));
}

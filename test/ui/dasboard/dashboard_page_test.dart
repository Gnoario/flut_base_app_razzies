import 'package:faker/faker.dart';
import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flut_base_app_razzies/app/ui/pages/dashboard/dashboard_page.dart';
import 'package:flut_base_app_razzies/app/ui/pages/dashboard/dashboard_presenter.dart';
import 'package:flut_base_app_razzies/core/services/client_https/client_https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/mocks/mocks.dart';
import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late DashboardPresenterSpy presenter;
  late ClientHttpsSpy clientHttpsSpy;
  late StudioWinCountMock studioWinCountMock;
  late AwardsIntervalMock awardsIntervalMock;
  late MovieMock movieMock;
  late YearlyWinnersCountMock yearlyWinnersCountMock;

  setUpAll(() {
    Modular.bindModule(AppModuleSpy());
  });

  setUp(() {
    clientHttpsSpy = ClientHttpsSpy();
    presenter = DashboardPresenterSpy();
    Modular.replaceInstance<ClientHttps>(clientHttpsSpy);
    Modular.replaceInstance<DashboardPresenter>(presenter);
    studioWinCountMock = StudioWinCountMock();
    awardsIntervalMock = AwardsIntervalMock();
    movieMock = MovieMock();
    yearlyWinnersCountMock = YearlyWinnersCountMock();
  });

  Future<void> loadPage(WidgetTester tester) async {
    await tester.pumpWidget(
      makePage(
        page: const DashboardPage(),
      ),
    );
  }

  tearDown(() {
    presenter.dispose();
    Modular.dispose<DashboardPresenter>();
  });

  tearDownAll(() {
    Modular.dispose();
  });

  group('Success Cases', () {
    testWidgets('Should start normally without error on init page',
        (tester) async {
      await loadPage(tester);
      presenter.emitYearError(null);
      await tester.pump();
      final textError = find.text('Error');
      expect(textError, findsNothing);
    });

    testWidgets(
        'Should show Linear Progress Indicator on loading studios in datatable',
        (tester) async {
      await loadPage(tester);
      presenter.emitStudiosWithWinCountLoading(true);

      await tester.pump();
      final loading = find.descendant(
        of: find.byType(ResponsiveDatatable),
        matching: find.byType(LinearProgressIndicator),
      );
      expect(loading, findsOne);
    });

    testWidgets(
        'Should show Linear Progress Indicator on loading winner per year in datatable',
        (tester) async {
      await loadPage(tester);
      presenter.emitWinnerPerYearLoading(true);

      await tester.pump();
      final loading = find.descendant(
        of: find.byType(ResponsiveDatatable),
        matching: find.byType(LinearProgressIndicator),
      );
      expect(loading, findsOne);
    });

    testWidgets(
        'Should show Linear Progress Indicator on loading years with multiple winners in datatable',
        (tester) async {
      await loadPage(tester);
      presenter.emitYearsWithMultipleWinnersLoading(true);

      await tester.pump();
      final loading = find.descendant(
        of: find.byType(ResponsiveDatatable),
        matching: find.byType(LinearProgressIndicator),
      );
      expect(loading, findsOne);
    });

    testWidgets(
        'Should show double Linear Progress Indicator on loading max and min win interval in datatable',
        (tester) async {
      await loadPage(tester);
      presenter.emitMaxMinWinIntervalForProducersLoading(true);

      await tester.pump();
      final loading = find.descendant(
        of: find.byType(ResponsiveDatatable),
        matching: find.byType(LinearProgressIndicator),
      );
      expect(loading, findsAny);
    });

    testWidgets(
        'Should do not show Linear Progress Indicator after loading datatables',
        (tester) async {
      await loadPage(tester);
      presenter.emitLoadings();
      await tester.pump();
      presenter.emitLoadings(loading: false);
      await tester.pump();

      final loading = find.byType(LinearProgressIndicator);
      expect(loading, findsNothing);
    });

    testWidgets(
        'Should return a ResultPresentation on call getStudiosWithWinCount',
        (tester) async {
      await loadPage(tester);
      final mockList = studioWinCountMock.createStudioWinCountListJson();
      presenter.emitStudiosWithWinCount(
        ResultPresentation(payload: mockList),
      );

      await tester.pump();
      final getStudiosResult = find.text(mockList[0]['name']);
      expect(getStudiosResult, findsOne);
    });

    testWidgets(
        'Should return a ResultPresentation on call getMaxMinWinIntervalForProducers',
        (tester) async {
      await loadPage(tester);
      final mockList = awardsIntervalMock.createAwardsIntervalJson();
      presenter.emitMaxMinWinIntervalForProducers(
        ResultPresentation(payload: mockList),
      );

      await tester.pump();
      final getStudiosMaxResult = find.text(mockList['max'][0]['producer']);
      final getStudiosMinResult = find.text(mockList['min'][0]['producer']);
      expect(getStudiosMinResult, findsOne);
      expect(getStudiosMaxResult, findsOne);
    });

    testWidgets('Should return a ResultPresentation on call getWinnerPerYear',
        (tester) async {
      await loadPage(tester);
      final mockList = movieMock.createMovieJson();
      presenter.emitWinnerPerYear(
        ResultPresentation(payload: [mockList]),
      );

      await tester.pump();
      final getWinnerPerYearResult = find.text(mockList['title']);
      expect(getWinnerPerYearResult, findsOne);
    });

    testWidgets(
        'Should return a ResultPresentation on call getYearsWithMultipleWinners',
        (tester) async {
      await loadPage(tester);
      final mockList =
          yearlyWinnersCountMock.createYearlyWinnersCountListJson();
      presenter.emitYearsWithMultipleWinners(
        ResultPresentation(payload: mockList),
      );

      await tester.pump();
      final getYearsWithMultipleWinnersResult = find.text(
        mockList[0]['winnerCount'].toString(),
      );
      expect(getYearsWithMultipleWinnersResult, findsOne);
    });

    testWidgets('Should call getWinnerPerYear on tap button', (tester) async {
      await loadPage(tester);
      presenter.validateYear('2020');
      await tester.pump();
      final button = find.byType(FloatingActionButton);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();
      expect(presenter.getWinnerPerYearCalled, isTrue);
    });

    testWidgets('Should call start functions on Load Page', (tester) async {
      await loadPage(tester);
      await tester.pump();

      expect(presenter.getMaxMinWinIntervalForProducersCalled, isTrue);
      expect(presenter.getStudiosWithWinCountCalled, isTrue);
      expect(presenter.getYearsWithMultipleWinnersCalled, isTrue);
    });

    testWidgets('Should call validateYear on change text field',
        (tester) async {
      await loadPage(tester);
      await tester.pump();
      final textField = find.byType(TextField);
      await tester.enterText(textField, '2020');
      await tester.pump();
      expect(presenter.validateYearCalled, isTrue);
    });

    testWidgets('Should call correct loadings lifecycle', (tester) async {
      await loadPage(tester);
      final loading = find.byType(LinearProgressIndicator);

      presenter.emitLoadings();
      await tester.pump();
      expect(loading, findsAny);

      presenter.emitLoadings(loading: false);
      await tester.pump();
      expect(loading, findsNothing);

      presenter.emitLoadings();
      await tester.pump();
      expect(loading, findsAny);
    });
  });

  group('Error Cases', () {
    testWidgets('Should show error message on type wrong year error',
        (tester) async {
      final error = faker.lorem.word();
      await loadPage(tester);
      presenter.emitYearError(error);

      await tester.pump();
      final textError = find.text(error);
      expect(textError, findsOne);
    });

    testWidgets('Should show error message on change text field',
        (tester) async {
      final error = faker.lorem.word();
      await loadPage(tester);
      presenter.emitYearError(error);
      final textField = find.byType(TextField);
      await tester.enterText(textField, '1500');
      await tester.pump();
      final textError = find.text(error);
      expect(textError, findsOne);
      expect(presenter.validateYearCalled, isTrue);
    });
  });
}

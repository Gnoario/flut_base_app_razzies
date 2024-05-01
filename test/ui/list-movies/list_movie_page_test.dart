import 'package:faker/faker.dart';
import 'package:flut_base_app_razzies/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_razzies/app/ui/components/components.dart';
import 'package:flut_base_app_razzies/app/ui/pages/list_movies/list_movies_page.dart';
import 'package:flut_base_app_razzies/app/ui/pages/list_movies/list_movies_presenter.dart';
import 'package:flut_base_app_razzies/core/services/client_https/client_https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/mocks/mocks.dart';
import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late ListMoviesPresenterSpy presenter;
  late ClientHttpsSpy clientHttpsSpy;
  late PaginatedMoviesMock paginatedMoviesMock;

  setUpAll(() {
    Modular.bindModule(AppModuleSpy());
  });

  setUp(() {
    clientHttpsSpy = ClientHttpsSpy();
    presenter = ListMoviesPresenterSpy();
    Modular.replaceInstance<ClientHttps>(clientHttpsSpy);
    Modular.replaceInstance<ListMoviesPresenter>(presenter);
    paginatedMoviesMock = PaginatedMoviesMock();
  });

  Future<void> loadPage(WidgetTester tester) async {
    await tester.pumpWidget(
      makePage(
        page: const ListMoviesPage(),
      ),
    );
  }

  tearDown(() {
    presenter.dispose();
    Modular.dispose<ListMoviesPage>();
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
        'Should show Linear Progress Indicator on loading movies in datatable',
        (tester) async {
      await loadPage(tester);
      presenter.emitIsGetMoviesLoading(true);

      await tester.pump();
      final loading = find.descendant(
        of: find.byType(ResponsiveDatatable),
        matching: find.byType(LinearProgressIndicator),
      );
      expect(loading, findsOne);
    });

    testWidgets(
        'Should do not show Linear Progress Indicator after loading datatables',
        (tester) async {
      await loadPage(tester);
      presenter.emitIsGetMoviesLoading(true);
      await tester.pump();
      presenter.emitIsGetMoviesLoading(false);
      await tester.pump();

      final loading = find.byType(LinearProgressIndicator);
      expect(loading, findsNothing);
    });

    testWidgets('Should return a ResultPresentation on call getMovies',
        (tester) async {
      await loadPage(tester);
      final mockList = paginatedMoviesMock.createMoviesJson();
      presenter.emitMovies(
        ResultPresentation(payload: mockList),
      );

      await tester.pump();
      final getMoviesResult = find.text(mockList[0]['title']);
      expect(getMoviesResult, findsAny);
    });

    testWidgets('Should call setWinner and getMovies on Selecte Dropdown Value',
        (tester) async {
      await loadPage(tester);
      presenter.getMoviesCalled = false;
      presenter.validateYearCalled = false;
      presenter.validateYear('2020');
      await tester.pump();
      final button = find.byType(DropdownButtonFormField<String>);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yes').last);
      await tester.pumpAndSettle();
      expect(presenter.setWinnerCalled, isTrue);
      expect(presenter.getMoviesCalled, isTrue);
    });

    testWidgets('Should call start functions on Load Page', (tester) async {
      await loadPage(tester);
      await tester.pump();

      expect(presenter.getMoviesCalled, isTrue);
    });

    testWidgets('Should call validateYear and getMovies on change text field',
        (tester) async {
      await loadPage(tester);
      presenter.validateYearCalled = false;
      presenter.getMoviesCalled = false;
      await tester.pump();
      final textField = find.byType(TextField);
      await tester.enterText(textField, '2020');
      await tester.pump();
      expect(presenter.validateYearCalled, isTrue);
      expect(presenter.getMoviesCalled, isTrue);
    });

    testWidgets('Should call correct loadings lifecycle', (tester) async {
      await loadPage(tester);
      final loading = find.byType(LinearProgressIndicator);

      presenter.emitIsGetMoviesLoading(true);
      await tester.pump();
      expect(loading, findsAny);

      presenter.emitIsGetMoviesLoading(false);
      await tester.pump();
      expect(loading, findsNothing);

      presenter.emitIsGetMoviesLoading(true);
      await tester.pump();
      expect(loading, findsAny);
    });

    testWidgets(
        'Should call getMovies on tap next button on Pagination Component',
        (tester) async {
      await loadPage(tester);
      presenter.getMoviesCalled = false;
      presenter.currentPage = presenter.currentPage!.copyWith(
        number: 1,
        totalPages: 15,
        totalElements: 5,
      );
      presenter.emitPagination(presenter.currentPage!);
      await tester.pump();
      final button = find.byIcon(Icons.chevron_right);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();
      expect(presenter.getMoviesCalled, isTrue);
    });

    testWidgets(
        'Should call getMovies on tap back button on Pagination Component',
        (tester) async {
      await loadPage(tester);
      presenter.getMoviesCalled = false;
      presenter.currentPage = presenter.currentPage!.copyWith(
        number: 1,
        totalPages: 15,
        totalElements: 5,
      );
      presenter.emitPagination(presenter.currentPage!);
      presenter.paginationController?.moveTo(3);
      await tester.pump();
      final button = find.byIcon(Icons.chevron_left);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();
      expect(presenter.getMoviesCalled, isTrue);
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

    testWidgets(
        'Should do not call getMovies on tap next button on Pagination Component',
        (tester) async {
      await loadPage(tester);
      presenter.getMoviesCalled = false;
      presenter.currentPage = presenter.currentPage!.copyWith(
        number: 1,
        totalPages: 15,
        totalElements: 5,
      );
      presenter.emitPagination(presenter.currentPage!);
      presenter.paginationController?.moveTo(15);
      await tester.pump();
      final button = find.byIcon(Icons.chevron_right);
      await tester.ensureVisible(button);
      await tester.pump();
      expect(presenter.getMoviesCalled, isFalse);
    });

    testWidgets(
        'Should do not call getMovies on tap back button on Pagination Component',
        (tester) async {
      await loadPage(tester);
      presenter.getMoviesCalled = false;
      presenter.currentPage = presenter.currentPage!.copyWith(
        number: 1,
        totalPages: 15,
        totalElements: 5,
      );
      presenter.emitPagination(presenter.currentPage!);
      await tester.pump();
      final button = find.byIcon(Icons.chevron_left);
      await tester.ensureVisible(button);
      await tester.pump();
      expect(presenter.getMoviesCalled, isFalse);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:velo_toulouse/main_common.dart';
import 'package:velo_toulouse/data/repositories/bike/bike_repository_mock.dart';
import 'package:velo_toulouse/data/repositories/station/station_repository_mock.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository_mock.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      VeloToulouseApp(
        bikeRepository: BikeRepositoryMock(),
        stationRepository: StationRepositoryMock(),
        subscriptionRepository: SubscriptionRepositoryMock(),
      ),
    );
  });
}

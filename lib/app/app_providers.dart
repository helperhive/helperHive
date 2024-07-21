import 'package:helperhive/backend/providers/booking_provider.dart';
import 'package:helperhive/backend/providers/message_provider.dart';
import 'package:helperhive/backend/providers/service_person_provider.dart';
import 'package:helperhive/backend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => MessageProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => BookingProvider()),
    ChangeNotifierProvider(create: (_) => ServicePersonProvider()),
  ];
}

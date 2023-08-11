import 'package:one_signal_tutorial/data/models/models.dart';

/// A helper class for handling push notification arguments and navigation.
class PushNotificationHelper {
  /// Extracts the arguments based on the given [type] and [args]
  /// to be used for router navigation.
  ///
  /// The [type] represents the type of the navigation destination,
  /// and [args] contains the additional data provided in the push notification.
  ///
  /// Returns the extracted arguments suitable for navigation purposes,
  /// or null if the [type] is not recognized or no valid arguments are provided.
  static dynamic getArgumentsByTypeForRouterNavigation(
    PushNotificationDataArgsType type,
    dynamic args,
  ) {
    switch (type) {
      // Handle the case when navigating to 'DetailsRoute1'.
      case PushNotificationDataArgsType.detailsPage1:
        // Since there are no additional arguments for this route,
        // return null to indicate no arguments are needed.
        return null;

      // Handle the case when navigating to 'DetailsRoute2'.
      case PushNotificationDataArgsType.detailsPage2:
        // Check if 'args' contains the expected 'textNotification' parameter.
        if (args case {'textNotification': String textData}) {
          // Extract the 'textNotification' parameter and return it.
          final text = textData;
          return text;
        }
        // If the 'args' do not contain the expected parameter,
        // or 'args' is null or not of the expected type, return null.
        return null;
    }
  }
}

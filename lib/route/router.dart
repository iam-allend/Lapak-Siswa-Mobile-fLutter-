import 'package:flutter/material.dart';
import 'package:shop/entry_point.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/product_siswa_model.dart';
import 'package:shop/screens/address/views/add_new_address_screen.dart';
import 'package:shop/screens/address/views/addresses_screen.dart';
import 'package:shop/screens/bookmark/views/bookmark_screen.dart';
import 'package:shop/screens/discover/views/discover_screen.dart';
import 'package:shop/screens/home/views/home_screen.dart';
import 'package:shop/screens/kids/views/kids_screen.dart';
import 'package:shop/screens/notification/views/enable_notification_screen.dart';
import 'package:shop/screens/notification/views/no_notification_screen.dart';
import 'package:shop/screens/notification/views/notification_options_screen.dart';
import 'package:shop/screens/notification/views/notifications_screen.dart';
import 'package:shop/screens/onbording/views/onbording_screen.dart';
import 'package:shop/screens/on_sale/views/on_sale_screen.dart';
import 'package:shop/screens/order/views/order_delivered_screen.dart';
import 'package:shop/screens/order/views/order_detail_screen.dart';
import 'package:shop/screens/order/views/orders_screen.dart';
import 'package:shop/screens/order/views/wishlist_screen.dart';
import 'package:shop/screens/payment/views/payment_screen.dart';
import 'package:shop/screens/preferences/views/preferences_screen.dart';
import 'package:shop/screens/preferences/views/select_language_screen.dart';
import 'package:shop/screens/product/views/category_screen.dart';
import 'package:shop/screens/product/views/product_details_screen.dart';
import 'package:shop/screens/product/views/product_reviews_screen.dart';
import 'package:shop/screens/profile/views/profile_edit_screen.dart';
import 'package:shop/screens/profile/views/profile_screen.dart';
import 'package:shop/screens/profile/views/profile_view_screen.dart';
import 'package:shop/screens/search/views/search_screen.dart';
import 'package:shop/screens/splash/views/splash_screen.dart';
import 'package:shop/screens/user_info/views/user_info_screen.dart';
import 'package:shop/screens/wallet/views/empty_wallet_screen.dart';
import 'package:shop/screens/wallet/views/wallet_screen.dart';
import 'package:shop/screens/cart/views/cart_screen.dart';
import 'screen_export.dart';

const String profileEditScreenRoute = "profile_edit";
const String orderScreenRoute = "order_screen";
const String wishlistScreenRoute = "wishlist";
const String userInfoScreenRoute = "user_info";
const String paymentScreenRoute = "payment_screen";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case onbordingScreenRoute:
      return MaterialPageRoute(builder: (_) => const OnBordingScreen());
    case logInScreenRoute:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case signUpScreenRoute:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    case passwordRecoveryScreenRoute:
      return MaterialPageRoute(builder: (_) => const PasswordRecoveryScreen());
    case productDetailsScreenRoute:
      final product = settings.arguments as ProductSiswaModel;
      return MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product));
    case productReviewsScreenRoute:
      return MaterialPageRoute(builder: (_) => const ProductReviewsScreen());
    case homeScreenRoute:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case discoverScreenRoute:
      return MaterialPageRoute(builder: (_) => const DiscoverScreen());
    case onSaleScreenRoute:
      return MaterialPageRoute(builder: (_) => const OnSaleScreen());
    case kidsScreenRoute:
      return MaterialPageRoute(builder: (_) => const KidsScreen());
    case searchScreenRoute:
      return MaterialPageRoute(builder: (_) => const SearchScreen());
    case bookmarkScreenRoute:
      return MaterialPageRoute(builder: (_) => const BookmarkScreen());
    case entryPointScreenRoute:
      return MaterialPageRoute(builder: (_) => const EntryPoint());
    case profileScreenRoute:
      return MaterialPageRoute(builder: (_) => const ProfileScreen());
    case userInfoScreenRoute:
      return MaterialPageRoute(builder: (_) => const UserInfoScreen());
    case notificationsScreenRoute:
      return MaterialPageRoute(builder: (_) => const NotificationsScreen());
    case noNotificationScreenRoute:
      return MaterialPageRoute(builder: (_) => const NoNotificationScreen());
    case enableNotificationScreenRoute:
      return MaterialPageRoute(builder: (_) => const EnableNotificationScreen());
    case notificationOptionsScreenRoute:
      return MaterialPageRoute(builder: (_) => const NotificationOptionsScreen());
    case addressesScreenRoute:
      return MaterialPageRoute(builder: (_) => const AddressesScreen());
    case ordersScreenRoute:
      return MaterialPageRoute(builder: (_) => const OrderScreen());
    case preferencesScreenRoute:
      return MaterialPageRoute(builder: (_) => const PreferencesScreen());
    case emptyWalletScreenRoute:
      return MaterialPageRoute(builder: (_) => const EmptyWalletScreen());
    case walletScreenRoute:
      return MaterialPageRoute(builder: (_) => const WalletScreen());
    case cartScreenRoute:
      return MaterialPageRoute(builder: (_) => const CartScreen());
    case profileViewScreenRoute:
      return MaterialPageRoute(builder: (_) => const ProfileViewScreen());
    case profileEditScreenRoute:
      return MaterialPageRoute(builder: (_) => const ProfileEditScreen());
    case orderScreenRoute:
      return MaterialPageRoute(builder: (_) => const OrderScreen());
    case 'order_detail':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => OrderDetailScreen(
          title: args['title'],
          items: args['items'],
        ),
      );
    case deliveredOrdersScreenRoute:
      return MaterialPageRoute(builder: (_) => const OrderDeliveredScreen());
    case wishlistScreenRoute:
      return MaterialPageRoute(builder: (_) => const WishlistScreen());
    case addNewAddressesScreenRoute:
      return MaterialPageRoute(builder: (_) => const AddNewAddressScreen());
    case paymentScreenRoute:
      return MaterialPageRoute(builder: (_) => const PaymentScreen());
    case selectLanguageScreenRoute:
      return MaterialPageRoute(builder: (_) => const SelectLanguageScreen());
    case 'category_screen':
      return MaterialPageRoute(builder: (_) => const CategoryScreen());
    default:
      return MaterialPageRoute(builder: (_) => const OnBordingScreen());
  }
}

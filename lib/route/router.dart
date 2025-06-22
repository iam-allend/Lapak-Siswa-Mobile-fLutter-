import 'package:flutter/material.dart';
import 'package:shop/entry_point.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/screens/address/views/add_new_address_screen.dart';
import 'package:shop/screens/order/views/order_detail_screen.dart';
import 'package:shop/screens/preferences/views/select_language_screen.dart';
import 'package:shop/screens/product/views/category_screen.dart';
import 'package:shop/screens/profile/views/profile_edit_screen.dart';
import 'package:shop/screens/profile/views/profile_view_screen.dart';
import 'package:shop/screens/order/views/orders_screen.dart';
import 'package:shop/screens/order/views/order_delivered_screen.dart';
import 'package:shop/screens/order/views/wishlist_screen.dart';
import 'package:shop/screens/splash/views/splash_screen.dart';
import 'package:shop/models/product_siswa_model.dart';
import 'screen_export.dart';
import 'package:shop/screens/payment/views/payment_screen.dart';

// Route name constants
const String profileEditScreenRoute = "profile_edit";
const String orderScreenRoute = "order_screen";
const String wishlistScreenRoute = "wishlist";
const String userInfoScreenRoute = "user_info";
const String paymentScreenRoute = "payment_screen";

Object generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case onbordingScreenRoute:
      return MaterialPageRoute(builder: (context) => const OnBordingScreen());
      return MaterialPageRoute(
        builder: (context) => const OnBordingScreen(),
      );
    // case preferredLanuageScreenRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => const PreferredLanguageScreen(),
    //   );
    
    case '/':
    return MaterialPageRoute(builder: (_) => const SplashScreen());
    case logInScreenRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case signUpScreenRoute:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case passwordRecoveryScreenRoute:
      return MaterialPageRoute(builder: (context) => const PasswordRecoveryScreen());
    case productDetailsScreenRoute:
    return MaterialPageRoute(
      builder: (context) {
        final product = settings.arguments as ProductSiswaModel;
        return ProductDetailsScreen(product: product);
      },
    );

    case productReviewsScreenRoute:
      return MaterialPageRoute(builder: (context) => const ProductReviewsScreen());
    case homeScreenRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case discoverScreenRoute:
      return MaterialPageRoute(builder: (context) => const DiscoverScreen());
    case onSaleScreenRoute:
      return MaterialPageRoute(builder: (context) => const OnSaleScreen());
    case kidsScreenRoute:
      return MaterialPageRoute(builder: (context) => const KidsScreen());
    case searchScreenRoute:
      return MaterialPageRoute(builder: (context) => const SearchScreen());
    case bookmarkScreenRoute:
      return MaterialPageRoute(builder: (context) => const BookmarkScreen());
    case entryPointScreenRoute:
      return MaterialPageRoute(builder: (context) => const EntryPoint());
    case profileScreenRoute:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());
    case userInfoScreenRoute:
      return MaterialPageRoute(builder: (context) => const UserInfoScreen());
    case notificationsScreenRoute:
      return MaterialPageRoute(builder: (context) => const NotificationsScreen());
    case noNotificationScreenRoute:
      return MaterialPageRoute(builder: (context) => const NoNotificationScreen());
    case enableNotificationScreenRoute:
      return MaterialPageRoute(builder: (context) => const EnableNotificationScreen());
    case notificationOptionsScreenRoute:
      return MaterialPageRoute(builder: (context) => const NotificationOptionsScreen());
    case addressesScreenRoute:
      return MaterialPageRoute(builder: (context) => const AddressesScreen());
    case ordersScreenRoute:
      return MaterialPageRoute(builder: (context) => const OrderScreen());
    case preferencesScreenRoute:
      return MaterialPageRoute(builder: (context) => const PreferencesScreen());
    case emptyWalletScreenRoute:
      return MaterialPageRoute(builder: (context) => const EmptyWalletScreen());
    case walletScreenRoute:
      return MaterialPageRoute(builder: (context) => const WalletScreen());
    case cartScreenRoute:
      return MaterialPageRoute(builder: (context) => const CartScreen());

    // Custom routes by Zikry
    case profileViewScreenRoute:
      return MaterialPageRoute(builder: (context) => const ProfileViewScreen());
    case profileEditScreenRoute:
      return MaterialPageRoute(builder: (context) => const ProfileEditScreen());
    case orderScreenRoute:
      return MaterialPageRoute(builder: (context) => const OrderScreen());
    case 'order_detail':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => OrderDetailScreen(
          title: args['title'],
          items: args['items'],
        ),
      );
    case deliveredOrdersScreenRoute:
      return MaterialPageRoute(builder: (context) => const OrderDeliveredScreen());
    case wishlistScreenRoute:
      return MaterialPageRoute(builder: (context) => const WishlistScreen());
    case addNewAddressesScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const AddNewAddressScreen(),
      );
    case paymentScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PaymentScreen(),
      );
    case selectLanguageScreenRoute:
        return MaterialPageRoute(
        builder: (context) => const SelectLanguageScreen(),
      );
    case 'category_screen':
        return MaterialPageRoute(
        builder: (context) => const CategoryScreen(),
      );
      case cartScreenRoute:
        return const CartScreen();





      

    // Default fallback
    default:
      return MaterialPageRoute(builder: (context) => const OnBordingScreen());
  }
}

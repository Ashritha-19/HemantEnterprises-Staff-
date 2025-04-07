import 'package:get/get.dart';
import 'package:hemantenterprisesstaff/bottomnavigation/bottomnavigation.dart';
import 'package:hemantenterprisesstaff/views/aboutUs.dart';
import 'package:hemantenterprisesstaff/views/authentication/loginauth.dart';
import 'package:hemantenterprisesstaff/views/brands/categories.dart';
import 'package:hemantenterprisesstaff/views/brands/subCategory.dart';
import 'package:hemantenterprisesstaff/views/topbar/customerquotes.dart';
import 'package:hemantenterprisesstaff/views/brands/home.dart';
import 'package:hemantenterprisesstaff/views/brands/listingpage.dart';
import 'package:hemantenterprisesstaff/views/authentication/login.dart';
import 'package:hemantenterprisesstaff/views/cart/quote.dart';
import 'package:hemantenterprisesstaff/views/topbar/searchresult.dart';
import 'package:hemantenterprisesstaff/views/splash/splashcontext.dart';
import 'package:hemantenterprisesstaff/views/splash/splashscreen.dart';
import 'package:hemantenterprisesstaff/views/brands/product.dart';
import 'package:hemantenterprisesstaff/views/cart/thankyou.dart';
import 'package:hemantenterprisesstaff/views/topbar/tollfree.dart';


class AppRoutes {
  static const splash = '/splash';
  static const next = '/next';
  static const createAccount = '/createAccount';
  static const login = '/login';
  static const loginVerification = '/loginVerification';
  static const home = '/home';
  static const productDetail = '/productDetail';
  static const category = '/category';
  static const subCategory = '/subCategory';
  static const listingPage = '/listingPage';
  static const bottomNavigation= '/bottomNavigation';
  static const quote = '/quote';
  static const aboutUs = '/aboutUs';
  static const search = '/search';
  static const thankyou = '/thankyou';
  static const customerQuotes= '/customerQuotes';
  static const tollFree = '/tollFree'; 

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: next,
      page: () => SplashContext(),
    ),
    // GetPage(
    //  name: createAccount,
    //  page: () => CreateAccountScreen(),
    // ),
    GetPage(
      name: login, 
      page: () => LoginScreen(),
    ),
    GetPage(
      name: loginVerification, 
      page: () => LoginVerification()
      ),
    GetPage(
      name: home, 
      page: () => HomeScreen()
      ),
    GetPage(
      name: subCategory, 
      page: () => SubCategoryScreen()
      ),   
    GetPage(
      name: category, 
      page: () => CategoryScreen()
      ),   
    GetPage(
      name: productDetail, 
      page: () => ProductScreen()
      ),
    GetPage(
      name: listingPage, 
      page: () => ListingPageScreen()
      ),  
    GetPage(
      name: bottomNavigation, 
      page: () => BottomNavigation()
      ), 
    GetPage(
      name: quote, 
      page: () => QuoteScreen()
      ), 
    GetPage(
      name: aboutUs, 
      page: () => AboutUsScreen()
      ), 
    GetPage(
      name: search, 
      page: () => SearchResultScreen()
      ),
    GetPage(
      name: thankyou, 
      page: () => ThankYouScreen()
      ),
    GetPage(
      name: customerQuotes, 
      page: () => CustomerQuotesScreen()
      ),
    GetPage(
      name: tollFree, 
      page: () => Tollfreenumbers()
      ),

  ];
}

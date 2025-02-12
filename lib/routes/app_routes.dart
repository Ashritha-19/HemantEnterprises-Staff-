import 'package:get/get.dart';
import 'package:hemantenterprisesstaff/bottomnavigation/bottomnavigation.dart';
import 'package:hemantenterprisesstaff/views/aboutUs.dart';
import 'package:hemantenterprisesstaff/views/brandDetails.dart';
import 'package:hemantenterprisesstaff/views/category.dart';
import 'package:hemantenterprisesstaff/views/createaccount.dart';
import 'package:hemantenterprisesstaff/views/customerquotes.dart';
import 'package:hemantenterprisesstaff/views/home.dart';
import 'package:hemantenterprisesstaff/views/listingpage.dart';
import 'package:hemantenterprisesstaff/views/login.dart';
import 'package:hemantenterprisesstaff/views/otp.dart';
import 'package:hemantenterprisesstaff/views/quote.dart';
import 'package:hemantenterprisesstaff/views/searchresult.dart';
import 'package:hemantenterprisesstaff/views/splashcontext.dart';
import 'package:hemantenterprisesstaff/views/splashscreen.dart';
import 'package:hemantenterprisesstaff/views/subcategory.dart';
import 'package:hemantenterprisesstaff/views/thankyou.dart';



class AppRoutes {
  static const splash = '/splash';
  static const next = '/next';
  static const createAccount = '/createAccount';
  static const login = '/login';
  static const verificationCode = '/verificationCode';
  static const home = '/home';
  static const brandDetails = '/brandDetails';
  static const category = '/category';
  static const subCategory = '/subCategory';
  static const listingPage = '/listingPage';
  static const bottomNavigation= '/bottomNavigation';
  static const quote = '/quote';
  static const aboutUs = '/aboutUs';
  static const search = '/search';
  static const thankyou = '/thankyou';
  static const customerQuotes= '/customerQuotes';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: next,
      page: () => SplashContext(),
    ),
    GetPage(
     name: createAccount,
     page: () => CreateAccountScreen(),
    ),
    GetPage(
      name: login, 
      page: () => LoginScreen(),
    ),
    GetPage(
      name: verificationCode, 
      page: () => VerificationCodeScreen()
      ),
    GetPage(
      name: home, 
      page: () => HomeScreen()
      ),
    GetPage(
      name: brandDetails, 
      page: () => BrandDetailsScreen()
      ),   
    GetPage(
      name: category, 
      page: () => CategoryScreen()
      ),   
    GetPage(
      name: subCategory, 
      page: () => SubCategoryScreen()
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

  ];
}

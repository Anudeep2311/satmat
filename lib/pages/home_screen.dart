import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newapp/models/banking_model.dart';
import 'package:newapp/models/utility_model.dart';
import 'package:newapp/pages/login_screen.dart';
import 'package:newapp/services/api/api_service.dart';
import 'package:newapp/services/auth_service.dart';
import 'package:newapp/theme/theme_data.dart';
import 'package:newapp/widgets/banking_container.dart';
import 'package:newapp/widgets/const_sizedbox.dart';
import 'package:newapp/widgets/utility_container.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<BankingModel> bankingModel = [
  const BankingModel(
    image: 'assets/withdraw.png',
    title: 'Cash\nWithdrawal',
  ),
  const BankingModel(
    image: 'assets/bankstatement.png',
    title: 'Mini\nStatement',
  ),
  const BankingModel(
    image: 'assets/cashicon.png',
    title: 'Balance\nCheck',
  ),
  const BankingModel(
    image: 'assets/cardicon.png',
    title: 'Aadhar\nCard',
  ),
  const BankingModel(
    image: 'assets/cashflow.png',
    title: 'DMT\nPayment',
  ),
  const BankingModel(
    image: 'assets/loan.png',
    title: 'Loans',
  ),
  const BankingModel(
    image: 'assets/bank.png',
    title: 'Axis Bank Ac\nOpen',
  ),
  const BankingModel(
    image: 'assets/ATM.png',
    title: 'MATM',
  ),
];
List<UtilityModel> utilityModel = [
  UtilityModel(image: 'assets/satellite.png', title: "DTH\nRecharge"),
  UtilityModel(image: 'assets/mobile.png', title: "Mobile\nRecharge"),
  UtilityModel(image: 'assets/healthinsurance.png', title: "LIC\nPayment"),
  UtilityModel(image: 'assets/lightning.png', title: "Electricity"),
  UtilityModel(image: 'assets/creditcard.png', title: "Credit Card\nPayment"),
  UtilityModel(image: 'assets/creditcard.png', title: "CC to CC\nPayment"),
  UtilityModel(image: 'assets/cashicon.png', title: "Manage Cash"),
  UtilityModel(image: 'assets/cardicon.png', title: "Pan Card\nService"),
  UtilityModel(image: 'assets/tollicon.png', title: "Fasttag\nPayment"),
  UtilityModel(image: 'assets/billicon.png', title: "Bill\nPayment")
];
List<IconData> listIcon = [
  Icons.home_filled,
  Icons.settings_accessibility_sharp,
  Icons.document_scanner_outlined,
  Icons.grid_view_outlined
];

int _bottomNavIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myColorScheme = themeData.colorScheme;
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.person_outline_sharp,
            color: Colors.black,
            size: 32,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var curPosi = await _getCurrentPosition();
            },
            icon: const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.play_disabled,
              color: Colors.white,
              size: 32,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: myColorScheme.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              margin: EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "999999999999",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "test@gmail.com",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "API",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onTap: () async {
                try {
                  var apiService = ApiService();
                  var response = await apiService.fetchApiResponse();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('API RESPONSE'),
                      content: Text(
                        response.toString(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text(
                        e.toString(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.support_agent_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Support",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "My Language",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.library_books_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Terms & Condition",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.privacy_tip_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Privacy Policies",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.mark_chat_unread_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "FAQ",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Share / Refer with Friend",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () async {
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              title: const Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              Container(
                height: height * 0.36,
                color: myColorScheme.primary,
                child: Column(
                  children: [
                    const SmallSizedBoxHeight(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: height * 0.085,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Roopay Wallet",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "₹ 0",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: height * 0.085,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "APES Wallet",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "₹ 0",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SmallSizedBoxHeight(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: height * 0.12,
                          width: width * 0.15,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.monetization_on_outlined,
                                color: Colors.white,
                                size: 32,
                              ),
                              Text(
                                "Topup",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.12,
                          width: width * 0.15,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.wallet,
                                color: Colors.white,
                                size: 32,
                              ),
                              Text(
                                "Payout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.12,
                          width: width * 0.15,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.qr_code,
                                color: Colors.white,
                                size: 32,
                              ),
                              Text(
                                "My QR\n Code",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.12,
                          width: width * 0.15,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.mobile_friendly_outlined,
                                color: Colors.white,
                                size: 32,
                              ),
                              Text(
                                "Activate\n Service",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8, top: 8),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Welcome To Roopay",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.31, right: 8, left: 8),
                height: height * 0.20,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: BorderSide.strokeAlignOutside,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: CarouselSlider(
                  items: [
                    Image.asset('assets/img1.jpg'),
                    Image.asset('assets/img2.jpg'),
                    Image.asset('assets/img3.jpg'),
                    Image.asset('assets/img4.jpg')
                  ],
                  options: CarouselOptions(
                    viewportFraction: 1,
                  ),
                ),
              ),
              BankingContainer(
                height: height,
                headerTitle: "Banking",
              ),
              UtilityContainer(
                height: height,
                utilityTitleHeader: 'Utility',
              ),
              Container(
                width: width,
                height: height * 0.20,
                margin: EdgeInsets.only(top: height * 1.29, left: 8, right: 8),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: BorderSide.strokeAlignOutside,
                      offset: Offset(0, 1.5),
                      spreadRadius: BorderSide.strokeAlignOutside,
                      blurStyle: BlurStyle.solid,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Travel Services",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SmallSizedBoxHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  'assets/busicon.png',
                                  fit: BoxFit.cover,
                                  color: myColorScheme.primary,
                                ),
                              ),
                              const Text(
                                "Bus\nBooking",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  'assets/trainicon.png',
                                  fit: BoxFit.cover,
                                  color: myColorScheme.primary,
                                ),
                              ),
                              const Text(
                                "Train\nBooking",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  'assets/flighticon.png',
                                  fit: BoxFit.cover,
                                  color: myColorScheme.primary,
                                ),
                              ),
                              const Text(
                                "Flight\nBooking",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 40,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: width,
                height: height * 0.18,
                margin: EdgeInsets.only(top: height * 1.51, left: 8, right: 8),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: BorderSide.strokeAlignOutside,
                      offset: Offset(0, 1.5),
                      spreadRadius: BorderSide.strokeAlignOutside,
                      blurStyle: BlurStyle.solid,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "E-Governance",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SmallSizedBoxHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/creditcard.png'),
                              const Text("PAN UTI")
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset('assets/creditcard.png'),
                              const Text("PAN NSDL")
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: width,
                height: height * 0.020,
                margin: EdgeInsets.only(top: height * 1.7),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        gapWidth: BorderSide.strokeAlignCenter,
        activeColor: myColorScheme.primary,
        iconSize: 34,
        icons: listIcon,
        activeIndex: _bottomNavIndex,
        onTap: (index) => setState(() {}),
      ),
    );
  }

  Future<Position?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    return null;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}";
      });
      debugPrint("Anudeep --> $_currentPosition --> $_currentAddress");
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

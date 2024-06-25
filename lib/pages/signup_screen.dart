import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/pages/home_screen.dart';
import 'package:newapp/services/auth_service.dart';
import 'package:newapp/widgets/const_sizedbox.dart';
import 'package:newapp/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _imagePicker = ImagePicker();
  File? _image;
  String? imagePath;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _setCurrentAddress();
  }

  Future<void> _setCurrentAddress() async {
    String? address = await _getCurrentPosition();
    if (address != null) {
      setState(() {
        _addressController.text = address;
      });
    }
  }

  Future<String?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String address =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      return address;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> _handleLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(Icons.add_a_photo, size: 40)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const MidSizedBoxHeight(),
                    CustomTextField(
                      controller: _usernameController,
                      labelText: 'Username',
                      obscureText: false,
                      textInputType: TextInputType.name,
                    ),
                    const MidSizedBoxHeight(),
                    CustomTextField(
                      controller: _mobileController,
                      labelText: 'Mobile Number',
                      obscureText: false,
                      textInputType: TextInputType.phone,
                    ),
                    const MidSizedBoxHeight(),
                    CustomTextField(
                      controller: _addressController,
                      labelText: 'Address',
                      obscureText: false,
                      textInputType: TextInputType.streetAddress,
                    ),
                    const MidSizedBoxHeight(),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const MidSizedBoxHeight(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          String imageUrl = '';
                          if (_image != null && imagePath != null) {
                            imageUrl = await authProvider
                                .uploadProfileImage(imagePath!);
                          }
                          await authProvider.signup(
                            _emailController.text,
                            _usernameController.text,
                            _mobileController.text,
                            _addressController.text,
                            _passwordController.text,
                            imageUrl,
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Signup Failed: $e')));
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

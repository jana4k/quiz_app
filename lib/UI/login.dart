import 'package:flutter/material.dart';
import 'package:myapp/UI/signup.dart';
import 'package:myapp/authentication/auth_exception.dart';
import 'package:myapp/authentication/auth_service.dart';
import 'package:myapp/widgets/loading_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2100a6),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupPage()));
              },
              child: Container(
                // margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(157, 248, 248, 248),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          title: const Text('Don\'t have an account?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2100a6),
                    Color.fromARGB(223, 33, 0, 166),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Background icons
                  Positioned(
                    top: 50,
                    left: -30,
                    child: Icon(
                      Icons.quiz,
                      size: 100,
                      color: Colors.lightBlueAccent.withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    child: Icon(
                      Icons.book,
                      size: 100,
                      color: Colors.lightBlueAccent.withOpacity(0.2),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 70),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 33,
                            backgroundImage: AssetImage(
                                'assets/images/file.jpg'), // Add your logo image in the assets folder
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Tekzow Courses',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
//                         Container(
//   width: 370, // Slightly larger to give a shadow effect
//   height: 10,
//   decoration: BoxDecoration(

//     color:  Color.fromARGB(90, 255, 255, 255),
//     borderRadius: const BorderRadius.only(
//       topLeft: Radius.circular(23),
//       topRight: Radius.circular(23),
//     ),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.9), // Shadow color with opacity
//         spreadRadius: 2, // How much the shadow spreads
//         blurRadius: 6, // How blurry the shadow is
//         offset: const Offset(0, 1), // Offset of the shadow
//       ),
//     ],
//   ),
// ),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(23),
                            topRight: Radius.circular(23),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'Welcome back',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Enter your login credentials',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 50),
                            _buildTextField(
                              controller: _emailController,
                              labelText: 'Email',
                            ),
                            const SizedBox(height: 30),
                            _buildTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              obscureText: true,
                            ),
                            const SizedBox(height: 50),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _login();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff2100a6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                textStyle: const TextStyle(fontSize: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              // icon: const Icon(Icons.check),
                              child: const Text('Login'),
                            ),
                            const SizedBox(height: 30),
                            TextButton(
                              onPressed: () {
                                _forgotPassword();
                              },
                              child: const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text(
//                       'Login here',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff2100a6),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: const AssetImage(
            //       'assets/images/file.jpg'), // Add your logo image in the assets folder
            //   backgroundColor: Colors.transparent,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(
            //         color: const Color(0xff2100a6),
            //         width: 4.0,
            //       ),
            //     ),
            //   ),
            // ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),

            //         ],
            //       ),
            //     ),
            //   ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hoverColor: Colors.black,
        focusColor: Colors.black,
        fillColor: Colors.black,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        labelStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }

  void _login() {
    LoadingDialog.show(context);
    AuthService()
        .loginWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((status) {
      if (status == AuthResultStatus.successful) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login successful')));
        LoadingDialog.hide(context);
      } else {
        LoadingDialog.hide(context);
        String error = AuthExceptionHandler.generateExceptionMessage(status);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    });
  }

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController resetEmailController = TextEditingController();

        return AlertDialog(
          title: const Text('Forgot Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your email to reset your password:'),
              const SizedBox(height: 10),
              TextField(
                controller: resetEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Color(0xff2100a6),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff2100a6),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black54)),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await AuthService()
                      .sendPasswordResetEmail(resetEmailController.text);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent')),
                  );
                } catch (error) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error.toString())),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2100a6),
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

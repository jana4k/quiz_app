import 'package:flutter/material.dart';
import 'package:myapp/authentication/auth_exception.dart';
import 'package:myapp/authentication/auth_service.dart';
import 'package:myapp/authentication/auth_wrapper.dart';
import 'package:myapp/widgets/loading_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signup() {
    LoadingDialog.show(context);
    AuthService()
        .signUpWithEmailAndPassword(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((status) {
      LoadingDialog.hide(context);

      if (status == AuthResultStatus.successful) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthenticationWrapper(),
          ),
        );
      } else {
        String error = AuthExceptionHandler.generateExceptionMessage(status);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }).catchError((error) {
      LoadingDialog.hide(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff2100a6),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                // margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(157, 248, 248, 248),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '   Sign In   ',
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
          title: const Text('Already have an account?',
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
                      const SizedBox(height: 60),
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
                      const SizedBox(height: 60),
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
                              height: 20,
                            ),
                            const Text(
                              'Get Strated',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Enter your Required credentials to continue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 40),
                            _buildTextField(
                              controller: _nameController,
                              labelText: 'Name',
                            ),
                            const SizedBox(height: 25),
                            _buildTextField(
                              controller: _emailController,
                              labelText: 'Email',
                            ),
                            const SizedBox(height: 25),
                            _buildTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              obscureText: true,
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _signup();
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
                              child: const Text('Sign Up'),
                            ),
                            const SizedBox(height: 5),
                            // TextButton(
                            //   onPressed: () {
                            //     // _forgotPassword();
                            //   },
                            //   child: const Text(
                            //     'Forgot your password?',
                            //     style: TextStyle(
                            //       color: Colors.black87,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
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
  // Widget build(BuildContext context) {
  //  return SafeArea(
  //     child: Scaffold(
  //       body: SingleChildScrollView(
  //         child: Form(
  //           key: _formKey,
  //           child: Center(
  //             child: Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   const Text(
  //                     'Login here',
  //                     style: TextStyle(
  //                       fontSize: 24,
  //                       fontWeight: FontWeight.bold,
  //                       color: Color(0xff2100a6),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Stack(
  //                     alignment: Alignment.center,
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 50,
  //                         backgroundImage: const AssetImage(
  //                             'assets/images/file.jpg'), // Add your logo image in the assets folder
  //                         backgroundColor: Colors.transparent,
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             border: Border.all(
  //                               color: const Color(0xff2100a6),
  //                               width: 4.0,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 20),
  //                   const Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 60),
  //                     child: Text(
  //                       'Create an account so you can explore all the quiz',
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.normal,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 20),
  //                   _buildTextField(
  //                     controller: _nameController,
  //                     labelText: 'Name',

  //                   ),
  //                   const SizedBox(height: 20),
  //                   _buildTextField(
  //                     controller: _emailController,
  //                     labelText: 'Email',

  //                   ),
  //                   const SizedBox(height: 20),
  //                   _buildTextField(
  //                     controller: _passwordController,
  //                     labelText: 'Password',

  //                     obscureText: true,
  //                   ),
  //                   const SizedBox(height: 20),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       if (_formKey.currentState!.validate()) {
  //                         _signup();
  //                       }
  //                     },

  //                     child: const Text('Sign Up'),
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor:  Color(0xff2100a6),
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 30, vertical: 15),
  //                       textStyle: const TextStyle(fontSize: 18),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                   ),
  //                   // const SizedBox(height: 10),
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Text(
  //                       'Already have an account',
  //                       style: TextStyle(
  //                           color: Color(0xff2100a6),
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullStack extends StatefulWidget {
  const FullStack({super.key});

  @override
  State<FullStack> createState() => _FullStackState();
}

class _FullStackState extends State<FullStack>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffcc2b5e),
                Color(0xff753a88),
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
                left: 20,
                child: Icon(
                  Icons.school_rounded,
                  size: 100,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: 20,
                child: Icon(
                  Icons.auto_awesome,
                  size: 100,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 80),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Full Stack \n Development',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Transforming ideas into reality with seamless front-end and powerful back-end development.',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TabBar(
                            controller: _tabController,
                            dividerColor: Colors.white,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black54,
                            indicatorColor: Colors.black,
                            tabs: const [
                              Tab(text: 'Syllabus'),
                              Tab(text: 'Benefits'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 500,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // const Text(
                                      //   'Full Stack Development Syllabus',
                                      //   style: TextStyle(
                                      //     fontSize: 18,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      const SizedBox(height: 10),
                                      _buildSyllabusModule(
                                        'Module 1: Frontend',
                                        subtopics: [
                                          'HTML',
                                          'CSS',
                                          'JavaScript',
                                          'Angular',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 2: Database',
                                        subtopics: [
                                          'MySql/Oracle',
                                          'MongoDb',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 3: Backend',
                                        subtopics: [
                                          'Java',
                                          'C',
                                          'Python',
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 160,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          'Benefits of this course',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffcc2b5e),
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ListTile(
                                        leading: Icon(Icons.trending_up,
                                            color: Colors.blueAccent),
                                        title: Text(
                                          'High Demand for Full Stack Developers',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.build,
                                            color: Colors.green),
                                        title: Text(
                                          'Versatile Skill Set',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.work,
                                            color: Colors.orange),
                                        title: Text(
                                          'Better Job Prospects',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.attach_money,
                                            color: Colors.teal),
                                        title: Text(
                                          'Higher Salaries',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.school,
                                            color: Colors.purple),
                                        title: Text(
                                          'Comprehensive Understanding of Development',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.swap_horiz,
                                            color: Colors.redAccent),
                                        title: Text(
                                          'Flexibility in Career Options',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                        Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 19),
                                        child: Text(
                                          'Certificate',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ListTile(
                                        leading: Icon(Icons.verified,
                                            color: Colors.blue),
                                        title: Text(
                                          'FULL STACK DEVELOPMENT CERTIFICATION',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Your Path to Certification Begins Here',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ListTile(
                                        leading: Icon(Icons.public,
                                            color: Colors.blue),
                                        title: Text(
                                          'Globally Recognized Credential',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          'Earn a certificate recognized by worldwide and prestige.',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.share,
                                            color: Colors.green),
                                        title: Text(
                                          'Shareable Certificate',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          'Add your certification to your LinkedIn profile and resume.',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.verified_user,
                                            color: Colors.orange),
                                        title: Text(
                                          'Verifiable Achievement',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          'Your certification can be authenticated, enhancing the credibility of your credentials.',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     // Add your action here
                                      //   },
                                      //   style: ElevatedButton.styleFrom(
                                      //     padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(12.0),
                                      //     ),
                                      //     backgroundColor: Colors.deepPurple,
                                      //   ),
                                      //   child: const Text(
                                      //     'Learn More',
                                      //     style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: 16,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSyllabusModule(String title, {List<String>? subtopics}) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffcc2b5e),
                ),
              ),
              if (subtopics != null)
                ...subtopics.map((subtopic) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '- $subtopic',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

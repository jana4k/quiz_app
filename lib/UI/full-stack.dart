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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      SizedBox(height: 150,)
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
                                      Text(
                                        'Benefits Content',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '1. High Demand for Full Stack Developers\n'
                                        '2. Versatile Skill Set\n'
                                        '3. Better Job Prospects\n'
                                        '4. Higher Salaries\n'
                                        '5. Comprehensive Understanding of Development\n'
                                        '6. Flexibility in Career Options',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
    return Container(width: double.infinity,
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
                  color:    Color(0xffcc2b5e),
                ),
              ),
              if (subtopics != null) ...subtopics.map((subtopic) => Padding(
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

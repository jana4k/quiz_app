import 'package:flutter/material.dart';

class EthicalHacking extends StatefulWidget {
  const EthicalHacking({super.key});

  @override
  State<EthicalHacking> createState() => _EthicalHackingState();
}

class _EthicalHackingState extends State<EthicalHacking>
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
                Color(0xff1488CC),
                Color(0xff2B32B2),
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
                          'Ethical Hacking',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                            style: TextStyle(color: Colors.white),
                            'Securing the digital world, one vulnerability at a time.'),
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
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black54,
                            indicatorColor: Colors.black,
                            dividerColor: Colors.white,
                            tabs: const [
                              Tab(text: 'Syllabus'),
                              Tab(text: 'Benefits'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 500, // Set a fixed height for TabBarView
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
                                      //   'Ethical Hacking Syllabus',
                                      //   style: TextStyle(
                                      //     fontSize: 18,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      const SizedBox(height: 5),
                                      _buildSyllabusModule(
                                        'Module 1: Principles of Hacking & Legal Parameters',
                                        subtopics: [
                                          'Ethical Hacking Overviews',
                                          'Principles of Ethical hacking',
                                          'Hacking Methodologies',
                                          'Role of Ethical Hacker',
                                          'Scope & limitations of hacking.',
                                          'Cyber Threats and Attacks Vectors',
                                          'Hacking tools and techniques',
                                          'Policies and Controls',
                                          'Overview of PT / VA',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 2: Viruses, Trojans, Malwares, and OS Level Attacks and Counter Measures. Malware Analysis.',
                                        subtopics: [
                                          'Malware Overviews',
                                          'Virus Worm & Trojan Concepts',
                                          'Malware Analysis',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 3: Footprinting, Enumeration, Scanning, Sniffing, Social Engineering',
                                        subtopics: [
                                          'Footprinting through Search Engines, Web Services',
                                          'Footprinting through Web Services',
                                          'Enumeration',
                                          'Scanning targets',
                                          'Sniffing Network',
                                          'Social Engineering',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 4: SQL Injection, DOS Attacks, Session Hijacking, and System Hacking',
                                        subtopics: [
                                          'SQL Injection',
                                          'DOS Attacks',
                                          'Session Hijacking',
                                          'System Hacking',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 5: Web Applications and Web Servers Attacking Methodology and Countermeasures',
                                        subtopics: [
                                          'Basics to Web application & threats',
                                          'OWASP Top 10 Application Security Risks',
                                          'Web Hacking methodology and tools',
                                          'Introduction to Web Server',
                                          'Counter measures',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 6: IoT and Cloud Attacks and Defense Mechanisms',
                                        subtopics: [
                                          'IOT Concept and Attacks',
                                          'Cloud Computing Overview',
                                          'Threats and attack in Cloud',
                                          'Cloud Security and tool',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 7: Mobile & Wireless Networks Hacking and Counter Measures',
                                        subtopics: [
                                          'Mobile Hacking',
                                          'Wireless Overview',
                                          'Wireless Hacking Methodology',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 8: Firewall, IDS and Honeypot Evasion Techniques, Evasion Tools, and Countermeasures',
                                        subtopics: [
                                          'Basics of Firewalls, IDS, Honeypots',
                                          'IDS/Firewall/Honeypot Evasion Techniques',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 9: Cryptology, Vulnerability Analysis, Logging and Audit',
                                        subtopics: [
                                          'Introduction to Cryptography Concepts',
                                          'Encryption Algorithms',
                                          'Email, Disk Encryption and Cryptanalysis',
                                          'Vulnerability Analysis',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 10: Capture the flag [CTF]',
                                        subtopics: [
                                          'Bandit Overthewire [WarGame]',
                                          'Natas Overthewire [WarGame]',
                                          'Mr. Robot',
                                        ],
                                      ),
                                      const SizedBox(height: 160),
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
                                            horizontal: 20),
                                        child: Text(
                                          'Benefits of this course',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff2B32B2),
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ListTile(
                                        leading: Icon(Icons.security,
                                            color: Colors.blueAccent),
                                        title: Text(
                                          'Critical Role in Cybersecurity',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.lock_open,
                                            color: Colors.green),
                                        title: Text(
                                          'Understanding of Security Threats',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.build,
                                            color: Colors.orange),
                                        title: Text(
                                          'Problem-Solving and Analytical Skills',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.laptop,
                                            color: Colors.teal),
                                        title: Text(
                                          'High Demand for Cybersecurity Professionals',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.shield,
                                            color: Colors.purple),
                                        title: Text(
                                          'Contribution to Ethical Practices',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.network_check,
                                            color: Colors.redAccent),
                                        title: Text(
                                          'Skills in Network and System Security',
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
                                          'ETHICAL HACKING CERTIFICATION',
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
                                      //     padding: const EdgeInsets.symmetric(
                                      //         vertical: 12.0, horizontal: 24.0),
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius:
                                      //           BorderRadius.circular(12.0),
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
                color: Color(0xff2B32B2),
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

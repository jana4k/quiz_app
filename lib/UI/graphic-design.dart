import 'package:flutter/material.dart';

class GraphicDesign extends StatefulWidget {
  const GraphicDesign({super.key});

  @override
  State<GraphicDesign> createState() => _GraphicDesignState();
}

class _GraphicDesignState extends State<GraphicDesign>
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
                Color(0xffFFB75E),
                Color(0xffED8F03),
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
                          'Graphic Designing',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                            style: TextStyle(color: Colors.white),
                            'Crafting visual stories that captivate and inspire.'),
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
                            dividerColor: Colors.white,
                            controller: _tabController,
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
                                      //   'Graphic Design Syllabus',
                                      //   style: TextStyle(
                                      //     fontSize: 18,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      const SizedBox(height: 10),
                                      _buildSyllabusModule(
                                        'Module 1: Introduction to Graphic Design',
                                      ),
                                      _buildSyllabusModule(
                                        'Module 2: Graphic Designing Essentials',
                                        subtopics: [
                                          'Image Editing with Adobe Photoshop - Introduction',
                                          'Basics of Images',
                                          'Learning Colors',
                                          'Working with Selection Tools',
                                          'Working with Painting Tools and Brush Settings',
                                          'More on Layers',
                                          'Working with Texts',
                                          'Digital Drawing with Photoshop',
                                          'More on Colors - Channels',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 3: Advanced Tools for Image Manipulation',
                                      ),
                                      _buildSyllabusModule(
                                        'Module 4: Advanced Tools for Image Correction',
                                      ),
                                      _buildSyllabusModule(
                                        'Module 5: Working with Digital Photographs',
                                      ),
                                      _buildSyllabusModule(
                                        'Module 6: Illustrations with Adobe Illustrator - Introduction',
                                        subtopics: [
                                          'Basics of Adobe Illustrator',
                                          'Navigating in Adobe Illustrator',
                                          'Understanding Artboards',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 7: Working with Shapes',
                                        subtopics: [
                                          'Selecting, Combining and Aligning Shapes',
                                          'Managing Shapes and Objects',
                                          'Applying Transformations',
                                          'Managing the Object Appearance',
                                          'Saving and Exporting Swatches',
                                          'Applying Effects',
                                          'Working with Text',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 8: Working with Drawing Tools',
                                      ),
                                      _buildSyllabusModule(
                                        'Module 9: Managing Brushes for Advanced Drawing',
                                        subtopics: [
                                          'Managing Images in Illustrator',
                                          'Advanced Features of Illustrator',
                                        ],
                                      ),
                                      _buildSyllabusModule(
                                        'Module 10: Working with Graph',
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
                                            horizontal: 20),
                                        child: Text(
                                          'Benefits of this course',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffFFB75E),
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ListTile(
                                        leading: Icon(Icons.brush,
                                            color: Colors.blueAccent),
                                        title: Text(
                                          'Creative Expression and Artistic Freedom',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.design_services,
                                            color: Colors.green),
                                        title: Text(
                                          'Diverse Career Opportunities',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.palette,
                                            color: Colors.orange),
                                        title: Text(
                                          'Skill Development in Design Tools',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.visibility,
                                            color: Colors.teal),
                                        title: Text(
                                          'High Demand for Visual Content',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.people,
                                            color: Colors.purple),
                                        title: Text(
                                          'Collaboration with Creative Teams',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.web,
                                            color: Colors.redAccent),
                                        title: Text(
                                          'Opportunities in Digital Media and Web Design',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(height: 20),
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
                color: Color(0xffED8F03),
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

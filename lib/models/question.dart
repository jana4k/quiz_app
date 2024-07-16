import 'package:cloud_firestore/cloud_firestore.dart';

// final List<Question> questions = [
//   // Python Questions
//   Question(
//     id: '1',
//     text: 'Which of the following methods can be used to read the entire contents of a file as a string in Python?',
//     options: ['file.read_all()', 'file.readlines()', 'file.read()', 'file.read_file()'],
//     answerIndex: 2,
//     category: 'Python',
//   ),
//   Question(
//     id: '2',
//     text: 'What is the output of the following code?\n\n```python\ndef func(a, b=[]):\n    b.append(a)\n    return b\n\nprint(func(1))\nprint(func(2))```',
//     options: ['[1] [2]', '[1, 1, 2]', '[1, 1] [2, 2]', '[1, 2] [1, 2]'],
//     answerIndex: 1,
//     category: 'Python',
//   ),
//   Question(
//     id: '3',
//     text: 'Which of the following is true about the `with` statement in Python?',
//     options: ['It is used to handle exceptions.', 'It is used to handle files.', 'It ensures proper acquisition and release of resources.', 'It is used for loops.'],
//     answerIndex: 2,
//     category: 'Python',
//   ),
//   Question(
//     id: '4',
//     text: 'What will be the output of the following code?\n\n```python\nclass A:\n    def __init__(self):\n        self.value = 10\n\nclass B(A):\n    def __init__(self):\n        super().__init__()\n        self.value += 5\n\nb = B()\nprint(b.value)```',
//     options: ['5', '10', '15', 'None of the above'],
//     answerIndex: 2,
//     category: 'Python',
//   ),
//   Question(
//     id: '5',
//     text: 'Which of the following is not a built-in data type in Python?',
//     options: ['list', 'tuple', 'dictionary', 'set'],
//     answerIndex: 2,
//     category: 'Python',
//   ),
//   // Java Questions
//   Question(
//     id: '6',
//     text: 'What is the output of the following code?\n\n```java\npublic class Test {\n    public static void main(String[] args) {\n        int[] arr = {1, 2, 3, 4};\n        System.out.println(arr[2]);\n    }\n}```',
//     options: ['1', '2', '3', '4'],
//     answerIndex: 2,
//     category: 'Java',
//   ),
//   Question(
//     id: '7',
//     text: 'Which of the following is not a feature of Java?',
//     options: ['Object-oriented', 'Use of pointers', 'Platform-independent', 'Robust'],
//     answerIndex: 1,
//     category: 'Java',
//   ),
//   Question(
//     id: '8',
//     text: 'What is the output of the following code?\n\n```java\npublic class Test {\n    public static void main(String[] args) {\n        String str = "Hello";\n        str = str + " World";\n        System.out.println(str);\n    }\n}```',
//     options: ['Hello', 'World', 'Hello World', 'HelloWorld'],
//     answerIndex: 2,
//     category: 'Java',
//   ),
//   Question(
//     id: '9',
//     text: 'Which of the following is used to create an instance of an object in Java?',
//     options: ['new()', 'create()', 'new', 'instantiate'],
//     answerIndex: 2,
//     category: 'Java',
//   ),
//   Question(
//     id: '10',
//     text: 'Which of the following statements is true about Java exception handling?',
//     options: ['try block must be followed by catch or finally block.', 'try block does not require a catch or finally block.', 'Multiple try blocks can be used within a catch block.', 'A catch block can follow another catch block without a try block.'],
//     answerIndex: 0,
//     category: 'Java',
//   ),
//   // Aptitude Questions
//   Question(
//     id: '11',
//     text: 'What is the next number in the series: 2, 6, 12, 20, 30, ...?',
//     options: ['40', '42', '44', '46'],
//     answerIndex: 0,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '12',
//     text: 'If a train travels at 60 km/h and covers a distance in 1.5 hours, what is the distance covered by the train?',
//     options: ['60 km', '90 km', '100 km', '120 km'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '13',
//     text: 'A person spends 40% of their salary on rent, 30% on food, and saves the rest. If their salary is \$5000, how much do they save?',
//     options: ['\$1000', '\$1500', '\$2000', '\$2500'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '14',
//     text: 'What is the value of x in the equation \(3x + 5 = 20\)?',
//     options: ['3', '4', '5', '6'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '15',
//     text: 'If the ratio of the ages of two persons is 4:5 and the elder one is 5 years older than the younger one, what are their ages?',
//     options: ['20 and 25', '16 and 20', '24 and 30', '12 and 15'],
//     answerIndex: 3,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '16',
//     text: 'Which of the following is not a prime number?',
//     options: ['2', '3', '4', '5'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '17',
//     text: 'If the perimeter of a square is 40 cm, what is the area of the square?',
//     options: ['100 sq cm', '120 sq cm', '160 sq cm', '200 sq cm'],
//     answerIndex: 0,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '18',
//     text: 'What is the smallest number that is divisible by both 12 and 18?',
//     options: ['36', '48', '54', '72'],
//     answerIndex: 3,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '19',
//     text: 'If a sum of money doubles itself in 5 years at simple interest, what is the annual rate of interest?',
//     options: ['10%', '15%', '20%', '25%'],
//     answerIndex: 3,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '20',
//     text: 'In a class of 60 students, 40% are girls. How many boys are there in the class?',
//     options: ['24', '36', '40', '42'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '21',
//     text: 'A man walks 5 km north, then 3 km east, and finally 2 km south. How far is he from the starting point?',
//     options: ['5 km', '6 km', '7 km', '8 km'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '22',
//     text: 'The average of five consecutive even numbers is 24. What is the largest of these numbers?',
//     options: ['22', '24', '26', '28'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '23',
//     text: 'If \(a = 3\) and \(b = 4\), what is the value of \(a^2 + b^2\)?',
//     options: ['7', '12', '16', '25'],
//     answerIndex: 3,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '24',
//     text: 'A rectangle has a length of 10 cm and a width of 5 cm. What is the perimeter of the rectangle?',
//     options: ['20 cm', '25 cm', '30 cm', '35 cm'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '25',
//     text: 'If 8 workers can complete a job in 10 days, how many days will it take 4 workers to complete the same job?',
//     options: ['15 days', '20 days', '25 days', '30 days'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '26',
//     text: 'If the sum of two numbers is 40 and their difference is 10, what are the numbers?',
//     options: ['15 and 25', '20 and 30', '25 and 35', '30 and 40'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '27',
//     text: 'A car travels 150 km in 2 hours and 30 minutes. What is the average speed of the car?',
//     options: ['50 km/h', '55 km/h', '60 km/h', '65 km/h'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '28',
//     text: 'If the selling price of an item is \$120 and the profit made on it is \$20, what is the cost price of the item?',
//     options: ['80', '90', '100', '110'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '29',
//     text: 'If the sum of the angles of a triangle is 180 degrees, what is the measure of each angle in an equilateral triangle?',
//     options: ['45 degrees', '60 degrees', '90 degrees', '120 degrees'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '30',
//     text: 'If a cube has a side length of 4 cm, what is the volume of the cube?',
//     options: ['16 cubic cm', '32 cubic cm', '64 cubic cm', '128 cubic cm'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   // CyberSecurity Questions
//   Question(
//     id: '31',
//     text: 'Which one of the following can be considered as the class of computer threats?',
//     options: ['Dos Attack', 'Phishing', 'Soliciting', 'Both A and C'],
//     answerIndex: 3,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '32',
//     text: 'Which of the following usually observe each activity on the internet of the victim, gather all information in the background, and send it to someone else?',
//     options: ['Malware', 'Spyware', 'Adware', 'All of the above'],
//     answerIndex: 1,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '33',
//     text: 'Which of the following refers to stealing one\'s idea or invention of others and use it for their own benefits?',
//     options: ['Piracy', 'Plagiarism', 'Intellectual property rights', 'All of the above'],
//     answerIndex: 3,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '34',
//     text: 'Which of the following refers to exploring the appropriate, ethical behaviors related to the online environment and digital media platform?',
//     options: ['Cyber low', 'Cyberethics', 'Cybersecurity', 'Cybersafety'],
//     answerIndex: 1,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '35',
//     text: 'In system hacking, which of the following is the most crucial activity?',
//     options: ['Information gathering', 'Covering tracks', 'Cracking passwords', 'None of the above'],
//     answerIndex: 2,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '36',
//     text: 'Code Red is a type of ________',
//     options: ['An Antivirus Program', 'A photo editing software', 'A computer virus', 'A video editing software'],
//     answerIndex: 2,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '37',
//     text: 'Which of the following are famous and common cyber-attacks used by hackers to infiltrate the user\'s system?',
//     options: ['DDos and Derive-by Downloads', 'Malware & Malvertising', 'Phishing and Password attacks', 'All of the above'],
//     answerIndex: 3,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '38',
//     text: 'When was the first computer virus created?',
//     options: ['1970', '1971', '1972', '1969'],
//     answerIndex: 1,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '39',
//     text: 'In order to ensure the security of the data/ information, we need to ____________ the data:',
//     options: ['Encrypt', 'Decrypt', 'Delete', 'None of the above'],
//     answerIndex: 0,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '40',
//     text: 'Name of the Hacker who breaks the SIPRNET system?',
//     options: ['John Draper', 'Kevin Mitnick', 'John von Neumann', 'Kevin Poulsen'],
//     answerIndex: 3,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '41',
//     text: 'In the computer networks, the encryption techniques are primarily used for improving the ________',
//     options: ['Security', 'Performance', 'Reliability', 'Longevity'],
//     answerIndex: 0,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '42',
//     text: 'Hackers usually used the computer virus for ______ purpose.',
//     options: ['To log, monitor each and every user\'s stroke', 'To gain access the sensitive information like user\'s Id and Passwords', 'To corrupt the user\'s data stored in the computer system', 'All of the above'],
//     answerIndex: 3,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '43',
//     text: 'Which of the following can be considered as the elements of cyber security?',
//     options: ['Application Security', 'Operational Security', 'Network Security', 'All of the above'],
//     answerIndex: 3,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '44',
//     text: 'Which of the following are the types of scanning?',
//     options: ['Network, vulnerability, and port scanning', 'Port, network, and services', 'Client, Server, and network', 'None of the above'],
//     answerIndex: 0,
//     category: 'CyberSecurity',
//   ),
//   Question(
//     id: '45',
//     text: 'Which of the following is not a type of scanning?',
//     options: ['Xmas Tree Scan', 'Cloud scan', 'Null Scan', 'SYN Stealth'],
//     answerIndex: 1,
//     category: 'CyberSecurity',
//   ),

//   // Aptitude Questions
//   Question(
//     id: '46',
//     text: 'A person crosses a 600 m long street in 5 minutes. What is his speed in km per hour?',
//     options: ['3.6', '7.2', '8.4', '10'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '47',
//     text: 'A train can travel 50% faster than a car. Both start from point A at the same time and reach point B 75 kms away from A at the same time. On the way, however, the train lost about 12.5 minutes while stopping at the stations. The speed of the car is:',
//     options: ['100 kmph', '110 kmph', '120 kmph', '130 kmph'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '48',
//     text: 'Look at this series: 2, 1, (1/2), (1/4), ... What number should come next?',
//     options: ['(1/3)', '(1/8)', '(2/8)', '(1/16)'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '49',
//     text: 'Look at this series: 53, 53, 40, 40, 27, 27, ... What number should come next?',
//     options: ['12', '14', '27', '53'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '50',
//     text: 'The cost price of 20 articles is the same as the selling price of x articles. If the profit is 25%, then the value of x is:',
//     options: ['15', '16', '18', '25'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '51',
//     text: 'A vendor bought toffees at 6 for a rupee. How many for a rupee must he sell to gain 20%?',
//     options: ['3', '4', '5', '6'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '52',
//     text: 'Select a figure from amongst the Answer Figures which will continue the same series as established by the five Problem Figures.\n\nProblem Figures:                          Answer Figures:\n\n ',
//     options: ['1', '2', '3', '4', '5'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '53',
//     text: 'In the first 10 overs of a cricket game, the run rate was only 3.2. What should be the run rate in the remaining 40 overs to reach the target of 282 runs?',
//     options: ['6.25', '6.5', '6.75', '7'],
//     answerIndex: 0,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '54',
//     text: 'A grocer has a sale of Rs. 6435, Rs. 6927, Rs. 6855, Rs. 7230 and Rs. 6562 for 5 consecutive months. How much sale must he have in the sixth month so that he gets an average sale of Rs. 6500?',
//     options: ['Rs. 4991', 'Rs. 5991', 'Rs. 6001', 'Rs. 6991'],
//     answerIndex: 0,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '55',
//     text: 'The average of 20 numbers is zero. Of them, at the most, how many may be greater than zero?',
//     options: ['0', '1', '10', '19'],
//     answerIndex: 3,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '56',
//     text: '3, 5, 11, 14, 17, 21',
//     options: ['21', '17', '14', '3'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '57',
//     text: '8, 27, 64, 100, 125, 216, 343',
//     options: ['27', '100', '125', '343'],
//     answerIndex: 1,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '58',
//     text: '10, 25, 45, 54, 60, 75, 80',
//     options: ['10', '45', '54', '75'],
//     answerIndex: 2,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '59',
//     text: 'If A = x% of y and B = y% of x, then which of the following is true?',
//     options: ['A is smaller than B.', 'A is greater than B', 'Relationship between A and B cannot be determined.', 'If x is smaller than y, then A is greater than B.', 'None of these'],
//     answerIndex: 4,
//     category: 'Aptitude',
//   ),
//   Question(
//     id: '60',
//     text: 'If A is the brother of B; B is the sister of C; and C is the father of D, how D is related to A?',
//     options: ['Brother', 'Sister', 'Nephew', 'Cannot be determined'],
//     answerIndex: 3,
//     category: 'Aptitude',
//   ),
// ];
//   final List<Question> questions = [
//   Question(
//     id: '61',
//     text: 'HTML is considered as',
//     options: ['Programming language', 'OOP language', 'High level language', 'Markup language'],
//     answerIndex: 3,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '62',
//     text: 'HTML uses',
//     options: ['User-defined tags', 'Predefined tags', 'Fixed tags defined by the language', 'Tags for links only'],
//     answerIndex: 2,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '63',
//     text: 'If we want to set the style for just one element, which css selector will we use',
//     options: ['id', 'text', 'class', 'name'],
//     answerIndex: 0,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '64',
//     text: 'The HTML tag that specifies a CSS style embedded in an element is called',
//     options: ['Design', 'Style', 'Modify', 'Define'],
//     answerIndex: 1,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '65',
//     text: 'The HTML standard which does not require double quotes around the values of an attribute is called',
//     options: ['HTML 1', 'HTML 3', 'HTML 5', 'HTML 7'],
//     answerIndex: 2,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '66',
//     text: 'Which tag is used to list items with bullets',
//     options: ['<bullet>...</bullet>', '<list>...</list>', '<ul>...</ul>', '<ol>...</ol>'],
//     answerIndex: 2,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '67',
//     text: 'In how many ways can CSS be written in',
//     options: ['1', '2', '3', '4'],
//     answerIndex: 2,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '68',
//     text: 'How can we change the background color of an element',
//     options: ['background-color', 'color', 'Both A and B', 'None of the above'],
//     answerIndex: 0,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '69',
//     text: 'Which HTML tag is used to declare internal CSS',
//     options: ['<link>', '<script>', '<style>', 'None of the above'],
//     answerIndex: 2,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '70',
//     text: 'Which of the following are valid CSS position property values',
//     options: ['static', 'relative', 'fixed', 'All of the above'],
//     answerIndex: 3,
//     category: 'HTML-and-CSS',
//   ),
//   Question(
//     id: '71',
//     text: 'Which type of JavaScript language is',
//     options: ['Object-Oriented', 'Object-Based', 'Assembly-language', 'High-level'],
//     answerIndex: 1,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '72',
//     text: 'Which of the following is the correct output for the following JavaScript code\n\n```javascript\nvar x=5,y=1;\nvar obj = { x:10 };\nwith(obj) {\n  alert(y);\n}\n```',
//     options: ['Error', '10', '1', '5'],
//     answerIndex: 2,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '73',
//     text: 'Which one of the following also known as Conditional Expression',
//     options: ['Alternative to if-else', 'Switch statement', 'if-then-else statement', 'immediate if'],
//     answerIndex: 3,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '74',
//     text: 'In JavaScript, what is a block of statement',
//     options: ['Conditional block', 'Block that combines a number of statements into a single compound statement', 'Both conditional block and single statement', 'Block that contains a single statement'],
//     answerIndex: 1,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '75',
//     text: 'When interpreter encounters an empty statement, what it will do',
//     options: ['Shows a warning', 'Prompts to complete the statement', 'Throws an error', 'Ignores the statement'],
//     answerIndex: 3,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '76',
//     text: 'The "function" and "var" are known as',
//     options: ['Keywords', 'Data types', 'Declaration statements', 'Prototypes'],
//     answerIndex: 2,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '77',
//     text: 'Which one of the following is the correct way for calling the JavaScript code',
//     options: ['Preprocessor', 'Triggering Event', 'RMI', 'Function/Method'],
//     answerIndex: 3,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '78',
//     text: 'Which of the following type of a variable is volatile',
//     options: ['Dynamic variable', 'Mutable variable', 'Volatile variable', 'Immutable variable'],
//     answerIndex: 1,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '79',
//     text: 'In the JavaScript, which one of the following is not considered as an error',
//     options: ['Division by zero', 'Syntax error', 'Missing of semicolons', 'Missing of Bracket'],
//     answerIndex: 0,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '80',
//     text: 'Which of the following function of the String object returns the character in the string at the specified position via the specified number of characters',
//     options: ['substr()', 'slice()', 'split()', 'search()'],
//     answerIndex: 0,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '81',
//     text: 'Choose the correct snippet from the following to check if the variable "a" is not equal the "NULL"',
//     options: ['if(a!)', 'if(a!null)', 'if(a!=null)', 'if(a!==null)'],
//     answerIndex: 3,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '82',
//     text: 'Which of the following one is the property of the primary expression',
//     options: ['Contains only keywords', 'basic expressions containing all necessary functions', 'stand-alone expressions', 'contains variable references alone'],
//     answerIndex: 2,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '83',
//     text: 'The "new Point(3,2)" is a kind of expression',
//     options: ['Primary Expression', 'Invocation Expression', 'Object Creation Expression', 'Constructor Calling Expression'],
//     answerIndex: 2,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '84',
//     text: 'Which one of the following operator is used to check whether a specific property exists or not',
//     options: ['Exists', 'exist', 'in', 'within'],
//     answerIndex: 2,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '85',
//     text: 'Which of the following is a ternary operator',
//     options: ['?', ':', '-', '+'],
//     answerIndex: 0,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '86',
//     text: 'Which of the following is correct output for the following given JavaScript code\n\n```javascript\nstring X= "Good";\nstring Y="Evening";\nalert(X+Y);\n```',
//     options: ['Good', 'GoodEvening', 'Evening', 'undefined'],
//     answerIndex: 1,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '87',
//     text: 'Which of the following is known as the Equality operator, which is used to check whether the two values are equal or not',
//     options: ['= = =', '= =', '=', '&&'],
//     answerIndex: 1,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '88',
//     text: 'Which of the following is not a keyword',
//     options: ['if', 'with', 'use strict', 'debugger'],
//     answerIndex: 2,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '89',
//     text: 'What are the three important manipulations for a loop on a loop variable',
//     options: ['Updation, Incrementation, Initialization', 'Initialization, Testing, Incrementation', 'Initialization, Testing, Updation', 'Testing, Updation, Testing'],
//     answerIndex: 2,
//     category: 'JavaScript',
//   ),
//   Question(
//     id: '90',
//     text: 'A set of unordered properties that has a name and value is called',
//     options: ['String', 'Array', 'Object', 'Serialized Object'],
//     answerIndex: 2,
//     category: 'JavaScript',
//   ),
// ];
 
final List<Question> questions = [
  Question(
    id: '91',
    text: 'Which of the following are some common RDBMS in use',
    options: ['Oracle', 'MySQL', 'HeidiSQL', 'All of the above'],
    answerIndex: 3,
    category: 'Database',
  ),
  Question(
    id: '92',
    text: 'What command is used to create a new table in SQL',
    options: ['BUILD TABLE', 'GENERATE TABLE', 'CREATE TABLE', 'None of the above'],
    answerIndex: 2,
    category: 'Database',
  ),
  Question(
    id: '93',
    text: 'Which of the following command is used to delete all rows and free up space from a table',
    options: ['TRUNCATE', 'DROP', 'DELETE', 'ALTER'],
    answerIndex: 0,
    category: 'Database',
  ),
  Question(
    id: '94',
    text: 'When is the wildcard in WHERE clause used',
    options: [
      'An exact match is necessary for a CREATE statement',
      'An exact match is not possible in a SELECT statement',
      'An exact match is necessary for a SELECT statement',
      'None of the above'
    ],
    answerIndex: 1,
    category: 'Database',
  ),
  Question(
    id: '95',
    text: 'Which of the following commands are a part of Data Control Language',
    options: ['Revoke', 'Grant', 'Both A and B', 'None of the above'],
    answerIndex: 2,
    category: 'Database',
  ),
  Question(
    id: '96',
    text: 'Which of the following is the full form of DDL',
    options: ['Data definition language', 'Data derivation language', 'Dynamic data language', 'Detailed data language'],
    answerIndex: 0,
    category: 'Database',
  ),
  Question(
    id: '97',
    text: 'Which SQL constraint do we use to set some value to a field whose value has not been added explicitly',
    options: ['UNIQUE', 'DEFAULT', 'NOT NULL', 'CHECK'],
    answerIndex: 1,
    category: 'Database',
  ),
  Question(
    id: '98',
    text: 'What are rows of a relation known as',
    options: ['Degree', 'Entity', 'Tuple', 'None'],
    answerIndex: 2,
    category: 'Database',
  ),
  Question(
    id: '99',
    text: 'How many operations are considered to be the most basic SQL operations',
    options: ['1', '2', '3', '4'],
    answerIndex: 3,
    category: 'Database',
  ),
  Question(
    id: '100',
    text: 'Which of the following is not a SQL command',
    options: ['ORDER BY', 'SELECT', 'DELETE', 'WHERE'],
    answerIndex: 2,
    category: 'Database',
  ),
  Question(
    id: '101',
    text: 'Which of the following command is used to delete a trigger in SQL',
    options: ['DELETE', 'ALTER', 'DROP', 'None'],
    answerIndex: 2,
    category: 'Database',
  ),
  Question(
    id: '102',
    text: 'Which of the following is not a valid SQL type',
    options: ['NUMERIC', 'DECIMAL', 'CHARACTER', 'None of the above'],
    answerIndex: 3,
    category: 'Database',
  ),
  Question(
    id: '103',
    text: 'Select the valid SQL type',
    options: ['NUMERIC', 'CHARACTER', 'FLOAT', 'All of the above'],
    answerIndex: 3,
    category: 'Database',
  ),
  Question(
    id: '104',
    text: 'Group of operations that form a single logical unit of work called',
    options: ['Network', 'Transaction', 'Unit', 'None of the above'],
    answerIndex: 1,
    category: 'Database',
  ),
  Question(
    id: '105',
    text: 'How can we view all the triggers currently in the database',
    options: ['VIEW', 'SHOW', 'READ', 'None of the above'],
    answerIndex: 1,
    category: 'Database',
  ),
  Question(
    id: '106',
    text: 'Select the correct foreign key constraint',
    options: ['Referential integrity', 'Entity integrity', 'Domain integrity', 'None of the above'],
    answerIndex: 0,
    category: 'Database',
  ),
  Question(
    id: '107',
    text: 'What is a table joined with itself called',
    options: ['join', 'Outer join', 'Self-join', 'None'],
    answerIndex: 2,
    category: 'Database',
  ),
  Question(
    id: '108',
    text: 'To select some particular columns, which of the following commands is used',
    options: ['PROJECTION', 'SELECTION', 'JOIN', 'UNION'],
    answerIndex: 0,
    category: 'Database',
  ),
  Question(
    id: '109',
    text: 'Which of the following are TCL commands',
    options: ['ROLLBACK', 'SAVEPOINT', 'Both A and B', 'None of the above'],
    answerIndex: 2,
    category: 'Database',
  ),
  Question(
    id: '110',
    text: 'SQL views are also known as',
    options: ['Schema', 'Virtual Table', 'Instance', 'None of the above'],
    answerIndex: 1,
    category: 'Database',
  ),
];



class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromMap(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int answerIndex;
  final String category;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.answerIndex,
    required this.category,
  });

  factory Question.fromMap(Map<String, dynamic> data, String documentId) {
    return Question(
      id: documentId,
      text: data['text'] ?? '',
      options: List<String>.from(data['options']),
      answerIndex: data['answerIndex'],
      category: data['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'options': options,
      'answerIndex': answerIndex,
      'category': category,
    };
  }
}


Future<void> addCategoryWithQuestions(Category category, List<Question> questions) async {
  await FirebaseFirestore.instance.collection('questions').doc(category.id).set({
    'name': category.name,
    'questions': questions.map((q) => q.toMap()).toList(),
  });
}

void addQuestionsToFirestore() async {
  final Map<String, List<Question>> categorizedQuestions = {};

  for (var question in questions) {
    if (categorizedQuestions.containsKey(question.category)) {
      categorizedQuestions[question.category]!.add(question);
    } else {
      categorizedQuestions[question.category] = [question];
    }
  }

  for (var entry in categorizedQuestions.entries) {
    final category = Category(id: entry.key, name: entry.key);
    await addCategoryWithQuestions(category, entry.value);
  }
}
 
   

// IconData getCategoryIcon(String categoryName) {
//   switch (categoryName) {
//     case 'Java':
//       return Icons.computer;
//     case 'Python':
//       return Icons.code;
//     case 'Aptitude':
//       return Icons.calculate;
//     default:
//       return Icons.category;
//   }
// }
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

Map<String, Map<String, String>> users = {};
List<Map<String, String>> donors = [];
List<Map<String, String>> volunteers = [];
List<Map<String, String>> getHelpRequests = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50, // 💡 Change background color here
      appBar: AppBar(title: Text('🩸 Blood Donation App')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Blood Donation App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                  EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginPage())),
                child: Text("Login"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                  EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignUpPage())),
                child: Text("Sign Up"),
              ),
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/4.png',
                  height: 300,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(title: Text("🔐 Login")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email")),
              TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true),
              if (error != null)
                Text(error!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                  onPressed: () {
                    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                      setState(() {
                        error = "Please fill in all fields";
                      });
                      return;
                    }

                    final user = {
                      'name': 'Guest User',
                      'email': emailController.text,
                      'mobile': 'N/A',
                      'password': passwordController.text,
                    };

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage(user: user)),
                    );
                  },


                  child: Text("Login"),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SignUpPage())),
                child: Text("Don’t have an account? Sign Up",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
              ),
              SizedBox(height: 30),


            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(title: Text("📝 Sign Up")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
              TextField(controller: email, decoration: InputDecoration(labelText: "Email")),
              TextField(controller: mobile, decoration: InputDecoration(labelText: "Mobile")),
              TextField(controller: password, decoration: InputDecoration(labelText: "Password"), obscureText: true),
              TextField(controller: confirm, decoration: InputDecoration(labelText: "Confirm Password"), obscureText: true),
              if (error != null)
                Text(error!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                onPressed: () {
                  if (name.text.isEmpty ||
                      email.text.isEmpty ||
                      mobile.text.isEmpty ||
                      password.text.isEmpty ||
                      confirm.text.isEmpty) {
                    setState(() {
                      error = "Please fill in all fields";
                    });
                    return;
                  }

                  if (password.text != confirm.text) {
                    setState(() {
                      error = "Passwords do not match";
                    });
                    return;
                  }

                  final user = {
                    'name': name.text,
                    'email': email.text,
                    'mobile': mobile.text,
                    'password': password.text
                  };
                  users[email.text] = user;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage(user: user)),
                  );
                },

                child: Text("Sign Up"),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage())),
                child: Text("Already have an account? Login",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
              ),
              SizedBox(height: 30),


            ],
          ),
        ),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  final Map<String, String> user;
  HomePage({required this.user});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final pages = ['About Us', 'Donate', 'Get Help', 'Volunteer'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("👤 Profile"),
                content: Text(
                    "Name: ${widget.user['name']}\nEmail: ${widget.user['email']}\nMobile: ${widget.user['mobile']}"),
              ),
            ),
          ),

          // 🔔 Notification button
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("🔔 Get Help Requests"),
                  content: Container(
                    width: double.maxFinite,
                    child: getHelpRequests.isEmpty
                        ? Text("No help requests submitted yet.")
                        : ListView(
                      shrinkWrap: true,
                      children: getHelpRequests.map((req) {
                        return ListTile(
                          leading: Icon(Icons.help, color: Colors.red),
                          title: Text(req['name']!),
                          subtitle: Text(
                              "${req['group']} - ${req['mobile']}\n${req['address']}"),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),

          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => WelcomeScreen()),
                    (route) => false),
          ),
        ],

      ),
      drawer: Drawer(
        child: Container(
          color: Colors.red.shade50,
          child: ListView(
            children: [
              DrawerHeader(
                child: Text("Menu",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              for (int i = 0; i < pages.length; i++)
                ListTile(
                  title: Text(pages[i],
                      style: TextStyle(color: Colors.red.shade800)),
                  onTap: () {
                    setState(() => index = i);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),

      body: _buildPage(index),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return Container(
          color: Colors.pink.shade50, // 💡 Background color
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🩸 Blood Donation App",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                SizedBox(height: 12),

                // ✅ Image 4 above first paragraph
                Center(
                  child: Image.asset(
                    'assets/images/4.png',
                    height: 200,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12),

                Text(
                  "Blood Donation App is a life-saving initiative designed to connect blood donors with those in urgent need. In medical emergencies, every second counts — and access to the right blood group can mean the difference between life and death. Our app empowers individuals to register as donors, request blood when needed, and contribute as community volunteers. Through a user-friendly interface and real-time donor lists, we make finding and giving blood easier, safer, and faster.",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 20),

                // ✅ Image 5 above second paragraph
                Center(
                  child: Image.asset(
                    'assets/images/5.png',
                    height: 400,
                  ),
                ),
                SizedBox(height: 12),

                Text(
                  "We believe that donating blood is one of the simplest yet most impactful acts of kindness. By bridging the gap between donors and recipients, we aim to build a stronger, healthier community. Whether you're a first-time donor or a regular volunteer, our platform is built to support you in making a difference. Join us in spreading hope, saving lives, and fostering a culture of compassion — one drop at a time.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );

      case 1:
        return DonatePage();
      case 2:
        return GetHelpPage();
      case 3:
        return VolunteerPage();
      default:
        return Container();
    }
  }
}

// ---------------------- DONATE PAGE -------------------------
class DonatePage extends StatefulWidget {
  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final name = TextEditingController();
  final mobile = TextEditingController();
  final group = TextEditingController();
  final address = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (donors.isEmpty) {
      donors.addAll([
        {'name': 'Ravi Kumar', 'mobile': '9876543210', 'group': 'A+', 'address': 'Hyderabad'},
        {'name': 'Anjali Sharma', 'mobile': '9123456789', 'group': 'B+', 'address': 'Chennai'},
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade50,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("🩸 Donate Blood", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
          TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
          TextField(controller: mobile, decoration: InputDecoration(labelText: "Mobile")),
          TextField(controller: group, decoration: InputDecoration(labelText: "Blood Group")),
          TextField(controller: address, decoration: InputDecoration(labelText: "Address")),
          ElevatedButton(
              onPressed: () {
                donors.add({
                  'name': name.text,
                  'mobile': mobile.text,
                  'group': group.text,
                  'address': address.text
                });
                setState(() {
                  name.clear();
                  mobile.clear();
                  group.clear();
                  address.clear();
                });
              },
              child: Text("Submit")),
          if (donors.isNotEmpty) ...[
            SizedBox(height: 20),
            Text("📋 Donors List", style: TextStyle(color: Colors.red)),
            ...donors.map((d) => ListTile(
              leading: Icon(Icons.person, color: Colors.red),
              title: Text(d['name']!),
              subtitle: Text("${d['group']} - ${d['mobile']}"),
            )),
          ]
        ],
      ),
    );
  }
}


// ---------------------- GET HELP PAGE -------------------------
class GetHelpPage extends StatefulWidget {
  @override
  State<GetHelpPage> createState() => _GetHelpPageState();
}

class _GetHelpPageState extends State<GetHelpPage> {
  final name = TextEditingController();
  final mobile = TextEditingController();
  final group = TextEditingController();
  final address = TextEditingController();
  List<Map<String, String>> matches = [];
  bool showDonors = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade50,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("🚑 Get Help", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
          if (!showDonors) ...[
            TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: mobile, decoration: InputDecoration(labelText: "Mobile")),
            TextField(controller: group, decoration: InputDecoration(labelText: "Blood Group")),
            TextField(controller: address, decoration: InputDecoration(labelText: "Address")),
            ElevatedButton(
                onPressed: () {
                  getHelpRequests.add({
                    'name': name.text,
                    'mobile': mobile.text,
                    'group': group.text,
                    'address': address.text,
                  });
                  setState(() {
                    matches = donors
                        .where((d) => d['group']!.toLowerCase() == group.text.toLowerCase())
                        .toList();
                  });
                },

                child: Text("Find Donors")),
            if (matches.isNotEmpty) ...[
              SizedBox(height: 20),
              Text("🩸 Matching Donors", style: TextStyle(color: Colors.red)),
              ...matches.map((d) => ListTile(
                leading: Icon(Icons.person, color: Colors.red),
                title: Text(d['name']!),
                subtitle: Text("${d['group']} - ${d['mobile']}"),
              )),
            ] else if (matches.isEmpty && group.text.isNotEmpty)
              Text("⚠️ No matching donors found", style: TextStyle(color: Colors.orange)),
          ],
          ElevatedButton(
              onPressed: () {
                setState(() => showDonors = !showDonors);
              },
              child: Text(showDonors ? "🔙 Back" : "View Donors")),
          if (showDonors)
            ...donors.map((d) => ListTile(
              leading: Icon(Icons.person, color: Colors.red),
              title: Text(d['name']!),
              subtitle: Text("${d['group']} - ${d['mobile']}"),
            )),
        ],
      ),
    );
  }
}


// ---------------------- VOLUNTEER PAGE -------------------------
class VolunteerPage extends StatefulWidget {
  @override
  State<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  final name = TextEditingController();
  final mobile = TextEditingController();
  final address = TextEditingController();
  bool showVolunteers = false;

  @override
  void initState() {
    super.initState();
    if (volunteers.isEmpty) {
      volunteers.addAll([
        {'name': 'Meena Patel', 'mobile': '9012345678', 'address': 'Bangalore'},
        {'name': 'Arun Das', 'mobile': '9345678901', 'address': 'Kolkata'},
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade50,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("🙌 Become a Volunteer", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
          if (!showVolunteers) ...[
            TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: mobile, decoration: InputDecoration(labelText: "Mobile")),
            TextField(controller: address, decoration: InputDecoration(labelText: "Address")),
            ElevatedButton(
                onPressed: () {
                  volunteers.add({
                    'name': name.text,
                    'mobile': mobile.text,
                    'address': address.text
                  });
                  setState(() {
                    name.clear();
                    mobile.clear();
                    address.clear();
                  });
                },
                child: Text("Be a Volunteer")),
          ],
          ElevatedButton(
              onPressed: () {
                setState(() => showVolunteers = !showVolunteers);
              },
              child: Text(showVolunteers ? "🔙 Back" : "View Volunteers")),
          if (showVolunteers)
            ...volunteers.map((v) => ListTile(
              leading: Icon(Icons.volunteer_activism, color: Colors.red),
              title: Text(v['name']!),
              subtitle: Text("${v['mobile']} - ${v['address']}"),
            )),
        ],
      ),
    );
  }
}

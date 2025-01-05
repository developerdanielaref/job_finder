import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobFinderScreen extends StatefulWidget {
  @override
  _JobFinderScreenState createState() => _JobFinderScreenState();
}

class _JobFinderScreenState extends State<JobFinderScreen> {
  String? selectedJobType;
  String? selectedLocation;
  String? selectedSalaryRange;
  List<dynamic> jobs = [];

  final jobTypes = ['Full-time', 'Part-time', 'Internship'];
  final locations = ['New York', 'Los Angeles', 'Chicago'];
  final salaryRanges = ['\$1000-\$2000', '\$2000-\$3000', '\$3000-\$4000'];

  Future<void> fetchJobs() async {
    final url =
        'http://localhost/job_finder/get_jobs.php?job_type=$selectedJobType&location=$selectedLocation&salary_range=$selectedSalaryRange';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        jobs = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Job Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedJobType,
              hint: Text('Select Job Type'),
              onChanged: (value) {
                setState(() {
                  selectedJobType = value;
                });
              },
              items: jobTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
            ),
            DropdownButton<String>(
              value: selectedLocation,
              hint: Text('Select Location'),
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
              items: locations.map((location) {
                return DropdownMenuItem(value: location, child: Text(location));
              }).toList(),
            ),
            DropdownButton<String>(
              value: selectedSalaryRange,
              hint: Text('Select Salary Range'),
              onChanged: (value) {
                setState(() {
                  selectedSalaryRange = value;
                });
              },
              items: salaryRanges.map((range) {
                return DropdownMenuItem(value: range, child: Text(range));
              }).toList(),
            ),
            ElevatedButton(onPressed: fetchJobs, child: Text('Search Jobs')),
            Expanded(
              child: ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(jobs[index]['job_title']),
                    subtitle: Text(
                        '${jobs[index]['location']} - ${jobs[index]['salary_range']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

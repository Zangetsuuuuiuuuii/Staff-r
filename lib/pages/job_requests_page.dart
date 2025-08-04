import 'package:flutter/material.dart';

class JobRequestsPage extends StatefulWidget {
  const JobRequestsPage({super.key});

  @override
  State<JobRequestsPage> createState() => _JobRequestsPageState();
}

class _JobRequestsPageState extends State<JobRequestsPage> {
  List<Map<String, String>> mockRequests = [
    {
      'name': 'M Karthikeya',
      'category': 'Driver',
      'time': 'Today • 3:00 PM',
      'location': 'ECIL, Hyderabad',
      'status': 'pending',
    },
  ];

  void _acceptRequest(int index) {
    setState(() {
      mockRequests.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Requests"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: mockRequests.isEmpty
          ? const Center(child: Text("No job requests."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mockRequests.length,
              itemBuilder: (context, index) {
                final request = mockRequests[index];
                final status = request['status'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + Category
                      Row(
                        children: [
                          const Icon(Icons.account_circle_rounded,
                              size: 32, color: Colors.deepPurple),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "${request['name']} • ${request['category']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: status == 'pending'
                                  ? Colors.orange.shade100
                                  : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              status == 'pending' ? 'Pending' : 'Accepted',
                              style: TextStyle(
                                color: status == 'pending'
                                    ? Colors.orange.shade800
                                    : Colors.green.shade800,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${request['time']} • ${request['location']}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                      if (status == 'pending') ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _acceptRequest(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Accept"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // You can handle reject logic here if needed
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                ),
                                child: const Text("Reject"),
                              ),
                            ),
                          ],
                        )
                      ]
                    ],
                  ),
                );
              },
            ),
    );
  }
}
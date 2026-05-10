import 'package:flutter/material.dart';
import 'package:nilesisters/Localization/demo_localization.dart';
import 'package:nilesisters/Model/getStaff.dart';
import 'package:nilesisters/utils/Utils.dart';

class StaffViewer extends StatefulWidget {
  @override
  State<StaffViewer> createState() => _StaffViewerState();
}

class _StaffViewerState extends State<StaffViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(DemoLocalization.of(context).getTranslatedValue('staff')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                DemoLocalization.of(context).getTranslatedValue('staff'),
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<GetStaff>(
              future: Utils().fetchstaff(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final staff = snapshot.data!;
                return GridView.builder(
                  itemCount: staff.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    final member = staff.data[index];
                    return Card(
                      elevation: 5,
                      child: GridTile(
                        footer: Container(
                          color: Colors.white70,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    member.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    member.designation,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: Image.network(
                          '${Utils().image_base_url}${member.image}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

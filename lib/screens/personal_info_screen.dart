
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/client_log.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.go('/mood', extra: _nameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.brown.shade700),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'SoulSync',
                applicationVersion: '1.0.0',
                applicationIcon: Image.asset(
                  'assets/images/logo.png', 
                  width: 48, 
                  height: 48
                ),
                applicationLegalese: '© 2024 Gemini AI',
                children: <Widget>[
                  const SizedBox(height: 16),
                  Text(
                    'SoulSync is a mindful mood journal crafted with Flutter to help you cultivate emotional well-being.',
                    style: GoogleFonts.nunitoSans(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The app uses the "Pacifico" font for its signature title and "Nunito Sans" for a clean, readable experience.',
                    style: GoogleFonts.nunitoSans(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/author_image.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About the Author:',
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Laica Jane L. Tardio',
                              style: GoogleFonts.nunitoSans(),
                            ),
                            Text('BIT-CPT3', style: GoogleFonts.nunitoSans()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.amber.shade200, Colors.amber.shade50],
          ),
        ),
        child: Column(
          children: [
            _buildNameInputSection(context),
            _buildLogHistorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInputSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 80), // Top padding for app bar
            Image.asset('assets/images/logo.png', height: 150),
            const SizedBox(height: 16),
            Text(
              'SoulSync',
              textAlign: TextAlign.center,
              style: GoogleFonts.pacifico(
                fontSize: 52,
                color: Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'Hello! What is your name?',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.brown.shade800,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              style: GoogleFonts.nunitoSans(fontSize: 18),
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Start Logging'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogHistorySection() {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: Hive.box<ClientLog>('client_logs').listenable(),
        builder: (context, Box<ClientLog> box, _) {
          final logs = box.values.toList().cast<ClientLog>();
          if (logs.isEmpty) {
            return Center(
              child: Text(
                'No saved logs yet.',
                style: GoogleFonts.nunitoSans(color: Colors.brown.shade700),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return Dismissible(
                key: Key(log.key.toString()),
                onDismissed: (direction) {
                  box.delete(log.key);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Log deleted')));
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    title: Text(
                      log.name,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.brown.shade800,
                      ),
                    ),
                    subtitle: Text(
                      'Mood: ${log.moodScore}/10 - ${DateFormat('MMM d, yyyy').format(log.timestamp)}',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 14,
                        color: Colors.brown.shade700,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    onTap: () {
                      context.go('/log_details', extra: log);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

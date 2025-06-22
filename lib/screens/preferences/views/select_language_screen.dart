import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String selectedLanguage = 'en';

  final List<Map<String, String>> languages = [
    {'code': 'en', 'label': 'English', 'flag': '🇬🇧'},
    {'code': 'id', 'label': 'Indonesia', 'flag': '🇮🇩'},
    {'code': 'ja', 'label': 'Japan', 'flag': '🇯🇵'},
    {'code': 'de', 'label': 'German', 'flag': '🇩🇪'},
    {'code': 'ar', 'label': 'Arabic', 'flag': '🇸🇦'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bahasa"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih bahasa yang diinginkan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Bahasa ini akan digunakan di seluruh aplikasi.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: "Cari bahasa kamu",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                // Optional: tambahkan fitur filter list
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: languages.map((lang) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: lang['code'] == selectedLanguage
                          ? Colors.deepPurple.shade100
                          : Colors.white,
                      border: Border.all(
                        color: lang['code'] == selectedLanguage
                            ? Colors.deepPurple
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Text(
                        lang['flag']!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      title: Text(lang['label']!),
                      trailing: lang['code'] == selectedLanguage
                          ? const Icon(Icons.check_circle, color: Colors.deepPurple)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedLanguage = lang['code']!;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Simpan bahasa pilihan di sini jika dibutuhkan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Bahasa telah diatur: $selectedLanguage"),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Selesai"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

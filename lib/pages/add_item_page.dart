import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../models/clothing_item.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _nameController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _saving = false;

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _saveItem() async {
    if (_imageFile == null || _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide name and image')));
      return;
    }
    setState(() => _saving = true);
    // Copy image to app directory
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(_imageFile!.path);
    final savedImage = await _imageFile!.copy('${appDir.path}/$fileName');

    final item = ClothingItem(name: _nameController.text.trim(), imagePath: savedImage.path);
    final box = Hive.box<ClothingItem>('items');
    await box.add(item);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile == null
                  ? Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Center(child: Text('Tap to select photo')),
                    )
                  : Image.file(_imageFile!, height: 150),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 24),
            _saving
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _saveItem,
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
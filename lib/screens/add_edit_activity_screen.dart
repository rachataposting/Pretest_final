import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../enums/activity_category.dart';
import '../utils/app_theme.dart';

class AddEditActivityScreen extends StatefulWidget {
  final Activity? activity;
  final Function(Activity) onSave;

  const AddEditActivityScreen({super.key, 
    this.activity,
    required this.onSave,
  });

  @override
  _AddEditActivityScreenState createState() => _AddEditActivityScreenState();
}

class _AddEditActivityScreenState extends State<AddEditActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _organizerController;
  late TextEditingController _locationController;
  
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late ActivityCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    
    final activity = widget.activity;
    _titleController = TextEditingController(text: activity?.title ?? '');
    _descriptionController = TextEditingController(text: activity?.description ?? '');
    _imageUrlController = TextEditingController(text: activity?.imageUrl ?? '');
    _organizerController = TextEditingController(text: activity?.organizer ?? '');
    _locationController = TextEditingController(text: activity?.location ?? '');
    
    _selectedDate = activity?.date ?? DateTime.now();
    _selectedTime = activity?.time ?? TimeOfDay.now();
    _selectedCategory = activity?.category ?? ActivityCategory.academic;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _organizerController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.activity != null;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          isEditing ? 'แก้ไขกิจกรรม' : 'เพิ่มกิจกรรมใหม่',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            _buildHeaderCard(isEditing),
            SizedBox(height: 24),
            _buildBasicInfoCard(),
            SizedBox(height: 16),
            _buildImageCard(),
            SizedBox(height: 16),
            _buildOrganizerLocationCard(),
            SizedBox(height: 16),
            _buildCategoryDateTimeCard(context),
            SizedBox(height: 32),
            _buildSaveButton(isEditing),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(bool isEditing) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              isEditing ? Icons.edit : Icons.add_circle_outline,
              size: 48,
              color: AppTheme.primaryColor,
            ),
            SizedBox(height: 12),
            Text(
              isEditing ? 'แก้ไขข้อมูลกิจกรรม' : 'สร้างกิจกรรมใหม่',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'กรอกข้อมูลให้ครบถ้วนเพื่อสร้างกิจกรรมที่น่าสนใจ',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoCard() {
    return _buildFormCard([
      _buildTextField(
        controller: _titleController,
        label: 'ชื่อกิจกรรม *',
        icon: Icons.title,
        validator: (value) => value?.isEmpty == true ? 'กรุณาใส่ชื่อกิจกรรม' : null,
      ),
      SizedBox(height: 16),
      _buildTextField(
        controller: _descriptionController,
        label: 'รายละเอียด *',
        icon: Icons.description,
        maxLines: 4,
        validator: (value) => value?.isEmpty == true ? 'กรุณาใส่รายละเอียด' : null,
      ),
    ]);
  }

  Widget _buildImageCard() {
    return _buildFormCard([
      _buildTextField(
        controller: _imageUrlController,
        label: 'URL รูปภาพ',
        icon: Icons.image,
        hint: 'https://example.com/image.jpg',
      ),
      if (_imageUrlController.text.isNotEmpty) ...[
        SizedBox(height: 12),
        _buildImagePreview(),
      ],
    ]);
  }

  Widget _buildOrganizerLocationCard() {
    return _buildFormCard([
      _buildTextField(
        controller: _organizerController,
        label: 'ผู้จัดกิจกรรม *',
        icon: Icons.group,
        validator: (value) => value?.isEmpty == true ? 'กรุณาใส่ชื่อผู้จัด' : null,
      ),
      SizedBox(height: 16),
      _buildTextField(
        controller: _locationController,
        label: 'สถานที่',
        icon: Icons.location_on,
      ),
    ]);
  }

  Widget _buildCategoryDateTimeCard(BuildContext context) {
    return _buildFormCard([
      _buildCategoryDropdown(),
      SizedBox(height: 16),
      _buildDateTimePickers(context),
    ]);
  }

  Widget _buildFormCard(List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      onChanged: (value) {
        if (controller == _imageUrlController) {
          setState(() {});
        }
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          _imageUrlController.text,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, color: Colors.grey[400], size: 32),
                    SizedBox(height: 4),
                    Text('ไม่สามารถโหลดรูปได้', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<ActivityCategory>(
      initialValue: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'หมวดหมู่ *',
        prefixIcon: Icon(Icons.category, color: AppTheme.primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: ActivityCategory.values
          .where((category) => category != ActivityCategory.all)
          .map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.displayName),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value!;
        });
      },
    );
  }

  Widget _buildDateTimePickers(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.calendar_today, color: AppTheme.primaryColor),
              title: Text('วันที่', style: TextStyle(fontSize: 14)),
              subtitle: Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => _selectDate(context),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.access_time, color: AppTheme.primaryColor),
              title: Text('เวลา', style: TextStyle(fontSize: 14)),
              subtitle: Text(
                _selectedTime.format(context),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => _selectTime(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(bool isEditing) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _saveActivity,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
        ),
        child: Text(
          isEditing ? 'บันทึกการแก้ไข' : 'สร้างกิจกรรม',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveActivity() {
    if (_formKey.currentState!.validate()) {
      final activity = Activity(
        id: widget.activity?.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: _imageUrlController.text.trim().isNotEmpty 
            ? _imageUrlController.text.trim()
            : 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop',
        organizer: _organizerController.text.trim(),
        location: _locationController.text.trim(),
        date: _selectedDate,
        time: _selectedTime,
        category: _selectedCategory,
      );

      widget.onSave(activity);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text(
                widget.activity != null ? 'แก้ไขกิจกรรมเรียบร้อยแล้ว' : 'สร้างกิจกรรมเรียบร้อยแล้ว',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(16),
          duration: Duration(seconds: 2),
        ),
      );
      
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text('กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วน'),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(16),
        ),
      );
    }
  }
}
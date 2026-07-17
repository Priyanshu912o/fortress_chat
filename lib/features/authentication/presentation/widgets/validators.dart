class Validators {
  Validators._();

  static Map<String, String? Function(String?)?> get validator => {
    'name':(value) {
      if (value == null || value.trim().isEmpty) return 'Email is required';
      return null;
    },
    'email': (value) {
      if (value == null || value.trim().isEmpty) return 'Email is required';
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
      if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
      return null; // ← null means valid
    },
    'password': (value) {
      if (value == null || value.isEmpty) return 'Password is required';
      if (value.length < 8) return 'Must be at least 8 characters';
      if (!value.contains(RegExp(r'[A-Z]'))) return 'Need an uppercase letter';
      if (!value.contains(RegExp(r'[0-9]'))) return 'Must contain a number';
      if (!value.contains(RegExp(r'[!@#$%^&*]'))) return 'Need a special character';
      return null;
    },
  };
}

extension StringX on String? {

  String? get bearer => this != null ? "Bearer $this" : null;

}
class BaseDate {
  final DateTime createdAt;
  DateTime modifiedAt;
  
  BaseDate() 
      : createdAt = DateTime.now(),
        modifiedAt = DateTime.now();
}

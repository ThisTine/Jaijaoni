class SelectedFirend {
  final String id;
  final String imagePath;
  final String username;
  final String name;
  final double price;
  final bool isCustomed;

  SelectedFirend(
      {required this.id, required this.imagePath, required this.name, required this.price, required this.username,this.isCustomed = false});
}

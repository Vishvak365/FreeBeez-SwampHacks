class IconHelper {
   String userIconString = "assets/userIcon.png";
   String pizzaIconString = "assets/pizzaIcon.png";
   String foodIconString = "assets/foodIcon.png";
   String swagIconString = "assets/swagIcon.png";
   String etcIconString = "assets/etcIcon.png";

   IconHelper()
   {
     loadIcons();
   }
  void loadIcons()//0-pizza, 1-food, 2-swag, 3-etc.
  {
    userIconString = "assets/userIcon.png";
    pizzaIconString = "assets/pizzaIcon.png";
    foodIconString = "assets/foodIcon.png";
    swagIconString = "assets/swagIcon.png";
    etcIconString = "assets/etcIcon.png";
  }
  String getUserIconString()
  {
    return userIconString;
  }
  
  String itemTypeToString(int itemType)
  {
    switch(itemType)
    {
      case 0:
      return "assets/pizzaIcon.png";
      case 1:
      return "assets/foodIcon.png";
      case 2:
      return "assets/swagIcon.png";
      default:
      return "assets/etcIcon.png";
    }
  }
}
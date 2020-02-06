//var allowedItems  = [true, true, true, true];
class Filter {
  List<bool> allowedItems = [true, true, true, true];

  bool pizza = true;
  bool food = true;
  bool swag = true;
  bool etc = true;

  bool itemTypeFilter(int itemtype)
  {
    switch (itemtype)
    {
      case 0:
      return pizza;
      case 1:
      return food;
      case 2:
      return swag;
      default:
      return etc;
    }
  }
}
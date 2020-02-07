class Filter {
  List<bool> allowedItems = [true, true, true, true];
  bool operator ==(other)
  {
    for (int i = 0; i < this.allowedItems.length; i++)
    {
      if (allowedItems[i] != other.allowedItems[i])
        return false;
    }
    return true;
  }

  void setEqualTo(Filter other)
  {
    for (int i = 0; i < other.allowedItems.length; i++)
    {
      this.allowedItems[i] = other.allowedItems[i];
    }
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}
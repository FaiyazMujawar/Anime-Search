main(List<String> args) async {
  List<int> numbers = [1, 2, 3], nums = [4, 5, 6];
  numbers.addAll(nums);
  print(numbers);
  numbers.removeLast();
  print(numbers);
}

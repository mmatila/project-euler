#include <iostream>

int sum_of_even_fibonacci_terms() {
  const int TERM_UPPER_BOUND = 4000000;
  int i = 2;
  int j = 1;
  int sum = 0;

  while (true) {
    if (i > TERM_UPPER_BOUND) {
      break;
    }

    if (i % 2 == 0) {
      sum += i;
    }

    int next_fib = i + j;
    j = i;
    i = next_fib;
  }

  return sum;
}

int main() {
  int result = sum_of_even_fibonacci_terms();
  std::cout << result;
  return 0;
}

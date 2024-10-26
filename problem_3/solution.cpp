#include <cmath>
#include <cstdint>
#include <iostream>

int largest_prime_factor(int64_t number) {
  int factor = 2;
  while (number > 1) {
    if ((number % factor) == 0) {
      number /= factor;
    } else if (factor > sqrt(number)) {
      factor = number;
    } else {
      factor += 1;
    }
  }

  return factor;
}

int main() {
  int64_t result = largest_prime_factor(600851475143);
  std::cout << "Largest prime factor: " << result;
}

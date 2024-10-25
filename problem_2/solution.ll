; For printing the result
@.str = private constant [4 x i8] c"%d\0A\00"
declare i32 @printf(ptr, ...)

@term_upper_bound = private constant i32 4000000                    ; declare constant 'term_upper_bound'

define i32 @sum_of_even_fibonacci_terms() {
entry:
  %1 = alloca i32                                                   ; allocate memory for 'i'
  %2 = alloca i32                                                   ; allocate memory for 'j'
  %3 = alloca i32                                                   ; allocate memory for 'sum'
  store i32 2, ptr %1                                               ; initialize 'i' with the value 2
  store i32 1, ptr %2                                               ; initialize 'j' with the value 1
  store i32 0, ptr %3                                               ; initialize 'sum' with the value 0
  br label %loop                                                    ; jump to 'loop'
  
loop:
  %4 = load i32, ptr %1                                             ; load the value of 'i'
  %5 = load i32, ptr @term_upper_bound                              ; load the value of 'term_upper_bound'
  %6 = icmp ult i32 %4, %5                                          ; compare unsigned (i < term_upper_bound)
  br i1 %6, label %check_is_even, label %final_return               ; if (i > term_upper_bound) return. else jump to 'check_is_even'

check_is_even:
  %7 = load i32, ptr %1                                             ; load the value of 'i'
  %8 = urem i32 %7, 2                                               ; i % 2
  %9 = icmp eq i32 %8, 0                                            ; check if result of (i % 2) == 0
  br i1 %9, label %increment_sum, label %continue_loop              ; if ((i % 2) == 0) jump to 'increment_sum'. else jump to 'continue_loop'

increment_sum:
  %10 = load i32, ptr %3                                            ; load the value of 'sum'
  %11 = load i32, ptr %1                                            ; load the value of 'i'
  %12 = add i32 %10, %11                                            ; sum += i
  store i32 %12, ptr %3                                             ; update 'sum'
  br label %continue_loop                                           ; jump to 'loop'

continue_loop:
  %13 = alloca i32                                                  ; allocate memory for 'next_fib'
  %14 = load i32, ptr %1                                            ; load the value of 'i'
  %15 = load i32, ptr %2                                            ; load the value of 'j'
  %16 = add i32 %14, %15                                            ; i + j
  store i32 %16, ptr %13                                            ; next_fib = (i + j)
  store i32 %14, ptr %2                                             ; j = i
  %17 = load i32, ptr %13                                           ; load the value of 'next_fib'
  store i32 %17, ptr %1                                             ; i = next_fib
  br label %loop                                                    ; jump to 'loop'

final_return:
  %sum = load i32, ptr %3                                           ; load the value of 'sum'
  ret i32 %sum                                                      ; return 'sum'
}

define i32 @main() {
  %1 = alloca i32                                                   ; allocate memory for 'result'
  %2 = call i32 @sum_of_even_fibonacci_terms()                      ; store the return value of function call to 'result'

  %format_ptr = getelementptr [4 x i8], ptr @.str, i32 0, i32 0     ; prepare printing logic
  call i32 (ptr, ...) @printf(ptr %format_ptr, i32 %2)              ; print result to stdout

  ret i32 0                                                         ; return exit code 0 for success
}

define i32 @sum_of_multiples() {                                  ; Define the function that returns an integer (sum of multiples)
  %1 = alloca i32                                                 ; Allocate memory for 'sum', yields a pointer
  %2 = alloca i32                                                 ; Allocate memory for 'i', yields a pointer
  store i32 0, ptr %1                                             ; Initialize 'sum' to 0
  store i32 0, ptr %2                                             ; Initialize 'i' to 0
  br label %forloop                                               ; Jump to the block 'forloop' to start the loop

  forloop:
    %3 = load i32, ptr %2                                         ; Load the current value of 'i'
    %4 = add i32 %3, 1                                            ; Increment 'i' by 1 (i++)
    store i32 %4, ptr %2                                          ; Store the incremented value back to 'i'
    %5 = icmp ult i32 %4, 1000                                    ; Compare 'i' to 1000 (i < 1000)
    br i1 %5, label %i_lt_1000, label %i_gte_1000                 ; If i < 1000, branch to 'i_lt_1000', else branch to 'i_gte_1000'

  i_lt_1000:
    %u = load i32, ptr %2                                         ; Load the current value of 'i'
    %6 = urem i32 %u, 3                                           ; Calculate the remainder of 'i' divided by 3 (i % 3)
    %7 = icmp eq i32 %6, 0                                        ; Check if the remainder is 0
    br i1 %7, label %add_to_sum, label %check_modulo_5            ; If i % 3 == 0, go to 'the_end', else check modulo 5

  check_modulo_5:
    %g = load i32, ptr %2                                         ; Load the current value of 'i'
    %8 = urem i32 %g, 5                                           ; Calculate the remainder of 'i' divided by 5 (i % 5)
    %9 = icmp eq i32 %8, 0                                        ; Check if the remainder is 0
    br i1 %9, label %add_to_sum, label %forloop                   ; If i % 5 == 0, go to 'the_end', else continue looping

  add_to_sum:
    %s = load i32, ptr %2                                         ; Load the current value of 'i'
    %10 = load i32, ptr %1                                        ; Load the current value of 'sum'
    %11 = add i32 %10, %s                                         ; Add the value of 'i' to 'sum'
    store i32 %11, ptr %1                                         ; Store the updated sum back in 'sum'
    br label %forloop                                             ; Continue looping back to 'forloop'

  i_gte_1000:
    %12 = load i32, ptr %1                                        ; Load the final value of 'sum'
    ret i32 %12                                                   ; Return the final sum
}


@.str = private constant [4 x i8] c"%d\0A\00"                     ; Format string for printing an integer (%d\n)
declare i32 @printf(ptr, ...)                                     ; Declare printf function

define i32 @main() {
  %1 = alloca i32                                                 ; allocate memory for 'result'
  %2 = call i32 @sum_of_multiples()                               ; call sum_of_multiples and store the result in %2
  store i32 %2, ptr %1                                            ; store result in %1
  %3 = load i32, ptr %1                                           ; load the result from %1

  %format_ptr = getelementptr [4 x i8], ptr @.str, i32 0, i32 0   ; get pointer to format string
  call i32 (ptr, ...) @printf(ptr %format_ptr, i32 %3)            ; call printf to print %3

  ret i32 %3                                                      ; return the result
}

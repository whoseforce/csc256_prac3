.data
    endl:    .asciiz  "\n"   # used for cout << endl;
    sumlbl:    .asciiz  "Sum: " # label for sum
    revlbl:    .asciiz  "Reversed Number: " # label for rev
    pallbl:    .asciiz  "Is Palindrome: " # label for isPalindrome
    sumarr:    .word 1
               .word 3
               .word 44
               .word 66
               .word 88
               .word 90
               .word 9
               .word 232
               .word 4325
               .word 2321
    arr:       .word 1
               .word 2
               .word 3
               .word 4
               .word 5
               .word 4
               .word 3
               .word 2
               .word 1

.text

# sum               --> $s0
# address of sumarr --> $s1
# rev               --> $s2
# num               --> $s3
# isPalindrome      --> $s4
# address of arr    --> $s5
# i                 --> $t0
# beg               --> $s6
# end               --> $s7
# d                 --> $t1
# 10                --> $t2
# 100               --> $t3
main:
  li   $s0, 0                 # sum = 0
  li   $t2, 10                # tmp2, the size of sumarr, and also used for calculation
  la   $s1, sumarr            # sumarr, the address of sumarr[]
  li   $t4, 0                 # tmp4, the offset from the beginning of an array, or the word content
  li   $t5, 0                 # tmp5, the offset from the beginning of an array, or the word content
  li   $t0, 0                 # i = 0
  bge  $t0, $t2, afterloop0   # if (i >= size), then jump to afterloop0
loop0:
  sll  $t4, $t0, 2            # tmp4 = i * 4, the offset from &sumarr[0] to &sumarr[i]
  add  $t4, $s1, $t4          # tmp4 = sumarr + tmp4, the address of sumarr[i]
  lw   $t4, ($t4)             # tmp4 = sumarr[i]
  add  $s0, $s0, $t4          # sum = sum + sumarr[i]
  addi $t0, $t0, 1            # i++
  blt  $t0, $t2, loop0        # if (i < size), then jump to loop0
afterloop0:

  li   $s3, 45689             # num = 45689
  li   $s2, 0                 # rev = 0
  li   $t1, -1                # d = -1
  ble  $s3, $0, afterloop1    # if (num <= 0), then jump to afterloop1
loop1:
  rem  $t1, $s3, $t2          # d = num % 10
  mul  $s2, $s2, $t2          # rev = rev * 10
  add  $s2, $s2, $t1          # rev = rev + d
  div  $s3, $s3, $t2          # num = num / 10
  bgt  $s3, $0, loop1         # if (num > 0), then jump to loop1
afterloop1:

  la   $s5, arr               # arr, the address of arr[]
  li   $s6, 0                 # beg = 0
  li   $s7, 8                 # end = 8
  li   $s4, 1                 # isPalindrome = 1
  bge  $s6, $s7, exit         # if (beg >= end), then jump to exit
loop2:
  sll  $t4, $s6, 2            # tmp4 = beg * 4, the offset from &arr[0] to &arr[beg]
  add  $t4, $s5, $t4          # tmp4 = arr + tmp4, the address of arr[beg]
  lw   $t4, ($t4)             # tmp4 = arr[beg]
  sll  $t5, $s7, 2            # tmp5 = end * 4, the offset from &arr[0] to &arr[end]
  add  $t5, $s5, $t5          # tmp5 = arr + tmp5, the address of arr[end]
  lw   $t5, ($t5)             # tmp5 = arr[end]
  beq  $t4, $t5, afterif      # if (arr[beg] == arr[beg]), then jump to afterif
  li   $s4, -1                # isPalindrome = -1
  j    exit                   # jump to exit (break loop2)
afterif:
  addi $s6, $s6, 1            # beg++
  addi $s7, $s7, -1           # end--
  blt  $s6, $s7, loop2        # if (beg < end), then jump to loop2

exit:
  la   $a0, sumlbl    # puts sumlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s0       # puts sum into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, revlbl    # puts revlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing an string
  syscall             # make a syscall to system

  move $a0, $s2       # puts rev into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, pallbl    # puts pallbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s4       # puts isPalindrome into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall


  addi $v0,$0, 10
  syscall
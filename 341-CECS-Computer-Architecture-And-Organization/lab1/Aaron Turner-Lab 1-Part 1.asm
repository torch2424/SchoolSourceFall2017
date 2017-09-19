# Aaron Turner - 011502541

# Example Usage / Test Case
# Number of integers (N)? 5
# Multiplier (y)? 4
# Sum = 60
#
# -- program is finished running --

# Define our strings and variables
.data

# Array with space to hold 1 integer
# Must be defined first to ensure everything is word aligned
tempaddress: .space	4

newline: .asciiz "\n"
getnstring: .asciiz "Number of integers (N)? "
getystring: .asciiz "Multiplier (y)? "
showsumstring: .asciiz "Sum = "


.text
# Functions are called with: jal function_name

# Main Start point for program
main:
	# Set our memory address at $t0
	la $t0, tempaddress

	# Prompt the user for N
	la $a0, getnstring
	jal printstring

	# Get input of N ($t1)
	jal getintinput
	sw $v0, 0($t0)
  lw $t1, 0($t0)

	# Prompt the User for Y
	la $a0, getystring
	jal printstring

	# Get input of Y ($t2)
	jal getintinput
	sw $v0, 0($t0)
  lw $t2, 0($t0)

	# Loop to N, and Sum ($t3) i ($t4) * i
  li $t3, 0
  li $t4, 1
  loop:
    # Multiply i and Y
    mult $t4, $t2
    mflo $v0
    add $t3, $t3, $v0
    addi $t4, $t4, 1
    # Jump back to top of loop if i is still less than N
    ble $t4, $t1, loop

	# Print Sum to user
  la $a0, showsumstring
	jal printstring
  move $a0, $t3
  jal printint
  la $a0, newline
	jal printstring

	# Exit
	jal exit

# Function to print a string
# Load string into $a0 before jumping, for instance: la $a0, string
printstring:
	li $v0, 4
	syscall
	jr $ra

# Function to print an integer
# Load int into $a0 before jumping, for instance: move $a0, $t0
printint:
	li $v0, 1
	syscall
	jr $ra

# Function to get integer input
# Result will be stored in $v0, For instance, to get value into $t0: sw $v0, $t0
getintinput:
	li $v0, 5
	syscall
	jr $ra

# Function to gracefully exit the program
exit:
	li $v0, 10
	syscall

# Aaron Turner - 011502541

# Example Usage / Test Case
# Input a string: Coding Assembly is sometimes cool, but I like Javascript More
#
# eroM tpircsavaJ ekil I tub ,looc semitemos si ylbmessA gnidoC
#
# -- program is finished running --

# Define our strings and variables
.data

# Array with space to hold 1 integer
# Must be defined first to ensure everything is word aligned
stringbuffer: .space	50
reversebuffer: .space 50

newline: .asciiz "\n"
stringprompt: .asciiz "Input a string: "


.text
# Functions are called with: jal function_name

# Main Start point for program
main:
	# Prompt the user for a string
	la $a0, stringprompt
	jal printstring

	# Read in the string
	la $a0, stringbuffer
	li $a1, 100
	jal getstringinput
	# Store the address in $t0
	la $t0, stringbuffer

	# Find the Length of the string
	# End of string will contain zero
  # $t1 to represent length / string index
	# $t2 to store a character
	# offset our temp string
  li $t1, -1
	addi $t0, $t0, -1
	lengthloop:
		addi $t0, $t0, 1
    addi $t1, $t1, 1
		# Get the string value at i
		lb $t2, 0($t0)
		# Loop if $t2 has something in it (More than zero)
		bgt $t2, $zero, lengthloop

  # Reset t0 to string address
  la $t0, stringbuffer

  # Set the string address to the end
  add $t0, $t0, $t1

  # Set $t3 to the reverse string address
  la $t3, reversebuffer

  # Reverse the string at the reverse string buffer
  # reusing $t2 as temp byte store
  # Offset for our do-while loop
  addi $t3, $t3, -1
  reverseloop:
    # Decrement the string buffer, increment the reverse buffer
    addi $t0, $t0, -1
    addi $t3, $t3, 1
    # Get the byte from the string, and place into the reverse
    lb $t2, 0($t0)
    sb $t2, 0($t3)
    # Decrement our length (string index)
    addi $t1, $t1, -1
    bgt $t1, $zero, reverseloop

  # Print the reversed string
  la $a0, reversebuffer
  jal printstring

  # Newline for cleanup
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

# Function to get integer input
# Result will be stored in $v0
# Store memory address at $a0: la $a0, memaddress
# Store buffer length (Same ad memory address space) at $a1: li $a1, 100
# Result will be in $a0: move $t0, $a0
getstringinput:
	li $v0, 8
	syscall
	jr $ra

# Function to gracefully exit the program
exit:
	li $v0, 10
	syscall

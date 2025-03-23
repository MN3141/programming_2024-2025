#Exercise the use of lambda expressions

from functools import reduce

foo_array = [2,3,4,10,55,17]

# Simple expressions
square = lambda x: x*x
add = lambda x,y: x+y
is_even = lambda x: x % 2 == 0

# Map() test 0
double_array = list(map(square,foo_array))
print(double_array)

print("===")
# Map() test 1
add_squared_array = map(add,double_array,double_array)
print(list(add_squared_array))

print("===")

# Filter test 0
even_list = list(filter(is_even,foo_array))
print(even_list)

print("===")

# Filter test 1
even_list2 = list(filter(is_even,map(square,foo_array)))
print(even_list2)

print("===")

# Reduce test
list_sum = reduce(add,foo_array)
print(list_sum)
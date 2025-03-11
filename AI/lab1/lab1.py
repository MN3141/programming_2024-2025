def encode_password(password):

    return password[::-1]

def print_user_info(user,password):

    print(user + "parola este " + password + ",are " + str(len(password)) + " caractere.")

#x = 10
#print("Please enter an integer: ")
#y = int(input())
#print(x,y)
#print("===================")
#print(x+y,x/y,x//y,x*x,x**y)

#slicing
#str_foo = "foobar"
#print(str_foo[:-1])
#print(str_foo[1:])

#print("Enter username: ")
#user = input()
#print("Enter password: ")
#password = input()

#password = encode_password(password)
#print_user_info(user,password)

#========================================
#Dictionary
#my_dict = {"joe":12,"mary":"IPRS"}
#print(my_dict)
#my_dict["hans"]="DE"
#catastif = my_dict
#print(catastif)

#========================================
#Touple
#foo_touple = (20,11,2.5)
# ERROR: foo_touple.append(30)
#print(foo_touple)

#========================================
#Sets
reale = set()
naturale = set()
naturale.add(1)
reale.add(1)
reale.add(-2)
print(naturale.intersection(reale))
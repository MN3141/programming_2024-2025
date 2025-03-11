import random

class Event:

    event_text = ""
    event_id = ""

    def __init__(self,id):
        self.event_id = id

    def set_event_text(text):
        event_text = text

class GameItem:
    item_id = ""
    item_description = ""
    item_value = ""

    def __init__(self,id):
        self.item_id = id

def task0():
    picture = [ [0,0,0,1,0,0,0], [0,0,1,1,1,0,0], [0,1,1,1,1,1,0], [1,1,1,1,1,1,1], [0,0,0,1,0,0,0], [0,0,0,1,0,0,0] ]

    for i in range (0,6):
        for j in range (0,6):
            if picture[i][j] == 0:
                print(" ",end='')
            else: print("*",end='')
        print()

def task1(grade):

    if grade > 10 or grade < 0:
        print("Invalid grade! Please enter again.")
    elif grade in range(9,11):
        print("Excelent")
    elif grade in range (7,9):
        print("Good")
    elif grade in range (5,7):
        print("Decent")
    else:
        print("Restanta, baby!")

def task2():

    random_num = random.randint(1,50)

    num = int(input("Enter number:"))
    if num == random_num:
        print("Congrats, you have guessed it!")

    else:
        while True:
            if num == random_num:
                print("Congrats, you have guessed it!")
                break
            elif num > random_num:
                print("The number is lower.")
            elif num < random_num:
                print("The number is bigger.")
            num = int(input("Enter number:"))

def task3():

    cities = ["Bucuresti","Aiud","Slobozia","Teius"]

    for i, city in enumerate(cities):
        print(i,city)

def task4():

    input_nums = []
    num_counter = 0
    loto_nums = []
    guessed_nums = []

    print("Welcome to Python lotto!")

    while num_counter < 6:

        num = int(input("Choose a number between 1 and 49:"))

        if num > 49 or num < 1:
            print("Choose again!")
        else:
            input_nums.append(num)
            num_counter = num_counter + 1

    for i in range (0,6):
        x = random.randint(1,49)
        loto_nums.append(x)

    for num in input_nums:
        if num in loto_nums:
            guessed_nums.append(num)

    print("Extracted numbers: ",loto_nums)
    print("You have guessed: ",guessed_nums)

def task5():

    print("Welcome to TellTale's newest game!")


def task6():

#task0()
#task1(7)
#task2()
#task3()
#task4()
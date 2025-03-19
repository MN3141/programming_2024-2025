def rock_paper_scissors():

    player0_win_possibilities = ["02","10","21"]
    player1_win_possibilities = ["20","01","12"]

    print("Piatra: 0")
    print("Hartie: 1")
    print("Foarfeca: 2")

    elem0 = int(input("Jucatorul 0 la alegere:"))
    while elem0 not in range(0,3):
        print("Cod gresit! Alege din nou")
        elem0 = int(input("Jucatorul 0 la alegere:"))

    elem1 = int(input("Jucatorul 1 la alegere:"))
    while elem1 not in range(0,3):
        print("Cod gresit! Alege din nou")
        elem1 = int(input("Jucatorul 1 la alegere:"))

    if str(elem0)+str(elem1) in player0_win_possibilities:
        print("Player 0 has won!")
    elif str(elem0)+str(elem1) in player1_win_possibilities:
        print("Player 1 has won!")

    print("Partida noua?")
    print("y - da")
    print("n - nu")
    play_again = input()

    if play_again == "y":
        print("Incepere meci nou...")
        rock_paper_scissors()

def genereza_factura(nume_client, **kwargs):

    suma = 0
    for key, value in kwargs.items():
        suma = suma + value

    print(nume_client,suma)

def normalize_list(num_list):


    #formula: x = (x-min)/(max-min)

    normalized_list = []
    max_num = max(num_list)
    min_num = min(num_list)

    if max_num != min_num:
        for number in num_list:
            normalized_list.append(
                (number - min_num) / (max_num - min_num)
            )
    else:
        print("NU SE POATE NORMALIZA LISTA!")
        return
    return normalized_list

def raise_list(num_list):
    return map(lambda x: x*x,num_list)

def apply_price(prices):

    prices = map(lambda x: x - x*0.1, filter(True,prices))
    return prices

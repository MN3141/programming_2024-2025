import numpy as np
import pandas as pd
import matplotlib as plot
import matplotlib.pyplot as pieplot

data_file = "data.csv"
df = ""
def load_data():

    global df
    df = pd.read_csv(data_file,header=0)

def task0():

    #Afisati primii 10 jucatorii cu varsta > 40
    print(df[df['Age']>40].head(10))

def task1():

    #Afișați toți jucătorii cu Overall ≥ 85 și Age < 25.
    print(df[(df["Overall"]>=85) & (df["Age"]<25)])

def task2():

    #Sortează jucătorii după Skill Moves descrescător.
    print(df.sort_values("Skill Moves",ascending=False))

def task3():

    #Filtrați jucătorii care au contractul până în 2021
    print(df[df['Contract Valid Until']<"2021"])

def task4():

    #Afisati cate randuri si coloane are setul de date. Cati jucatori unici avem
    print("Nr. randuri: ",df.shape[0])
    print("Nr coloane: ",df.shape[1])

    print(df["Name"].unique())

def task5():

    #Care este cea mai frecventa nationalitate a jucatorilor? Afisati top 5 nationalitati.
    print(df["Nationality"].value_counts().head(5))

def task6():

    #Reprezentați într-un pie chart proporția jucătorilor pe naționalități (top 5).

    nat = df["Nationality"].value_counts().head(5).index
    pieplot.pie(df["Nationality"].value_counts().head(5),labels=nat)
    pieplot.show()

def task7():

    #Calculați media atributelor ‘SprintSpeed’ și ‘Acceleration’ pentru fiecare naționalitate. (groupby("Nationality"))
    nationalities = df.groupby("Nationality")["SprintSpeed"].mean()
    print(nationalities)

def task8():

    # Completați valorile lipsă din coloana 'Position' cu stringul "Unknown".
    global df
    df['Position'] = df['Position'].fillna('Unknown')
    print(df['Position'])

def task9():

    #Aflați care club are cea mai mare medie de Overall.
    overall_points = df.groupby("Club")["Overall"].mean()
    max_club = overall_points.idxmax()

    print(max_club)

def task10():

    #Câți jucători au o valoare de transfer mai mare decât salariul?
    #df["Value"] = pd.to_numeric(df["Value"], errors="coerce")
   # df["Wage"] = pd.to_numeric(df["Wage"], errors="coerce")

    print(len(df[df["Value"]> df["Wage"]]))

def task11():

    global df
    #Creați o coloană nouă “is_underpaid” care este True dacă Wage < Value / 100.
    df["Value"] = pd.to_numeric(df["Value"], errors="coerce")
    df["Wage"] = pd.to_numeric(df["Wage"], errors="coerce")

    # Create a new column 'is_underpaid' which is True if Wage < Value / 100
    df["is_underpaid"] = df["Wage"] < df["Value"] / 100
    print(df)

def task12():

    global df
    #Construiți un scor general pentru fiecare jucător pe baza unei formule proprii:
    #ex:Scor = 0.3 * Overall + 0.3 * Potential + 0.2 * SprintSpeed + 0.2 * Passing

    df["SprintSpeed"] = pd.to_numeric(df["SprintSpeed"], errors="coerce")
    df["Potential"] = pd.to_numeric(df["Potential"], errors="coerce")
    df["ShortPassing"] = pd.to_numeric(df["ShortPassing"], errors="coerce")

    df["ULBS Rating"] = 0.3 * df["SprintSpeed"] + 0.3 * df["Potential"] + 0.4 * df["ShortPassing"]

    print(df)

def task13():

    #Care jucatori reprezinta o “afacere buna”?
    #    Afisati doar coloanele Name, Wage, Value intr-un nou df.
    #    Adaugati o noua coloana “difference” in care sa calculati diferenta dintre value(current market value) si wage(current wage).
    #    Afisati jucatorii in ordine descrescatoare, de la cea mare diferenta la cea mai mica.

    df["Value"] = pd.to_numeric(df["Value"], errors="coerce")
    df["Wage"] = pd.to_numeric(df["Wage"], errors="coerce")

    new_df = df[["Name", "Wage"]]
    new_df["“difference”"] = df["Value"] - df["Wage"]

    print(new_df)

load_data()
task13()
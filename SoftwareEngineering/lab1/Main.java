import java.util.ArrayList;
import java.util.HashSet;

import tasks.*;

public class Main {

    public static void task0() {
        // need to investigate enums
        weekDays test[] = weekDays.values();

        for (int i = 0; i < test.length; i++)
            System.out.println(test[i]);
    }

    public static void task1() {
        // create and print a list of 100 elements

        ArrayList<Double> tab = new ArrayList<>();

        for (int i = 0; i < 100; i++)
            tab.add(i, Math.random());

        for (int i = 0; i < tab.size(); i++)
            System.out.println(tab.get(i));

    }

    public static void task2() {

        // HashSet vs TreeSet

        HashSet<String>var = new HashSet<>();
        var.add("TEST1");
        var.add("TEST2");

        for(String index:var){
            System.out.println(index);
        }
    }

    public static void main(String[] args) {
        task0();
        //task1();
        //task2();
    }
}
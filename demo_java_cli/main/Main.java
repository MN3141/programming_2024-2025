//This is a demo for executing Java code from CLI
//javac -compile java code
//java -execute Java code
//javadoc -generate documentation based on existing comments

package main;
import logic.*;

public class Main {
    public static void task0() {
        // polymorphism
         Animal patrocle=new Dog("Pluto");
         patrocle.eat();
    }

    public static void task1() {
        //interface test

        Animal tia=new Dog("Tia");
        tia.die();

    }

    public static void main(String[] args) {
        // Comment every stuff
        // Documentation > Design Patterns

        System.out.println("Hello CLI Java!");
        task0();
        task1();
    }
}
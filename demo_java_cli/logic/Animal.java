package logic;
//Test to import packages into Main class
//Note if the Java classes are in the 
//same directory,then javac does not
//need any new arguments

public class Animal implements Die {
    
    String name;

    public Animal(String name){
        this.name=name;
    }

    public void eat()
    {
        System.out.println(this.name+" animal eat");
    }

    public void die()
    {
        System.out.println("Dead animal");
    }

}

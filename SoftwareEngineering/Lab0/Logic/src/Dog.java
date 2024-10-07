public class Dog extends Animal {

    public Dog(String name) {
        super(name);
        //constructor
    }
    public void eat()
    {
        System.out.println("Dog "+this.name);
    }
}

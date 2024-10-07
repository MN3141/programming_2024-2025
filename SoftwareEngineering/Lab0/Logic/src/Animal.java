public class Animal implements Die {

    String name;

    public Animal(String name) {
        this.name = name;
        //function overloading
    }

    public void eat(){
        System.out.println(this.name);
    }
    public void die(){}{
        System.out.println(this.name+" has died");
    }
}

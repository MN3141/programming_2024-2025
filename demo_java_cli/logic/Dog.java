//When packaged,the javac need a relative(or absolute)
//path to main module(class)

package logic;

public class Dog extends Animal{

    public Dog(String name){
        super(name);
    }

    public void eat(){

        System.out.println(this.name+" dog eat");
    }

    public void die()
    {
        System.out.println("Dead dog");
    }
}

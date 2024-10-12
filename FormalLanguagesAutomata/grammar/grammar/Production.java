package grammar;

import java.util.ArrayList;
import java.util.Random;

//This class shall model how a grammar rule behaves
public class Production {
    
    private String inputSymbol;//there is only one input
    private ArrayList<String> output;//the can be multiple outputs
                                    //~ shall be considered the null element

    public Production(String inputSymbol, ArrayList<String> output)
    {
        this.inputSymbol=inputSymbol;
        this.output=output;
    }

    public String getInputSymbol(){

        return this.inputSymbol;
    }

    public ArrayList<String> getOutput(){

        return this.output;
    }

    //apply gramatical rule
    public String applyRule(String symbol)
    {
       String outputSymbol="012345";//initial state

        if(!symbol.equals(this.inputSymbol))

            outputSymbol="-1"; //no rule is defined for the given symbol
        
        else{
            //the rule may produce multiple outputs.
            //in order to decide,a random integer will be chosen

            Random randomNum=new Random();
            int randomIndex=randomNum.ints(0,this.output.size()).findFirst().getAsInt();

            outputSymbol=this.output.get(randomIndex);
            if(outputSymbol.equals("~"))//null element
                outputSymbol="";
        }

        return outputSymbol;
    }

}

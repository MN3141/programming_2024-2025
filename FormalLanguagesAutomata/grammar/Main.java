import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import grammar.*;

public class Main {

    public static Grammar readInput(String fileName){

        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
            
          String nonTerminals=br.readLine();//get non terminal symbols
          String [] nonTerminalTokens=nonTerminals.split(",");//we only want the non terminal symbols
          
          ArrayList<String> nonTerminalSymbols=new ArrayList<>(Arrays.asList(nonTerminalTokens));
    
          String terminals=br.readLine();//get terminal symbols
          String [] terminalTokens=terminals.split(",");
          ArrayList<String> terminalSymbols=new ArrayList<>(Arrays.asList(terminalTokens));

          ArrayList<Production> productions=new ArrayList<>();
        int rulesNumber=nonTerminalSymbols.size();
        //get each rule/production
        for(int i=0;i<rulesNumber;i++){
            String ruleLine=br.readLine();
            //example of a rule:
            //E>TG|a,where E is the inputSymbol and TG is the output string
            //> denotes the flow 
            //| denotes the OR operator,meaning the in left part of the rule can generate an alternative output
            String [] ruleTokens=ruleLine.split("[>|]");
            ArrayList<String> ruleString=new ArrayList<>(Arrays.asList(ruleTokens));
            
            String inputSymbol=ruleString.get(0);
            ArrayList<String> ruleOutput=new ArrayList<>();
            for(int j=1;j<ruleString.size();j++)
                ruleOutput.add(ruleString.get(j));

           Production tempProduction=new Production(inputSymbol, ruleOutput);
           productions.add(tempProduction);
        }
        String startSymbol=br.readLine();
        Grammar grammar=new Grammar(nonTerminalSymbols, terminalSymbols, startSymbol, productions);

        return grammar;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static void main(String[] args) {
        
        Grammar g2=readInput("grammar_parameters.txt");
        ArrayList<String> producedVocabulary=g2.leftMostDerivation(4, 100);

        for(String word:producedVocabulary)
        {
            System.out.println(word);
            System.out.println("=======================");;
            }
    }

}

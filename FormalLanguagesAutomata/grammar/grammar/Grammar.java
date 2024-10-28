package grammar;

import java.util.ArrayList;

//This class shall model how a grammar behaves
public class Grammar{

    private ArrayList<String> nonTerminalSymbols;
    private ArrayList<String> terminalSymbols;
    private String startSymbol;
    private ArrayList<Production> productions;

    public Grammar(ArrayList<String> nonTerminalSymbols,ArrayList<String> terminalSymbols,String startSymbol, ArrayList<Production> productions){
        this.nonTerminalSymbols=nonTerminalSymbols;
        this.terminalSymbols=terminalSymbols;
        this.startSymbol=startSymbol;
        this.productions=productions;
    }

    public ArrayList<String> getNonTerminalSymbols(){

        return this.nonTerminalSymbols;
    }

    public ArrayList<String> getTerminalSymbols(){

        return this.terminalSymbols;
    }

    public String getStartSymbol(){

        return this.startSymbol;
    }

    public ArrayList<Production> getProductions(){

        return this.productions;
    }
    
    private boolean isTerminal(String string)
    {
        //Check if a given string is formed of only terminal symbols

        boolean isTerminal=false;
        int terminalCounter=0;

        for(int i=0;i<string.length();i++)
        {
            char stringSymbol=string.charAt(i);

            if(this.terminalSymbols.contains(stringSymbol+"")) //concatenating with empty string the char shall become a string
                terminalCounter++;
        }

        if(terminalCounter==string.length())
            isTerminal=true;
        
        return isTerminal;
    }
     //leftmost derivation until all symbols are terminal or the string length surpasses the limit
    public ArrayList<String> leftMostDerivation(int vocabularySize,int maxWordSize)
    {        
        ArrayList<String> outputVocabulary=new ArrayList<>();

        for(int wordCounter=0;wordCounter<vocabularySize;wordCounter++)
        {
            String word=this.startSymbol;
            boolean onlyTerminals=false;
            int symbolIndex=0; //used for taking the first leftmost non terminal symbol

            while(word.length()<=maxWordSize && !onlyTerminals){
               
                if(this.terminalSymbols.contains(word.charAt(symbolIndex)+"")) //check if the leftmost symbol is a terminal one
                    symbolIndex++;

                String tempSymbol=word.charAt(symbolIndex)+"";//concatenating with empty string the char shall become a string
                for (Production production : this.productions) {
                    
                    //if there is no rule,then the returned string shall be -1
                    if(!production.applyRule(tempSymbol).equals("-1")){

                        StringBuilder sb=new StringBuilder(word);
                        sb.deleteCharAt(symbolIndex);//delete the non terminal symbol
                        sb.insert(symbolIndex, production.applyRule(tempSymbol));
                        word=sb.toString();
                        word=word.replace(tempSymbol, "");
                    }
                }
                if(this.isTerminal(word)==true)
                    onlyTerminals=true;
            }
            outputVocabulary.add(word);
        }
        return outputVocabulary;
    }
}
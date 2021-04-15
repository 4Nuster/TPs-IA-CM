package com.company;

import org.tweetyproject.logics.dl.reasoner.NaiveDlReasoner;
import org.tweetyproject.logics.dl.syntax.*;

public class Main {

    static void example1(){
        AtomicConcept legume = new AtomicConcept("legume");
        AtomicConcept fruit = new AtomicConcept("fruit");

        Individual courgette = new Individual("courgette");
        Individual orange = new Individual("orange");

        EquivalenceAxiom legumeNotFruit = new EquivalenceAxiom(legume, fruit.complement());
        EquivalenceAxiom fruitNotLegume = new EquivalenceAxiom(fruit, legume.complement());

        ConceptAssertion courgetteLegume = new ConceptAssertion(courgette, legume);
        ConceptAssertion orangeFruit = new ConceptAssertion(orange, fruit);

        DlBeliefSet dbs = new DlBeliefSet();
        dbs.add(courgetteLegume);
        dbs.add(orangeFruit);

        System.out.println(dbs);
        System.out.println("ABOX: "+dbs.getABox());
        System.out.println("TBOX: "+dbs.getTBox());

        System.out.println("\nBase de connaissances: ");
        for(DlAxiom d : dbs) System.out.println(d);

        NaiveDlReasoner reasoner = new NaiveDlReasoner();
        System.out.println("courgette est un legume?");
        System.out.println(reasoner.query(dbs, new ConceptAssertion(courgette, legume)));
        System.out.println("orange est un legume?");
        System.out.println(reasoner.query(dbs, new ConceptAssertion(orange, legume)));
    }

    public static void main(String[] args) {
	// write your code here
        example1();
    }
}

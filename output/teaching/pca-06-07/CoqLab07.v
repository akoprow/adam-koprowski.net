(*
 *  Proving with computer assistance, February 2007.
 * Exercises with the proof assistant Coq
 *
 *  Coq is a free program available via the site 
 * http://coq.inria.fr. There are compiled binary versions 
 * for Linux and Windows. This script uses the syntax of 
 * Coq v8.0 and is not compatible with the earlier
 * versions of Coq.
 *
 *  For this practicum it is recommended that you install Coq
 * IDE (an alternative is ProofGeneral).
 *
 *  Minimum recommended set of exercises: 1,4,7
 * 
 *  For more information, look at:
 * http://www.win.tue.nl/~akoprows/teaching/Coq
 *)

Section Introduction.

(* 
   Using the command Goal we enter the proof mode and set the
 proposition that we will try to prove.
*)

Goal forall A B C: Prop, (A -> B -> C) -> (A -> B) -> (A -> C).

intros.
apply H.
assumption.
apply H0.
assumption.
(*  
  The proof is now complete. It can be saved for future use 
 with the command Save, followed by a name for the new
 theorem. This also ends the proof mode.
*)
Save Tautology1.

(*  
  To prove and save the result above, we could also have 
 stated it as a Theorem or Lemma, as follows: 

Theorem (or Lemma) Tautology1: 
forall A B C:Prop, (A -> B -> C) -> (A -> B) -> (A -> C).
Proof.
[...]
Qed.

  With Qed. the proof is validated and added to the environment. 
  In fact this method is usually preferred unless we do not
 want to give a name to a proof.
*)

(*
 The natural numbers are pre-defined in Coq as
> nat: Set
 Check that with the command
> Check nat.
  The terms "O" and "S" represent the natural number zero 
 and the successor function (adding of 1). Check their 
 types with the Check command.
*)
Check nat.
Check O.
Check S.

(* 
  The function that adds two to its argument can be defined as: 
*)
Definition Add_two := fun x:nat => S (S x).

(* But also, the number two can be defined as *)
Definition two := 2.
(* 
  We could have also used "S (S 0)" in place of "2", they are
 equivalent
*)

(* Now two can be used in the definition of the function: *)

Definition Add_two' (x: nat) := x + two.

(*  
  Note the parameter in the definition. This is a syntactic
 sugar and a more readable way of writing:
> Definition Add_two'' := fun x: nat => x + two.
*)

(*
  One example on how the notion of equality can be introduced
 in Coq. (Note: Coq has already a built-in equality denoted by
 the symbol "=", but in this example we define our own).
*)
Variable IS : forall A: Set, A -> A -> Prop.

(* 
  The line above only defines "IS" as a binary relation on an 
 arbitrary set "A" - this is a polymorphic equality. 
 Reflexivity can be introduced by an extra axiom:
*)
Axiom refl: forall (A: Set) (z: A), IS A z z.

(* 
  Now we should be able to prove "IS nat (Add_two O) two" and 
 indeed  this is the case as shown below  
*)

Goal (IS nat (Add_two O) two).
apply refl.
Qed.

Goal (IS nat (Add_two' O) two).
apply refl.
Qed.

(* 
  What happened here? Coq can see that 
 "IS nat (Add_two' O) two)" is an instance of the reflexivity 
 axiom "IS A z z". It takes "nat" for the set "A" and "two" for
 "z", but "two" is (by definition) equal to 
 "Add_two' O". This check is performed automatically as 
 follows:

Add_two' O =                    (By unfolding Add_two)
0 + two =                       (By beta-reduction)
two

   Hence, when comparing two terms, Coq folds or unfolds 
 definitions as necessary 
*)

(* ==========================================================*)

(* 
  This example shows how we can do classical logic in Coq

  Suppose we want to prove that for all propositions "A" and "B" 
 the following holds: "(~A -> B) -> (~B -> A)".
  Note that negation is defined as
> Definition not (A: Prop) := A -> False
 and "~A" is an abbreviation for "not A".
  Let us give this proposition the name contra (from
 contraposition): 
*)
Print not.

Definition contra := forall A B: Prop, (~A -> B) -> (~B -> A).
Print contra.

(*  
  You can try to prove contra using the tauto or the intuition 
 tactic:

> Goal contra.
> tauto.

  Unfortunately, Coq cannot prove contra with the tactic 
 tauto or intuition, because it is not provable in the
 constructive logic of Coq. To prove this proposition, we
 need the axiom for double negation: 
*)
Hypothesis classical: forall A: Prop, ~~A -> A.

(* With this extra axiom we can prove contra *)

Goal contra.
unfold contra.
intros.
apply classical.
(* 
 The goal at this moment is

  A : Prop
  B : Prop
  H : ~A->B
  H0 : ~B
  ===================
  ~~A

 Remember the definition of "not"? "~~A" can also be written 
  as "~A -> False", so...
*)

intro.

(*
 This results in the following goal:
  A : Prop
  B : Prop
  H : ~A->B
  H0 : ~B
  H1 : ~A
  ===================
  False

 In this context, from "H" and "H1" we can obtain a proof of 
"B" and since H0 is a proof of "~B" (i.e. "B -> False"), we 
will get False. However, Coq always works in a backwards 
manner, we need to use first "H0" (and then the goal will be to 
prove "B"). Next, to prove "B", we will need to use "H" (and 
the goal will become "~A"). The final step will be trivial, 
because "H1" is a proof of "~A".
*)

apply H0.

(*
  A : Prop
  B : Prop
  H : ~A->B
  H0 : ~B
  H1 : ~A
  ===================
  B
*)
apply H.

(*
  A : Prop
  B : Prop
  H : ~A->B
  H0 : ~B
  H1 : ~A
  ===================
  ~A
*)

assumption.

(* To see the proof-term that we created, use Show Proof: *)
Show Proof.

(*
> Proof: fun (A B: Prop)(H: ~A -> B)(H0: ~B) =>
>    classical A (fun H1: ~A => H0 (H H1))

  Although we prove a formula in classical logic, you can still
 use the automated tactics of Coq. They will work for subgoals
 that do not require the axiom "classical"
*)
Qed.

(* 
  The part with the worked-out examples ends here. Now you can 
 try to prove the exercises below yourself.
*)

End Introduction.

(* ===========================================================*)

(*
  ===== Exercise 1. (implications) =====
 Prove the following propositions: 

  Remember about Admitted command which allows you to skip any
 lemma without giving a proof.
*)
Lemma L1_1: forall p q r: Prop, 
  (p -> q) -> (q -> r) -> (p -> r).

Lemma L1_2: forall p q: Prop, (p -> p -> q) -> (p -> q).

Lemma L1_3: forall p q: Prop, (p -> q) -> (p -> p -> q).

Lemma L1_4: forall p q r:Prop, (p -> q -> r) -> (q -> p -> r).

(*
  ===== Exercise 2. (falsum) =====
 Define "false" as follows: 
*)
Definition false := forall p: Prop, p.
Check false.

(* 
  Prove that from "false" follows any other proposition, 
 i.e. prove the following 
*)
Lemma ex_falso: forall p:Prop, false -> p.

(* Prove the following propositions: *)

Lemma L2_1: forall p q: Prop, (p -> q) -> ~q -> ~p.
Lemma L2_2: forall p: Prop, p -> ~~p.

Lemma L2_3: forall p: Prop, ~~~p -> ~p.

(* 
  ===== Exercise 3 =====
 Introduce the following axiom 
*)

Axiom classical: forall p: Prop, ~~p -> p.

(* Using it prove: *)

Lemma L3_1: forall p q: Prop, (~q -> ~p) -> (p -> q).

(* 
  For the following lemma you may want need to use the tactic:
> absurd X
  that changes the present goal to two subgoals: "X" and "~X".

   You may find this lemma difficult to prove - if so then
 skip it and do not spend too much time on it.
*)
Lemma L3_2: forall p q: Prop, ((p -> q) -> p) -> p.

(* 
  ===== Exercise 4. (conjunction) =====
  Define conjunction by 
*)

Definition AND (p q:Prop) := 
  forall (a: Prop), (p -> q -> a)->a.

Check AND.

Lemma projl: forall p q: Prop, AND p q -> p.

Lemma projr: forall p q: Prop, AND p q -> q.

Lemma pair:  forall p q: Prop, p -> q -> AND p q.

(* 
  Note: Coq defines conjunction and disjunction in a different
 way than the one we are using here. More information on this 
 can be found in the Coq tutorial (see the Coq homepage) 
*)

(* 
  ===== Exercise 5. (disjunction) =====

 Define disjunction as follows 
*)

Definition OR (p q: Prop) := forall (a: Prop), 
 (p -> a) -> (q -> a) -> a.
Check OR.

(* Prove the following tautologies: *)

Lemma inl: forall p q: Prop, p -> OR p q.

Lemma inr: forall p q: Prop, q -> OR p q.

(* 
  ===== Exercise 6. (more junctions) =====

 Prove the following using the lemmas proved in Exercise 4
 and 5: 
*)

Lemma L6_1: forall p q: Prop, AND p q -> OR q p.

Lemma L6_2: forall p q: Prop, AND p q -> AND q p.

Lemma L6_3: forall p q r: Prop, OR (OR p q) r -> OR p (OR q r).

(* 
  ===== Exercise 7 (Inductive types) =====

 Define the type of the finite lists of natural numbers: 
*)

Inductive List: Set :=
 | nil: List
 | cons: nat -> List -> List.

(* 
  Coq defines automatically the corresponding induction 
 principle: 
*)
Check List_ind.

(* 
  Hence we can prove properties of lists of natural numbers 
 by induction. Furthermore, we can define functions with 
 recursion: 
*)

(* Length of a list, defined by pattern matching. *)
Fixpoint Len (L: List) : nat :=
 match L with
 | nil => O
 | cons l ls => S (Len ls)
 end.

(* 
  Appending two lists.
  For recursive definitions to be well-defined one of the 
 arguments must be decreasing (becoming smaller in the 
 recursive call to ensure that the recursion will terminate). 
 If there is more than one parameter we must inform Coq which
 one is decreasing by the "struct" keyword.
*)
Fixpoint Append (L R: List) {struct L} : List :=
 match L with
 | nil => R
 | cons l ls => cons l (Append ls R)
end.

Print Append.

(* Prove the following: *)

Lemma Len_nil: Len nil = O.

Lemma Len_Append: forall L R: List, 
  Len (Append L R) = Len L + Len R.

(* 
  We define a function Reverse that given a list returns 
 another list with the elements of the first in reverse order 
*)

Fixpoint Reverse (L: List) : List :=
 match L with
 | nil => nil 
 | cons l ls => Append (Reverse ls) (cons l nil)
 end.

Lemma Reverse_nil: Reverse nil = nil.

Lemma Reverse_two_elts: forall a b: nat, 
 Reverse (cons a (cons b nil))= cons b (cons a nil).

(* 
  In the following lemma you may need to use the commutativity
 of plus. This result is present in Coq standard library
 together with plenty of other results.
 See: http://coq.inria.fr/library-eng.html

  Libraries can be loaded using "Require Import" command.
*)
Require Import Arith.
(*
  You can search for all results concerning plus (or any other 
 definition) with the following command:
*)
SearchAbout plus.
(*
  The lemma stating commutativity of plus is called "plus_comm"
*)
Check plus_comm.

(* 
  Prove that Reverse returns a list of the same size as 
 its argument 
*)
Lemma Reverse_Len: forall L: List, Len (Reverse L) = Len L.

(* 
  Prove that if we apply Reverse two times we get back the 
 original list. For that you may need a number of auxiliary 
 lemmas, like: associativity of Append
*)
Lemma Append_assoc: forall L R T: List, 
 Append (Append L R) T = Append L (Append R T).

(*
  ... appending with an empty list as second argument
*)
Lemma Append_nil: forall L: List, Append L nil = L.

(*
 ... and distributivity of Reverse with Append
*)
Lemma Reverse_Append: forall L R: List, 
 Reverse (Append L R) = Append (Reverse R) (Reverse L).

(*
 Finally: double Reverse
*)
Lemma Reverse_twice: forall L: List, L = Reverse (Reverse L).

(*
  ===== Exercise 8. (naive set representation) ===== 

 Introduce a variable U of type Set.: 
*)

Variable U: Set.

(* 
   We can think of the predicates on "U" as sets, i.e. "U" is the 
 'universe' of all objects and a set is a predicate that describes
 which of the elements of the universe belong to it. If "A" is of 
 type "U -> Prop" then "A" can be seen as the set {x:U | A(x)}, 
 the elements of U for which the predicate holds. Hence we define
*)
Definition SET := U -> Prop.

(* 
  If "A: SET" and "x: U" then "A x" means `x is an element of A'. 
*)

(* 1. Define the subset relation on SET. *)
Definition subset (P Q: SET) := forall x: U, P x -> Q x.
Check subset.

(* 2. Prove that subset is reflexive and transitive *)
Lemma subset_refl: forall A: SET, subset A A.

Lemma subset_trans: forall A B C: SET, 
 subset A B -> subset B C -> subset A C.

(* 
  3. Using subset, define equality, union and intersection of 
 SETs. Note that "/\" is Coq notation for conjunction and "\/"
 for disjunction.
*)
Definition eq_set (A B: SET) := subset A B /\ subset B A.
Definition union (A B: SET) := fun x:U => A x \/ B x.
Definition intersection (A B: SET) := fun x:U => A x /\ B x.

(* 4. Prove *)
Lemma intersection_subset: forall A B: SET,
  subset (intersection A B) A.

Lemma subset_union: forall A B: SET,
  subset A (union A B).

Lemma union_double: forall A: SET, eq_set (union A A) A.

(* 
  5. Define the empty set and prove that it is a subset of every 
 other SET. 
*)
Definition empty := fun x:U => False.

Lemma empty_subset: forall A: SET, subset empty A.

(*
 * ISR '10: International School on Rewriting.
 *
 * Day 1: Introduction to Coq.
 *
 * This script is compatible with Coq 8.2pl1
 *)

(* 
   Using the command [Lemma] we enter the proof mode and state a simple
  proposition that we will try to prove.
*)

Lemma tauto1: forall A B C : Prop, (A -> B -> C) -> (A -> B) -> (A -> C).
Proof. (* the [Proof] command is optional, but it is customary to use it *)
  intros A B C abc ab a.
  apply abc.
  assumption.
  apply ab.
  assumption.
Qed. (* The proof is now complete, we finish it with [Qed]. *)

(* =========================================================== 
 *  You should do Exercises 1 & 2. 
 *  The remaining ones are optional and you can try to do them
 * in an order of your choice. In particular you may want to 
 * try Exercise 9, which has a bit more "practical" flavor.
 * =========================================================== *)

(*
  ===== Exercise 1. (implications) =====
  Prove the following propositions: 

  You will need tactics: 
    intro(s)   - implication/forall introduction
    apply      - applying lemmas/hypotheses (think modus ponens)
    assumption - solves the goal if convertible with one of the hypotheses
*)
Lemma L1_1: forall p q r : Prop, 
  (p -> q) -> (q -> r) -> (p -> r).
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma L1_2: forall p q : Prop, (p -> p -> q) -> (p -> q).
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma L1_3: forall p q : Prop, (p -> q) -> (p -> p -> q).
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma L1_4: forall p q r : Prop, (p -> q -> r) -> (q -> p -> r).
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
  ===== Exercise 2 (Simple inductive types) =====

 Define the type of the finite lists of natural numbers as follows: 
*)

Inductive natlist : Set :=
| nil : natlist
| cons : nat -> natlist -> natlist.

(* 
   For readability we can introduce some notations for lists. 
   For starters we will write [cons] with an infix operator [::],
   so that [cons hd tl] becomes [hd::tl].
*)

Infix "::" := cons (at level 60, right associativity).

(* 
   We can also obtain an usual rendering of lists [x1; x2; ... xn]
   with the following commands.
*)

Notation " [ ] " := nil.
Notation " [ x ] " := (cons x nil).
Notation " [ x ; .. ; y ] " := (cons x .. (cons y nil) ..).

(* 
   For our definition [natlist] Coq automatically inferred the corresponding 
   induction principle: 
*)
Check natlist_ind.

(* 
   Hence we will be able to prove properties of lists of natural numbers 
   by induction. 

   Furthermore, we can define functions by recursion: 
*)

(* Length of a list, defined by pattern matching. *)
Fixpoint length (l : natlist) : nat :=
  match l with
  | [] => O
  | x::xs => S (length xs)
  end.

(* 
   Let's define a concatenation of two lists.
   For recursive definitions to be well-defined one of the arguments must be 
 structurally smaller in the recursive call (that's an easy syntactical 
 criterion to ensure termination of the recursion). 
   We can inform Coq which argument it is with the [{struct ARG}] annotation
 (though in most cases it would infer it for us).
   We also combine function definition with a custom notation for it.
*)
Reserved Notation "l ++ r" (at level 60).
Fixpoint append (l r : natlist) {struct l} : natlist :=
 match l with
 | [] => r
 | x::xs => x::(xs ++ r)
 end
 where "l ++ r" := (append l r).

Print append.

(* 
   Now, prove the following simple properties about those operations: 

   You will need some new tactics: 
     simpl       - simplification, 
     reflexivity - solves equality goals with convertible sides of the equality
     rewrite     - equality rewriting
     unfold      - unfolding definitions, 
     induction   - performing induction
*)

Lemma length_nil : length nil = O.
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma length_append: forall l r : natlist,
  length (l ++ r) = length l + length r.
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
   Now define a function reverse that given a list returns a list with
 elements in the reversed order.
*)

Fixpoint reverse (l : natlist) : natlist :=
  l. (* This is obviously incorrect... REPLACE, with a proper definition *)

(* 
   Before proving general properties it's often a good idea to try a new
 function on some examples:
*)

Eval vm_compute in reverse [1; 2; 3; 5; 8; 13].

(*
   Now let's prove few simple, general properties.
*)

Lemma reverse_nil : reverse [] = [].
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma reverse_two : forall m n : nat, 
  reverse [m; n] = [n; m].
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
   In the following lemma you may need to use the commutativity of plus. 
 This result is present in Coq standard library together with plenty of 
 other results.
 See: http://coq.inria.fr/stdlib

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
   Prove that Reverse returns a list of the same size as its argument.
   Remember that [rewrite] and [apply] can be used with previously proven
 lemmas and not only with local hypotheses.
*)
Lemma reverse_len: forall l : natlist, 
  length (reverse l) = length l.
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
   Now we will try to prove that if we apply [reverse] twice, we get back 
 the original list.

   For that we will first prove a lemma characterizing interaction of
 [reverse] with [append].
   To prove it you may need some more results on [append]. Try to come 
 up with them yourself (you can state them as auxiliary lemmas, before
 attacking [reverse_append]).
*)
Lemma reverse_append : forall l r : natlist, 
  reverse (l ++ r) = reverse r ++ reverse l.
Proof.
  (* FILL IN HERE *)
Admitted.

(*
   Now it should be easy to prove our main result:
*)
Lemma reverse_twice: forall l : natlist, 
  reverse (reverse l) = l.
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
  ===== Exercise 3. (conjunction) =====

  Define conjunction by 
*)

Definition AND (p q : Prop) := 
  forall (a : Prop), (p -> q -> a) -> a.

(* 
   Note: Coq defines conjunction and disjunction in a different
 way. We will learn about that in the following lecture...
*)

Check AND.

Lemma projl : forall p q : Prop, AND p q -> p.
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma projr: forall p q : Prop, AND p q -> q.
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma pair:  forall p q: Prop, p -> q -> AND p q.
Proof.
  (* FILL IN HERE *)
Admitted.

(*
  ===== Exercise 4. (disjunction) =====

 Define disjunction as follows 
*)

Definition OR (p q : Prop) := forall (a : Prop), 
 (p -> a) -> (q -> a) -> a.

Check OR.

(* Prove the following tautologies: *)

Lemma inl: forall p q : Prop, p -> OR p q.
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma inr: forall p q : Prop, q -> OR p q.
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
  ===== Exercise 5. (more junctions) =====

 Prove the following using the lemmas proved in Exercises 3 and 4.

 You may find the command [apply ... with ...] useful, which allows to
 specify instantiation variables for the applied lemma/hypothesis. 
 Alternatively, note that [apply] takes a term as parameter, so you can
 provide it with a hypothesis/lemma applied to some arguments: 
 [apply (H a0 ... an)].
*)

Lemma L5_1 : forall p q : Prop, AND p q -> OR q p.
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma L5_2 : forall p q : Prop, AND p q -> AND q p.
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma L5_3 : forall p q r : Prop, OR (OR p q) r -> OR p (OR q r).
Proof.
  (* FILL IN HERE *)
Admitted.

(*
  ===== Exercise 8. (naive set representation) ===== 

 Introduce a variable U of type Set.: 
*)

Variable U : Set.

(* 
   We can think of the predicates on "U" as sets, i.e. "U" is the 
 'universe' of all objects and a set is a predicate that describes
 which of the elements of the universe belong to it. If "A" is of 
 type "U -> Prop" then "A" can be seen as the set {x:U | A(x)}, 
 the elements of U for which the predicate holds. Hence we define
*)
Definition set := U -> Prop.

(* 
  If "A : set" and "x : U" then "A x" means `x is an element of A'. 
*)

(* Define the subset relation on SET. *)
Definition subset (P Q : set) := forall x : U, P x -> Q x.
Check subset.

(* Prove that subset is reflexive and transitive *)
Lemma subset_refl : forall A : set, subset A A.
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma subset_trans: forall A B C : set, 
 subset A B -> subset B C -> subset A C.
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
   Using subset, define equality, union and intersection of 
 SETs. Note that "/\" is Coq notation for conjunction and "\/"
 for disjunction.
*)
Definition eq_set (A B : set) := subset A B /\ subset B A.
Definition union (A B : set) := fun x : U => A x \/ B x.
Definition intersection (A B : set) := fun x : U => A x /\ B x.

(* Prove *)
Lemma intersection_subset: forall A B : set,
  subset (intersection A B) A.
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma subset_union: forall A B : set,
  subset A (union A B).
Proof.
  (* FILL IN HERE *)
Admitted.

Lemma union_double: forall A : set, 
  eq_set (union A A) A.
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
   Define the empty set and prove that it is a subset of every other SET. 
*)
Definition empty := fun x : U => False.

Lemma empty_subset: forall A : set, 
  subset empty A.
Proof.
  (* FILL IN HERE *)
Admitted.

(* 
  ===== Exercise 9. =====

  It is a fact that with coins of face value 3 and 5 one can
  pay any value higher than 8. Can you prove it?

  Hints: 
   - to do case analysis on equality of natural numbers,
     you can use the library function [eq_nat_dec].
     { P } + { Q } is a type of rich booleans, i.e.
     a value of this type carries either a proof of
     P or a proof of Q. 
     See: http://coq.inria.fr/stdlib/Coq.Init.Specif.html#sumbool
   - You can use a special tactic [omega] for reasoning
     with linear arithmetic.
   - You may need to use a tactic [absurd P], which turns
     arbitrary goal into two subgoals to be proven: [P] and [~P].
     Alternatively: [elimtype False] turns any goal into [False].
*)

Check eq_nat_dec.
Require Import Omega. (* to use [omega] *)

Lemma coins: forall n : nat, n >= 8 ->
  exists v3, exists v5, n = 3*v3 + 5*v5.
Proof.
  (* FILL IN HERE *)
Admitted.

Require Import Arith. 

SearchAbout lt.

Section CaseDistinctions.

(* Definitions using case distinctions *)

Check eq_nat_dec.

(* What 'eq_nat_dec' states is that for two arbitrary natural
 * numbers 'n' and 'm', either they are equal 'n = m' or they
 * are different 'n <> m'. In classical logic this is trivial 
 * due to the axiom of excluded middle. However in the 
 * constructive logic of Coq this actually has to be proven.
 * The proof essentialy gives a decision procedure that given
 * two natural numbers checks whether they are equal or not.
 *
 * Let's see how this result can be employed.
 *)

Definition is_one (n : nat) : Prop :=
  if (eq_nat_dec n 1) then True else False.

(* Another way of doing the same: *)

Definition is_one' (n : nat) : Prop :=
  match (eq_nat_dec n 1) with
  | left _ => True
  | right _ => False
  end.

Lemma is_one_test : is_one 1.
Proof.
  unfold is_one.
  simpl.
  trivial.
Qed.

(* More complicated case distinction: *)

Check lt_eq_lt_dec.

(* this is a nested construction:

 inleft _ : ( {n<m} + {n=m} )
 inleft (left _ ): {n<m}
 inleft (right _): {n=m}
 inright _: {m<n}

The following definition should clarify this: *)

Definition cases_dist n :=
match (lt_eq_lt_dec n 3) with
| inleft (left _) => 1
| inleft (right _) => 3
| inright _ => 5
end.

(* An example of a trivial proof with case distinction: *)

Lemma cases_dist_easy : forall n, 6 > cases_dist n.
Proof.
  intro.
  unfold cases_dist.
  (* case distinction performed with 'destruct' - very 
     useful tactic to work with inductive types *)
  destruct (lt_eq_lt_dec n 3).
  destruct s.
  (* the rest can be taken care of with intuition: *)
  intuition.
  intuition.
  intuition.
Qed.

(* Similar approach can be used to reason about min function *)

Require Import Min.

Check min_dec.

Lemma min_split : forall m n, min m n = m \/ min m n = n.
Proof.
  intros.
  destruct (min_dec m n).
  left.
  assumption.
  right.
  assumption.
Qed.

(* If using Coq 8.1 such case distinctions can be done more
 * easily and elegantly using the newly introduced nat_compare
 * construct: 
 *)
Print nat_compare.

(* cases_dist' analogous to cases_dist above can then be 
 * written as:
 *)
Definition cases_dist' n :=
match nat_compare n 3 with
| Lt => 1
| Eq => 3
| Gt => 5
end.

Lemma cases_dist_eq : forall n, cases_dist n = cases_dist' n.
Proof.
 intros.
 unfold cases_dist, cases_dist', nat_compare. 
 destruct (lt_eq_lt_dec n 3). 
 destruct s.
 trivial.
 trivial.
 trivial.
Qed.

End CaseDistinctions.

(*  We finish with a more realistic example from the lecture:
 * coins problem. 
 *  The problem states that any amount greater or equal than 8
 * can be spent using coins with nominals 3 and 5.
 *)

Require Import Arith.
(* This example involves some "complex" arithmetics so
 * we will take advantage of a powerful 'omega' tactic.
 *)
Require Import Omega.

Lemma coins: forall i,
  exists v3, exists v5, i + 8 = 3*v3 + 5*v5.
Proof.
  induction i.
   (* induction base *)
  exists 1.
  exists 1.
  trivial.
   (* induction case *)
  destruct IHi.
  destruct H.
   (* we need to know whether x0 is 0 or not
    * by destructing it we do case analysis with respect
    * to inductive definition of natura numbers so we get
    * cases where x0 = 0 and where x0 = S x1, exactly
    * what we need.
    *)
  destruct x0.
   (* x0 = 0 *)
  exists (x - 3). 
  exists 2.
  omega.
   (* x0 > 0 *)
  exists (x + 2).
  exists x0.
  omega.
Qed.

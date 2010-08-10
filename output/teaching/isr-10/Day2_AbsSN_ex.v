(*
 * ISR '10: International School on Rewriting.
 *
 * Day 2: Proving strong normalization of relations
 *
 * This script is compatible with Coq 8.2pl1
 *
 * Your goal: get rid of all 'Admitted' in this file :)
 *)

Require Import Relations.

Set Implicit Arguments.

(* 
   [relation T] is a binary relation on set [T]. It is defined as follows:
*)
Print relation.

Section SN.

  Variables (A : Type) (R : relation A).

  (* 
     No we define a notion of strong normalization (SN) of a single element. 
   An element [x] is SN with respect to a relation [R] if all its successors
   are SN with respect to [R].
   *)
  Inductive SN : A -> Prop :=
    SN_intro : forall x, (forall y, R x y -> SN y) -> SN x.

  Check SN_ind.

  (* 
     Trivial consequence of the above definition.
   *)
  Lemma SN_inv : forall x, SN x -> forall y, R x y -> SN y.
  Proof.
    destruct 1; trivial.
  Qed.

  (*
     Now we say that a relation is well-founded, if all its elements are SN.
   *)
  Definition WF := forall x, SN x.

End SN.

(* 
   Now we will introduce custom notations for relational operations 
 defined  in Coq's standard library (you can see those definitions in 
 modules  [Relations.Relation_definitions] and [Relations.Relation_operators].
   We include here relevant snippets, for convenience and we interleave
 them with some exercises.
 *)

(*
   --- Inclusion:

   Variables (A : Type) (R S : relation A).
   Definition inclusion : Prop :=
     forall x y : A, R x y -> S x y.
*)

Implicit Arguments inclusion [A].
Notation "x << y" := (inclusion x y) (at level 50).

(* 
  ===== Exercise 1a (warm-up) =====
  
  Prove that if [R] is a subset of [S] then if we have an
  [R] step from [x] to [y] then there is also an [S] step
  from [x] to [y].
 *)

Section inclusion_elim.

  Variables (A : Type) (R S : relation A) (RS : R << S).

  Lemma inclusion_elim : forall x y, R x y -> S x y.
  Proof. 
  Admitted.

End inclusion_elim.

(*
   --- Reflexive, transitive closure:

  Inductive clos_refl_trans (x : A) : A -> Prop :=
    | rt_step (y:A) : R x y -> clos_refl_trans x y
    | rt_refl : clos_refl_trans x x
    | rt_trans (y z:A) :
          clos_refl_trans x y -> clos_refl_trans y z -> clos_refl_trans x z.
*)
Implicit Arguments clos_refl_trans [A].
Notation "x #" := (clos_refl_trans x) (at level 35).

(* 
  ===== Exercise 1b (warm-up) =====
  
  If [R] is a subet of [S] then reflexive-transitive 
  closure of [R] is a subet of a reflexive-transitive 
  closure of [S].
 *)
Section incl_rtc.

  Variable (A : Type) (R S : relation A) (RS : R << S).

  Lemma incl_rtc : R# << S#.
  Proof. 
  Admitted.

End incl_rtc.

(*
  --- Transitive closure

  Inductive clos_trans (x: A) : A -> Prop :=
    | t_step (y:A) : R x y -> clos_trans x y
    | t_trans (y z:A) : clos_trans x y -> clos_trans y z -> clos_trans x z.
*)
Implicit Arguments clos_trans [A].
Notation "x !" := (clos_trans x) (at level 35).

(* 
  ===== Exercise 1c (warm-up) =====
  
  A relation is a subet of its transitive closure.
 *)
Section tc_incl.

  Variables (A : Type) (R : relation A).

  Lemma tc_incl : R << R!.
  Proof. 
  Admitted.

End tc_incl.

(* 
  ===== Exercise 1d (warm-up) =====
  
  Transitive closure of [R] is a subset of a reflexive-transitive
  closure of [R].
 *)
Section tc_incl_rtc.

  Variables (A : Type) (R : relation A).

  Lemma tc_incl_rtc : R! << R#.
  Proof. 
  Admitted.

End tc_incl_rtc.

(*
  Finally we define a composition of two relations:
 *)
Definition compose A (R S : relation A) : relation A :=
  fun x y => exists z, R x z /\ S z y.

Notation "x @ y" := (compose x y) (at level 40).

(* 
  ===== Exercise 1e (warm-up) =====
 *)
Section tc_split.

  Variable (A : Type) (R : relation A).

  Lemma tc_split : R! << R @ R#.
  Proof. 
  Admitted.

End tc_split.

(* 
  ===== Exercise 2 =====
  
  Prove that a subset of a well-founded relation is well-founded.
 *)

Section WF_incl.
 
  Variable (A : Type) (R S : relation A).
 
  (* 
     Hint: you may want to first prove this property on a per-element
    basis, i.e. prove a similar lemma for the [SN] predicate.
   *)
  Lemma WF_incl : R << S -> WF S -> WF R.
  Proof.
  Admitted.

End WF_incl.

(* 
  ===== Exercise 3 =====
  
  SN and a reflexive-transitive closure.
 *)
Section SN_rtc.

  Variable (A : Type) (R : relation A).

  Lemma SN_rtc : 
    forall x, SN R x ->
      forall x', R# x x' -> SN R x'.
  Proof.
  Admitted.

End SN_rtc.

(* 
  ===== Exercise 4 =====
  
  Prove that a transitive closure of a well-founded relation is well-founded.
 *)

Section WF_tc.

  Variable (A : Type) (R : relation A).

  Lemma WF_tc : WF R -> WF (R!).
  Proof.
  Admitted.

End WF_tc.

(* 
  ===== Exercise 5 (hard) =====

    In this exercise you are asked to prove that if [R] composed with [S]
  is well-founded, then so is [S] composed with [R]. 
 
    Reasoning classicaly this is trivial: every infinite [R @ S] sequence
  is trivially transformed to an infinite [S @ R] sequence.

    However, to prove this lemma constructively you need to find a proper
  inductive argument, which turns out to be surprisingly difficult.
 *)

Section compose.

  Variable (A : Type) (R S : relation A).

   (* If you want a hint, scroll down to the end of this file... *)


  Lemma WF_compose_swap : WF (R @ S) -> WF (S @ R).
  Proof.
  Admitted.

End compose.














































(*
  Exercise 5 hint: 
    You may want to prove first that all single-step R-reducts are SN with
  respect to [S @ R].
    You may need to do induction on a _term_, not just a variable, 
  like [induction (F x)].
    And you will need to be careful in applying induction to obtain strong
  enough induction hypothesis (note: induction is applied on the _goal_
  itself, so be careful with moving terms between the goal and the context).
 *)

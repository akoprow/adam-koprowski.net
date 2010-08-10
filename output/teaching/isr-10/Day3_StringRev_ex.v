(*
 * ISR '10: International School on Rewriting.
 *
 * Day 3: Proving correctness of string reversal for termination
 *
 * This script is compatible with Coq 8.2pl1
 *)

Require Import List Relations Program.

Set Implicit Arguments.

(* 
  The SN definition below is taken from yesterday
 *)
Section SN.

  Variables (A : Type) (R : relation A).

  Inductive SN : A -> Prop :=
    SN_intro : forall x, (forall y, R x y -> SN y) -> SN x.

  Lemma SN_inv : forall x, SN x -> forall y, R x y -> SN y.
  Proof.
    destruct 1; trivial.
  Qed.

  Definition WF := forall x, SN x.

End SN.

(* 
  Let's define string rewriting
 *)
Section string_rewriting.

  (* We assume an arbitrary signature *)
  Variable Sig : Set.

  (* A string is a list of signature elements *)
  Definition string := list Sig.

  (* A rewrite rule is a pair of strings *)
  Record rule := mkRule { lhs : string; rhs : string }.

  (* An SRS is a list of rules *)
  Definition srs := list rule.

  (* A context is a pair of strings: left/right context *)
  Record context := mkContext { lft : string; rgt : string }.

  (* Putting a string in a context *)
  Definition fill (c : context) (s : string) := lft c ++ s ++ rgt c.

  (* Rewrite relation for a given SRS *)
  Definition red (R : srs) : relation string := 
    fun t u =>
      exists l r c,
        In (mkRule l r) R /\ t = fill c l /\ u = fill c r.

End string_rewriting.

(*
    Now, let's prove correctness of a simple transformation on SRSs
  that just flips all the rules, for instance:

  ab -> ba
  aab -> a

  is transformed to:
  
  ba -> ab
  baa -> a

  It is not difficult to see that it is a termination preserving
  transformation. Can we prove that?
 *)
Section string_reversal.

  Variable Sig : Set.
  Variable R : srs Sig.

  (* First replace this axiom with a proper definition(s) of
     what it means to reverse an SRS *)
  Axiom reverse_srs : srs Sig -> srs Sig.

  (* Then prove the following lemma, expressing that [reverse_srs]
     operation preserves well-foundedness. You will probably
     want to prove some auxiliary lemmas first *)
  Lemma reversal_WF : WF (red R) -> WF (red (reverse_srs R)).
  Proof.
  Admitted.


End string_reversal.

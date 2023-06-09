(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [matches_duplicate] *)
module MatchesDuplicate
open Primitives

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** The state type used in the state-error monad *)
assume type state : Type0

(** [matches_duplicate::id] *)
let id_fwd (t : Type0) (x : t) : result t = Return x

(** [matches_duplicate::E2] *)
type e2_t = | E2V1 : u32 -> e2_t | E2V2 : u32 -> e2_t | E2V3 : e2_t

(** [matches_duplicate::test2] *)
let test2_fwd (x : e2_t) : result u32 =
  begin match x with
  | E2V1 n -> Return n
  | E2V2 n -> Return n
  | E2V3 -> Return 0
  end

(** [matches_duplicate::test3] *)
let test3_fwd (x : e2_t) : result u32 =
  begin match x with
  | E2V1 n -> let* z = id_fwd u32 3 in u32_add n z
  | E2V2 n -> let* z = id_fwd u32 3 in u32_add n z
  | E2V3 -> let* z = id_fwd u32 3 in u32_add 0 z
  end


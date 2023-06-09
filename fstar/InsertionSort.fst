(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [insertion_sort] *)
module InsertionSort
open Primitives

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** The state type used in the state-error monad *)
assume type state : Type0

(** [insertion_sort::List] *)
type list_t (t : Type0) =
| ListCons : t -> list_t t -> list_t t
| ListNil : list_t t

(** [insertion_sort::tick] *)
let tick_fwd : result unit = Return ()

(** [insertion_sort::comp] *)
let comp_fwd (t : Type0) (x : t) (y : t) : result bool = Return false

(** [insertion_sort::insert] *)
let rec insert_fwd (t : Type0) (v : t) (l : list_t t) : result (list_t t) =
  let* _ = tick_fwd in
  begin match l with
  | ListCons hd tl ->
    let* b = comp_fwd t v hd in
    if b
    then let l0 = ListCons hd tl in Return (ListCons v l0)
    else begin
      let* l0 = insert_fwd t v tl in let l1 = l0 in Return (ListCons hd l1) end
  | ListNil -> let l0 = ListNil in Return (ListCons v l0)
  end

(** [insertion_sort::sort] *)
let rec sort_fwd (t : Type0) (l : list_t t) : result (list_t t) =
  let* _ = tick_fwd in
  begin match l with
  | ListCons hd tl -> let* l0 = sort_fwd t tl in insert_fwd t hd l0
  | ListNil -> Return ListNil
  end


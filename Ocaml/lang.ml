(*  Ocaml, not SML

Language basics:
comparisons and if tests
loops: for, while, sequence iteration.
math: modular, power, complex
strings: create, compare, modify, copy, substrings, splitting
functions: closures, function objects, funky parameters
arrays or lists: initialize, copy, resize, split
multiple dimensional arrays

More language:
maps
bits
array of maps, map of arrays, map of maps
priority queue
objects
assertion
library sort, search
applicative functions
handrolled sort
exceptions or errors
regular expressions
threads, locks
package or modules, build

Basic IO:
console io: read, write, error
file io: file existence, creation, reading, writing, deletion
get time (epoch and clock)
get random numbers
get date

More IO
directory functions
sockets and networking
database access
link against libraries

*)

open Printf;;

let basics () = (
  print_endline "Hello world 1";
  print_string "Hello ";
  print_string "world 2";
  print_newline();

  for i = 5 downto 1 do
      print_int i;
      print_newline();
  done;
  print_endline "Blastoff!";

  (* need rec for recursive functions *)
  let rec loop n = if n=0 then () else (
      Printf.printf "%d\n" n;  (* 'open Printf;;' for shorthand *)
      loop (n-1)
      )
  in loop 3;
  print_endline "Contact!";

  assert (3<4); (* ; separates expressions *)
  assert(3<=3);
  assert(3!=4);
  assert(3=3);
  assert(3.=3.); (* structural equality, negative is <> *)
  assert(3.!=3.); (* physical inequality, positive is == *)

  assert (4 = if true then 4 else 5);
  (* note types have to be consistent; if true then 4 [else ()] is
  invalid, since 4 and () don't have the same type *)
  assert (5 = if false then 4 else 5);
  let x = 4. in
  assert (-.x = -4.);  (* need -. to negate float, not - *)

  assert (5 = 2+3);
  assert (5. = 2.+.3.);
  assert (3/2 = 1);
  assert (3. /. 2. = 1.5);
  assert (5 mod 3 = 2);
  (* infix to prefix *)
  assert ((mod) 5 3 = 2);
  assert ((+) 5 3 = 8);
  (* power, float only *)
  assert (4. ** 2. = 16.); 
  assert (sin 0.0 = 0.); (* trig only takes float *)
  assert (sin (0.0) = 0.); (* sin -0.0 doesn't work, binds as (sin -0).0 *)
  assert ( abs(-2)=2 ); (* abs -2 doesn't work, ditto for sin -2.0 *)

(* logical operators *)
  assert (4 land 2 = 0);
  assert (4 lor 2 = 6);
  assert (4 lxor 4 = 0);
  assert (4 lxor 6 = 2);
  assert (7 lxor 1 = 6);
  assert (2 lsl 1 = 4);
  assert (4 lsr 1 = 2);

  (* chars *)
  let c = 'c' in
  assert (Char.uppercase_ascii c = 'C');

  (* string concat *)
  assert ("cat" ^ "dog" = "catdog");
  (* list concat. also note ; as separator, not comma *)
  assert ([1] @ [2] = [1;2]); 
  assert([1]=1::[]); (* cons *)
  assert (1::[2] = [1;2]);

  assert([1]=[1]); (* equal contents *)
  assert([1]<>[2]);
  assert([1]!=[1]); (* not the same array *)

  assert(List.length [1;3] = 2);

  (* basic matching *)
  let rec print_int_list l = (
    match l with
    | [] -> printf "\n"
    | hd::tl -> printf "%d " hd; print_int_list tl
  ) in 
  print_int_list [];
  print_int_list [1;2;3];

  (* 'normal' variables *)
  let counter = ref 0 in
  incr counter;
  assert ( !counter = 1);
  counter := 100;
  assert ( !counter = 100);

  (* tuples *)
  let tup = (3,"four") in
  assert ( fst tup = 3);
  assert ( snd tup = "four");  (* only work for 2-tuples, 'a * 'b *)
  let tup = (1,"two",[3]) in
  match tup with
  | (1, _, _) -> assert true;
  | _ -> assert true;
  match tup with
  | (_, "two", _) -> assert true;
  | _ -> assert true;
  match tup with
  | (_, _, [3]) -> assert true;
  | _ -> assert true;

  (); (* dummy so I can keep having semicolons *)
  )
  ;; (* end of block *)

type numWord = { n: int; w: string};;  (* type doesn't like being inside a let *)
type mut_nw_t = {mutable n: int; mutable w: string};;
type sign = Positive | Zero | Negative;;
type 'a option2 = None | Some of 'a;;
exception Exc1;;
exception Exc2 of string;;

let structs () = (
(*
  let t=(3,"three") in (* tuple syntax *)
  *)

  let nw = {n=3; w="three"} in
  assert (nw.w="three");
(*    let nw = {mutable n=3; mutable w="three"} in : doesn't work, need
type *)

  let nw = { n= 3; w="three"} in
  assert (nw.w="three");
  nw.n <- 4;
  nw.w <- "four";
  assert (nw.w="four");

  let makefive _nw =
      nw.n <- 5;
      nw.w <- "five" in
  makefive nw;
  assert (nw.w="five");

  () )
  ;;

let funcs () =
  let rec fib n =
      if n<2 then n else fib (n-1)+fib(n-2)
  in print_endline (string_of_int (fib 10));
  assert (fib 10 = 55);

  let rec fibm n = match n with
  | 0 -> 0
  | 1 -> 1
  | n -> fibm (n-1) + fibm (n-2) in
  assert (fibm 10 = 55);

  (* note this leaves off the parameter *)
  let rec fibf = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibf (n-1) + fibf (n-2) in
  assert (fibf 10 = 55);

  (* mutual recursion *)
  let rec 
    take = function
    | [] -> []
    | hd::tl -> hd :: skip tl
  and
    skip = function
    | [] -> []
    | hd::tl -> take tl
  in assert ( take [1;2;3] = [1;3] );
  ()
  ;;

(* pasted from tutorial *)
let rec sort lst =
  match lst with [] -> []
  | head :: tail -> insert head (sort tail)
and insert elt lst =
  match lst with
      [] -> [elt]
  | head :: tail -> if elt <= head then elt :: lst else head :: insert elt tail
  ;;

assert ( sort [3;2;1] = [1;2;3] );;
(* but not
assert ( sort [3;2;1] == [1;2;3] );;
*)

let sequences () = (
  let s="Hello" in
  assert (s.[0]='H');  (* string is like array of characters but with
  its own accessor syntax because ocaml. Non-mutable. *)
  assert (String.length s = 5);
  (* substring : string start len, not string start end *)
  assert (String.sub s 2 3 = "llo");
  (* string join *)
  let s_l = ["the";"quick";"brown"] in
  assert (String.concat " " s_l = "the quick brown");
  let s = " Hello \n" in
  assert (String.trim s = "Hello");
  let s = "hello" in
  assert (String.uppercase_ascii s = "HELLO");
  assert (String.capitalize_ascii s = "Hello");


  let a=[| 1;2;3 |] in (* array. note semicolons and thick brackets *)
  assert (Array.length a = 3);
  let b = Array.copy a in
  assert (b = a);
  assert (b != a); (* = and <>, == and != *)
  assert (a.(0)=1);
  assert (Array.get a 0 = 1); (* or this *)
  a.(0) <- 10; (* arrays mutable but not growable *)
  assert (a.(0)<>1);
  assert (a.(0)=10);
  Array.set a 0 12; (* or this *)
  assert (a.(0)=12);
  
  let a = Array.make 5 0 in
  assert (Array.length a = 5);
  assert (Array.get a 2 = 0);

  (* make will make multiple references to a mutable, kind of like
  Python.  Probably you should never do this. *)
  let a = Array.make 2 (ref 0) in
  assert (Array.length a = 2);
  assert (!(a.(1)) = 0);
  a.(0) := 3;
  assert (!(a.(1)) = 3);

  (* functional initialize *)
  let dbl i = 2 * i in
  let a = Array.init 5 dbl in
  assert (a.(0) = 0);
  assert (a.(1) = 2);
  assert (a.(4) = 8);
  try assert (a.(5) = 8); with 
  Invalid_argument s -> print_endline ("Ok caught expected exception: " ^ s);

  let id n i = n-i in
  let a = Array.init 10 (id 10) in
  let b = Array.copy a in
  Array.sort compare a;
  assert (a = [| 1;2;3;4;5;6;7;8;9;10 |]);
  assert (a <> b);
  Array.stable_sort compare b;
  assert (a=b);
  Array.iter print_int a;
  (* matrix notation *)
  let mat = Array.make_matrix 3 3 0 in
  assert (mat.(0).(0) = 0);
  for i = 0 to 2 do
      mat.(0).(i) <- 2 * i;
      (* not this, which failed silently 
      mat.(0).(i) = 2 * i; *)
  done;
  assert (mat.(0).(1) = 2);
  assert (mat.(0).(2) = 4);

  print_newline ();
  let l = [1;2;3] in
  List.iter print_int l;
  print_newline ();
  let a = [| 1;2;3 |] in
  Array.iter print_int a;
  print_newline ();
  ()
  );;

let io () = (
  let l = read_line() in (* doesn't include newline! *)
  print_endline l;
  let i = read_int() in
  printf "%d\n" i;
  let f = read_float() in
  printf "%g\n" f;

  (* input_char to get one char from a channel *)
  (* input_line *) (* input *)
  (* other functions in Pervasives, operating on channels *)

  (* there is a scanf of sorts.  it confuses me. *)

);;



let () = basics();;
let () = structs();;
let () = funcs();;
let () = sequences();;
ignore (io());;

()


(* 

let neg = fun f -> fun x -> not (f x);
let neg f x = not (f x);

*)

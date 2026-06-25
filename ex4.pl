/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).

% Signature: sub_list(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order.
% Precondition: List is fully instantiated (queries do not include variables in their second argument).

sub_list([], _).

sub_list([X | SubTail], [X | ListTail]) :-
    sub_list(SubTail, ListTail).

sub_list(Sublist, [_ | ListTail]) :-
    sub_list(Sublist, ListTail).





% Signature: swap_list(List, InversedList)/2
% Purpose: InversedList is the ‘mirror’ representation of List, i.e, each item in the list is recursively replaced with the item at the position, with refers to the beginning and the end of the list.   

swap_list([], []).

swap_list([Head | Tail], InversedList) :-
    swap_list(Tail, InversedTail),
    swap_item(Head, InversedHead),
    my_append(InversedTail, [InversedHead], InversedList).

% Signature: sub_tree(Subtree, Tree)/2
% Purpose: Tree contains Subtree.

sub_tree(Subtree, tree(_, Left, _)) :-
    sub_tree(Subtree, Left).

sub_tree(Subtree, tree(_, _, Right)) :-
    sub_tree(Subtree, Right).

sub_tree(Tree, Tree).

% Signature: swap_tree(Tree, InversedTree)/2
% Purpose: InversedTree is the �mirror� representation of Tree.

swap_tree(void, void).

swap_tree(tree(Value, Left, Right),
          tree(Value, InversedRight, InversedLeft)) :-
    swap_tree(Left, InversedLeft),
    swap_tree(Right, InversedRight).



% Helpers

% Signature: my_append(List1, List2, Result)/3
% Purpose: Result is the concatenation of List1 and List2.

my_append([], List, List).

my_append([Head | Tail], List, [Head | ResultTail]) :-
    my_append(Tail, List, ResultTail).



% Signature: swap_item(Item, InversedItem)/2
% Purpose: If Item is a list, recursively mirror it.
%          Otherwise, leave it unchanged.

swap_item([], []) :-
    !.

swap_item([Head | Tail], InversedItem) :-
    !,
    swap_list([Head | Tail], InversedItem).

swap_item(Item, Item).

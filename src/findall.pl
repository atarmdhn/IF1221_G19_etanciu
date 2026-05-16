:- dynamic(tempResult/1).

myFindall(Template, Goal, List) :-
    call(Goal),
    assertz(tempResult(Template)),
    fail ;
    collectResults(List).

collectResults([H|T]) :-
    retract(tempResult(H)), !,
    collectResults(T).

collectResults([]).
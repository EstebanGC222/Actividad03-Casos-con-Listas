% Hechos: listas de hombres y mujeres
hombres([abraham, clancy, herbert, homero, bart]).
mujeres([mona, jacqueline, marge, patty, selma, lisa, maggie, ling]).

% Hechos: hijos(Progenitor, ListaDeHijos)
% Progenitor es una estructura: padre(Nombre) o madre(Nombre)
hijos(padre(abraham), [herbert, homero]).
hijos(padre(clancy), [marge, patty, selma]).
hijos(padre(homero), [bart, lisa, maggie]).
hijos(madre(mona), [homero]).
hijos(madre(jacqueline), [marge, patty, selma]).
hijos(madre(marge), [bart, lisa, maggie]).
hijos(madre(selma), [ling]).

% Pertenencia a una lista (cabeza y cola)
pertenece(X, [X|_]).
pertenece(X, [_|Cola]) :- pertenece(X, Cola).

% Reglas
hombre(X) :- hombres(L), pertenece(X, L).
mujer(X) :- mujeres(L), pertenece(X, L).

padre(X, Y) :- hijos(padre(X), L), pertenece(Y, L).
madre(X, Y) :- hijos(madre(X), L), pertenece(Y, L).

progenitor(X, Y) :- padre(X, Y).
progenitor(X, Y) :- madre(X, Y).

% Hermanos: están en la misma lista de hijos
hermanos(X, Y) :- hijos(padre(_), L), pertenece(X, L), pertenece(Y, L), X \= Y.
hermanos(X, Y) :- hijos(madre(_), L), pertenece(X, L), pertenece(Y, L), X \= Y,
                  \+ (padre(P, X), padre(P, Y)).

abuelo(X, Y) :- padre(X, Z), progenitor(Z, Y).
abuela(X, Y) :- madre(X, Z), progenitor(Z, Y).

nieto(X, Y) :- hombre(X), (abuelo(Y, X) ; abuela(Y, X)).
nieta(X, Y) :- mujer(X), (abuelo(Y, X) ; abuela(Y, X)).

tio(X, Y) :- hombre(X), progenitor(Z, Y), hermanos(X, Z).
tia(X, Y) :- mujer(X), progenitor(Z, Y), hermanos(X, Z).

primos(X, Y) :- progenitor(A, X), progenitor(B, Y), hermanos(A, B).

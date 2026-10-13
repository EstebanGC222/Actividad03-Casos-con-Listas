% Hechos: ciudad(Nombre, ListaDeAristas)
% Cada arista es una estructura: arista(Destino, Costo)  -- grafo dirigido
ciudad(vancouver, [arista(edmonton, 16), arista(calgary, 13)]).
ciudad(edmonton, [arista(saskatoon, 12)]).
ciudad(calgary, [arista(edmonton, 4), arista(regina, 14)]).
ciudad(saskatoon, [arista(calgary, 9), arista(winnipeg, 20)]).
ciudad(regina, [arista(saskatoon, 7), arista(winnipeg, 4)]).
ciudad(winnipeg, []).

% Pertenencia a una lista (cabeza y cola)
pertenece(X, [X|_]).
pertenece(X, [_|Cola]) :- pertenece(X, Cola).

% Arista de X a Y con costo C: está en la lista de aristas de X
arista(X, Y, C) :- ciudad(X, L), pertenece(arista(Y, C), L).

% Conexión directa entre dos nodos, en cualquier sentido
conexion(X, Y, C) :- arista(X, Y, C).
conexion(X, Y, C) :- arista(Y, X, C).

% Un nodo tiene aristas si su lista no está vacía o si le llega alguna
tiene_aristas(X) :- ciudad(X, [_|_]), !.
tiene_aristas(X) :- arista(_, X, _), !.

% Costo de ir de X a Z pasando por Y
costo(X, Y, Z, C) :-
    arista(X, Y, C1),
    arista(Y, Z, C2),
    C is C1 + C2.

% ¿Es posible viajar de X a Y? La lista Visitados evita repetir nodos
viajar(X, Y, Ruta, Costo) :- viajar(X, Y, [X], R, Costo), reverse(R, Ruta).
viajar(X, X, Visitados, Visitados, 0).
viajar(X, Y, Visitados, Ruta, Costo) :-
    arista(X, Z, C),
    \+ pertenece(Z, Visitados),
    viajar(Z, Y, [Z|Visitados], Ruta, C2),
    Costo is C + C2.

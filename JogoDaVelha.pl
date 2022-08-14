% - JOGO DA VELHA -
%
% Projeto da cadeira de Lógica Aplicada a Computação
% feito pelos alunos Cândido Leandro de Queiroga Bisneto,
% (clqb@academico.ufpb.br), matricula: 20200096303 e José Matheus
% Marques Vinagre, (jose.vinagre@academico.ufpb.br), matricula:
% 20200010004
%
% Código progamado entre os dias 29/05 e 05/06.
%
% Universidade Federal da Paraíba, UFPB.
% Centro de Informática - CI.


vitoria(Tabuleiro, Jogador) :-
	          linha_vitoria(Tabuleiro, Jogador);
                  coluna_vitoria(Tabuleiro, Jogador);
                  diagonal_vitoria(Tabuleiro, Jogador).
%linha
linha_vitoria(Tabuleiro, Jogador) :-
		   Tabuleiro = [Jogador,Jogador,Jogador,_,_,_,_,_,_];
                   Tabuleiro = [_,_,_,Jogador,Jogador,Jogador,_,_,_];
		   Tabuleiro = [_,_,_,_,_,_,Jogador,Jogador,Jogador].

%coluna
coluna_vitoria(Tabuleiro, Jogador) :-
	           Tabuleiro = [Jogador,_,_,Jogador,_,_,Jogador,_,_];
                   Tabuleiro = [_,Jogador,_,_,Jogador,_,_,Jogador,_];
		   Tabuleiro = [_,_,Jogador,_,_,Jogador,_,_,Jogador].
%diagonal
diagonal_vitoria(Tabuleiro, Jogador) :-
	           Tabuleiro = [Jogador,_,_,_,Jogador,_,_,_,Jogador];
		   Tabuleiro = [_,_,Jogador,_,Jogador,_,Jogador,_,_].

omove([a,B,C,D,E,F,G,H,I], Jogador, [Jogador,B,C,D,E,F,G,H,I]).
omove([A,a,C,D,E,F,G,H,I], Jogador, [A,Jogador,C,D,E,F,G,H,I]).
omove([A,B,a,D,E,F,G,H,I], Jogador, [A,B,Jogador,D,E,F,G,H,I]).
omove([A,B,C,a,E,F,G,H,I], Jogador, [A,B,C,Jogador,E,F,G,H,I]).
omove([A,B,C,D,a,F,G,H,I], Jogador, [A,B,C,D,Jogador,F,G,H,I]).
omove([A,B,C,D,E,a,G,H,I], Jogador, [A,B,C,D,E,Jogador,G,H,I]).
omove([A,B,C,D,E,F,a,H,I], Jogador, [A,B,C,D,E,F,Jogador,H,I]).
omove([A,B,C,D,E,F,G,a,I], Jogador, [A,B,C,D,E,F,G,Jogador,I]).
omove([A,B,C,D,E,F,G,H,a], Jogador, [A,B,C,D,E,F,G,H,Jogador]).

xmove([a,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xmove([A,a,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xmove([A,B,a,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xmove([A,B,C,a,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xmove([A,B,C,D,a,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xmove([A,B,C,D,E,a,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xmove([A,B,C,D,E,F,a,H,I], 7, [A,B,C,D,E,F,x,H,I]).
xmove([A,B,C,D,E,F,G,a,I], 8, [A,B,C,D,E,F,G,x,I]).
xmove([A,B,C,D,E,F,G,H,a], 9, [A,B,C,D,E,F,G,H,x]).
xmove(Tabuleiro, _, Tabuleiro) :-
	write('movimento ilegal!'), nl.


disp([A,B,C,D,E,F,G,H,I]) :-
	write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,	write('|'),
        write([G,H,I]),write('|'),nl,nl.


go :- jogada, strt([a,a,a,a,a,a,a,a,a]).

jogada :-
  write('você é o jogador X.'),
  nl,
  disp([1,2,3,4,5,6,7,8,9]).

strt(Tabuleiro) :-
	vitoria(Tabuleiro, x), write('FIM DE JOGO!').
strt(Tabuleiro) :-
	vitoria(Tabuleiro, o), write('FIM DE JOGO!').
strt(Tabuleiro) :- read(N),
  xmove(Tabuleiro, N, NovoTabuleiro),
  disp(NovoTabuleiro),
  vez(NovoTabuleiro, NovoNovoTabuleiro),
  disp(NovoNovoTabuleiro),
  strt(NovoNovoTabuleiro).


x_vitoria(Tabuleiro) :- omove(Tabuleiro, x, NovoTabuleiro),
	                vitoria(NovoTabuleiro, x).

vez(Tabuleiro,NovoTabuleiro) :-
  omove(Tabuleiro, o, NovoTabuleiro),
  vitoria(NovoTabuleiro, o),!.
vez(Tabuleiro,NovoTabuleiro) :-
  omove(Tabuleiro, o, NovoTabuleiro),
  not(x_vitoria(NovoTabuleiro)).
vez(Tabuleiro,NovoTabuleiro) :-
  omove(Tabuleiro, o, NovoTabuleiro).
vez(Tabuleiro, NovoTabuleiro) :-
  not(member(a,Tabuleiro)),!,
  disp(NovoTabuleiro).



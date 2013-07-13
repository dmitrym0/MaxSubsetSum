-module(maxsubsetsum_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, simplePermute/2, generateAllCombos/1, findSums/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	maxsubsetsum_sup:start_link().

stop(_State) ->
	ok.

% credit: http://stackoverflow.com/questions/1459152/erlang-listsindex-of-function
index_of(Item, List) -> index_of(Item, List, 1).
index_of(_, [], _)  -> not_found;
index_of(Item, [Item|_], Index) -> Index;
index_of(Item, [_|Tl], Index) -> index_of(Item, Tl, Index+1).

% find sums
findSums(L) ->
	Permutations=generateAllCombos(L),
	lists:filter(fun(LL) -> case index_of(lists:sum(LL), L) of
					not_found -> false;
					_ -> true
				end
		end, Permutations).


% generate all combinations of size 2..legnth(L)-1
generateAllCombos(L) ->
	NewL=L--[lists:last(L)],
	Sizes=lists:seq(2,length(NewL)),
	lists:flatmap(fun(X) -> simplePermute(NewL,X) end, Sizes).

% generate a list of permutations of size R from list L
simplePermute(_,R) when R == 0 ->
	[[]];

simplePermute(L,R) ->
	[[X|T] || X <- L, T<-simplePermute(lists:nthtail(index_of(X,L),L),R-1)].

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

-ifdef(TEST).

simple_test() ->
	ok = application:start(maxsubsetsum),
	?assertNot(undefined == whereis(maxsubsetsum_sup)).

%test_combinations_with_empty_array() ->
%	?assert([] == combinationsOfSizeN([], nil,nil,nil).

test_simple_combination() ->
	?assert([] == combinationsOfSizeN([1,2,3],[],2,0).

-endif.

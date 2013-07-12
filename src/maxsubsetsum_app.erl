-module(maxsubsetsum_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, simpleCombo/2]).

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


% generate a list of permutations of size R from list L
simpleCombo(_,R) when R == 0 ->
	io:format("*2~n"),
	[[]];

simpleCombo(L,R) ->
	[[X|T] || X <- L, T<-simpleCombo(lists:nthtail(index_of(X,L),L),R-1)].

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

-module(maxsubsetsum_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, simpleCombo/3]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	maxsubsetsum_sup:start_link().

stop(_State) ->
	ok.


% perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].
% perms([]) -> [[]];
% 
% L in list
% Result temporary result
% r - size of the combo
simpleCombo(_, Result, R) when length(Result) == R ->
	io:format("##", []), erlang:display(lists:reverse(Result)), io:format("~n"),
	lists:reverse(Result);

simpleCombo(L, Result, R) when length(L) < R ->
	io:format("2*~n", []),
	lists:reverse(Result);

simpleCombo(L, Result, R) ->
	io:format("1*", []), erlang:display(L), io:format("##"), erlang:display(lists:reverse(Result)), io:format("~n"),
	[_|T] = L,
	[[simpleCombo(T,[X|Result],R) || X <- L]].

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

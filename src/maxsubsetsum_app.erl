-module(maxsubsetsum_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, combinationsOfSizeN/5]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	maxsubsetsum_sup:start_link().

stop(_State) ->
	ok.

%combinationsOfSizeN([], _, _, _) ->
%	[].

%generateNextSet(SourceArray, ResultsArray, TemporaryHoldingArray, RequiredCombinationSize, IndexIntoSourceArray) ->
%	NewTemporaryHoldingArray=[array:get(IndexIntoSourceArray, SourceArray)|ResultsArray],
%	combinationsOfSizeN(SourceArray, ResultsArray, NewTemporaryHoldingArray, RequiredCombinationSize, IndexIntoSourceArray).

%combinationsOfSizeN(SourceArray, ResultsArray, TemporaryHoldingArray, RequiredCombinationSize, IndexIntoSourceArray) ->
%	case size(TemporaryHoldingArray) == RequiredCombinationSize of
%		true  -> TemporaryHoldingArray;
%		false -> R = generateNextSet(SourceArray, ResultsArray, TemporaryHoldingArray, RequiredCombinationSize, IndexIntoSourceArray + 1),
%			 [R|ResultsArray]
%			
%	end.


genPerms(SourceArray,_, TemporaryHoldingArray, _, IndexIntoSourceArray)  when length(SourceArray) == IndexIntoSourceArray ->
	TemporaryHoldingArray;
genPerms(SourceArray, Results, TemporaryHoldingArray, RequiredCombinationSize, IndexIntoSourceArray) ->
	combinationsOfSizeN(SourceArray, Results,TemporaryHoldingArray, RequiredCombinationSize, IndexIntoSourceArray+1).

combinationsOfSizeN(SourceArray, Results,  TemporaryHoldingArray, RequiredCombinationSize, IndexIntoSourceArray) ->
	io:format("- ~w ~n", [IndexIntoSourceArray]),
	case length(TemporaryHoldingArray) == RequiredCombinationSize of
		true  -> TemporaryHoldingArray;
		false -> NewTemporaryHoldingArray=[lists:nth(IndexIntoSourceArray, SourceArray)|TemporaryHoldingArray],
			genPerms(SourceArray, Results, NewTemporaryHoldingArray, RequiredCombinationSize, IndexIntoSourceArray)
	end.

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

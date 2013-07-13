# MaxSubSet 

This is a solution for the following problem:

>You must find number of subsets of an array where the largest number is the sum of the remaining numbers. For example, for an input of:
>1, 2, 3, 4, 6
>the subsets would be
>1 + 2 = 3
>1 + 3 = 4
>2 + 4 = 6
>1 + 2 + 3 = 6

The solution is written in Erlang. It's a brute force solution and likely can be highly optimized.

Note that at this time I don't yet know how to make this work nicely from command line, so to make this work:

1. cd src
1. erl # runs erlang interactive shell
1. c(maxsubsetsum_app.erl). # compile
1. maxsubsetsum_app:findSums([1,2,3,4,6]). # run the solution

The output will be the list of subsets that satisfy the problem statement.

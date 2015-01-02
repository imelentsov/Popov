#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Generals problem.
Usage:
    -g - specify that need to generate new generals (n, m) problem into file
    -f, --file - specify file for reading of general problem 
"""

'''
Created on 2014-12-29 13:34
@summary: 
@author: i.melentsov
'''
import getopt, sys
import random, json
from texttable import Texttable

Default = 0

def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "f:hg:", ["help", "file="])
    except getopt.GetoptError as err:
        # print help information and exit:
        print (str(err))
        print(__doc__)
        sys.exit(2)
    mayContinue = True
    encFile = None
    need_to_generate = False
    n, m = 0, 0
    for o, a in opts:
        if o in ("-h", "--help"):
            print(__doc__)
            sys.exit()
        elif o in ("-f", "--file"):
            encFile = a
        elif o == "-g":
            n, m = (int(i) for i in a.split())
            need_to_generate = True
            if n < 1:
                print("Illegal num of generals.")
                mayContinue = False
            elif m < -1:
                print("Num of traitors should be greater or equal then 0.")
                mayContinue = False
            elif n < 3 * m + 1:
                print("No solution available.")
                mayContinue = False
        else:
            assert False, "Unhandled option"
    if encFile is None:
        print ("File not specified.")
        mayContinue = False
    if not mayContinue:
        print ("Exit.")
        sys.exit(2)
    if need_to_generate:
        with open(encFile, "w") as f:
            json.dump(generate(n, m), f)
        sys.exit()
    
    rounds = None
    with open(encFile, "r") as f:
        rounds = json.load(f)
    table = Texttable()
    table.set_cols_align(["c"] * (len(rounds[0][0]) + 1))
    for round, round_res in enumerate(parse_rounds_res(rounds)):
        print("Round ", round)
        table.reset()
        table.add_rows(round_res)
        print(table.draw())
        


def parse_rounds_res(rounds):
    n = len(rounds[0][0])
    rounds_results = []
    for round in rounds:
        result = [["Generals/\nGenerals"] + [i for i in range(1, n + 1)]]
        for general, vectors in enumerate(round):
            result.append([str(general + 1)] + vectors[0])
        rounds_results.append(result)
    return rounds_results


def generate(n, m):
    '''
    @param n: num of loyal genarals
    @param m: num of traitors
    @result: array of rounds(num of rounds is m), each round is array of self view and vectors loyal genarals received
    '''
    # generate self view
    true_part = generate_vec(n - m) # generate true part
    initial_vectors = [true_part + generate_vec(m) for i in range(n - m)] # generate lies
    rounds = []
    last_round = None
    for _ in range(m):
        last_round = generate_round(initial_vectors, n, m)
        rounds.append(last_round)
        initial_vectors = compute_round_res(last_round, n)
    rounds.append([[x] for x in initial_vectors])
    return rounds

def generate_round(initial_vectors, n, m):
    round = [[x] for x in initial_vectors] # generate lies
    # tell others
    for i in range(n - m):
        for j in range(i):
            round[j].append(round[i][0])
        for j in range(i + 1, n - m):
            round[j].append(round[i][0])
    for i in range(n - m, n):
        for j in range(n - m):
            round[j].append(generate_vec(n))
    return round

def compute_round_res(round, n):
    half_n = n >> 1
    is_half_possible = n & 1
    result = []
    res = None
    for i, vectors in enumerate(round):
        generals_decision = []
        for index, general in enumerate(zip(*vectors)):
            if index == i:
                res = n if general[0] else 0
                # print("i - ", i, " - ", general)
            else:
                res = sum(general)
                res -= general[index + (1 if index < i else 0)]
            if is_half_possible and half_n == res:
                generals_decision.append(Default)
            elif res > half_n:
                generals_decision.append(1)
            else:
                generals_decision.append(0)
        result.append(generals_decision)
    return result

def generate_vec(n):
    return [random.randint(0, 1) for i in range(n)]

if __name__ == '__main__':
    main()
//
//  Eternity II Solver Core Logic 
//
//  Copyright © 2009-2019 Yohan Firmy
//

#ifndef E2Solver_h
#define E2Solver_h

#include <iostream>
#include "E2Init.h"
#include "E2Job.h"
#include "E2Trace.h"

class E2Solver {

private:
    Position** lastPosition;
    int solutionCount;

public:
    E2Solver();
    int solve(std::string job);
    int getSolutionCount();
    
private:
    bool Explore(Position** pposition);
    void claimNewScore(int* lvl, int* highlvl);
    void printCurrentSolution();
    void cleanUp();
};

#endif // E2Solver_h

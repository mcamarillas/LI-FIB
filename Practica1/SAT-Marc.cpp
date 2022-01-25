#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>

using namespace std;

/*
  1. Do a list(occursList) to store the clauses where each variable appears.
  2. Change the heuristic:
      --> Choose the variable that cause more conflicts (Do a conflictList)
      --> Every 'x' time divide by 2 all the conflicts.
      --> (OPCIONAL) Order increasingly the conflictList. (NOT DONE)
  3. Upate the function propagateGivesConflict() to improve it.
*/
#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;

// Matrix that indicate the clauses where the literal appears
vector<vector<int>> positiveOccursList;
vector<vector<int>> negativeOccursList;

// Matrix that indicate the time of conflicts from each literal
vector<int> conflictList;

const int UPDATE_TIME = 1500;
const int DIVIDE_FACTOR = 2;

uint conflicts = 0;

void readClauses( ){
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;
  clauses.resize(numClauses);
  positiveOccursList.resize(numVars + 1);
  negativeOccursList.resize(numVars + 1);
  conflictList.resize(numVars + 1, 0.0);
  // Read clauses & occursList and create the conflictList
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0) {
      conflictList[abs(lit)]++;
      clauses[i].push_back(lit);
      if(lit > 0) positiveOccursList[lit].push_back(i);
      else if(lit < 0) negativeOccursList[-lit].push_back(i);
    }
  }
}

void updateConflictList(int index) {
    // Divide by DIVIDE_FACTOR all the elements in the conflict list every UPDATE_TIME
    if(conflicts == UPDATE_TIME) {
        conflicts = 0;
        for(uint i = 1; i < numVars+1; ++i) {
          conflictList[i] /= DIVIDE_FACTOR;
        }
    }
    int n = clauses[index].size();
    // Increment in 1 the conflict of all the variables in the clause
    for(int i = 0; i < n; ++i){  
      int currentVarieable = clauses[index][i];
      if(currentVarieable < 0) currentVarieable = -currentVarieable;
      conflictList[currentVarieable]++;
    }
}

int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}

void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;
}

bool propagateGivesConflict() {
  while (indexOfNextLitToPropagate < modelStack.size()) {
    int currentValue = modelStack[indexOfNextLitToPropagate];
    vector<int> aux;

    if(currentValue <= 0) aux = positiveOccursList[-currentValue];
    else aux = negativeOccursList[currentValue];

    ++indexOfNextLitToPropagate;
    // Prove if there's no conflict in the clauses where -currentValue appears
    for (uint i = 0; i < aux.size(); ++i) {
      bool someLitTrue = false;
      int numUndefs = 0;
      int lastLitUndef = 0;
      int currentIndex = aux[i];

      for (uint k = 0; not someLitTrue and k < clauses[currentIndex].size(); ++k){
        int val = currentValueInModel(clauses[currentIndex][k]);

        if (val == TRUE) someLitTrue = true;
        else if (val == UNDEF){ 
          ++numUndefs; 
          lastLitUndef = clauses[currentIndex][k]; 
        }
      }
      if (not someLitTrue and numUndefs == 0) {
          conflicts++;
          updateConflictList(currentIndex);
          return true; // conflict, all lits false
      }
      else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);
    }
  }
  return false;
}

void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;

  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision
}

// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){
  int maxConflicts = 0;
  int indexMaxConflicts = 0;

  for (uint i = 1; i < numVars; ++i) {
    if (model[i] == UNDEF)  {
      if(conflictList[i] > maxConflicts) {
        maxConflicts = conflictList[i];
        indexMaxConflicts = i;
      }
    }  
  }
  return indexMaxConflicts; // returns the index of the variable with more conflicts
}

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}

int main(){

  readClauses(); // reads numVars, numClauses and clauses
  
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;
  decisionLevel = 0;

  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {
        cout << "UNSATISFIABLE" << endl; 
        return 10;
      }
      else if (val == UNDEF) setLiteralToTrue(lit);
    }

  // DPLL algorithm
  while (true) {
    while (propagateGivesConflict()) {
      if (decisionLevel == 0) { 
        cout << "UNSATISFIABLE" << endl; 
        return 10; 
      }
      backtrack();
    }
    int decisionLit = getNextDecisionLiteral();
    
    if (decisionLit == 0) { 
      checkmodel(); 
      cout << "SATISFIABLE" << endl; 
      return 20; 
    }
    // start new decision level:
    modelStack.push_back(0);  // push mark indicating new DL
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
  }
}

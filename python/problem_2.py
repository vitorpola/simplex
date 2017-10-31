from pulp import *

# declare your variables
x1 = LpVariable("x1", 0, 3)
x2 = LpVariable("x2", 0, 4)

# defines the problem
prob = LpProblem("problem", LpMaximize)

# defines the constraints
prob += 1*x1 + 2*x2 <= 9 

# defines the objective function to maximize
prob += 5*x1 + 2*x2 
# solve the problem
status = prob.solve(GLPK(msg=0))
LpStatus[status]

# print the results x1 = 20, x2 = 60
print prob
print 'Solucao'
print 'x1=', value(x1)
print 'x2=', value(x2)
print 'Z=', 5*value(x1) + 2*value(x2) 
from pulp import *

# declare your variables
x1 = LpVariable("x1", 0)   # 0<= x1 <= 40
x2 = LpVariable("x2", 0)   # 0<= x1 <= 40
x3 = LpVariable("x3", 0)   # 0<= x1 <= 40
x4 = LpVariable("x4", 0)   # 0<= x1 <= 40
x5 = LpVariable("x5", 0)   # 0<= x1 <= 40
x6 = LpVariable("x6", 0)   # 0<= x1 <= 40

# defines the problem
prob = LpProblem("problem", LpMinimize)

# defines the constraints
prob += 0.6*x1 + 0.7*x2 + x3 >= .6 
prob += 0.6*x1 + 0.7*x2 + x3 <= .65 
prob += 0.2*x1 + 0.2*x2 + x4 >= .15 
prob += 0.2*x1 + 0.2*x2 + x4 <= .2 
prob += 0.2*x1 + 0.05*x2 + x5 >= .15 
prob += 0.2*x1 + 0.05*x2 + x5 <= .2 
prob += 0.05*x2 + x6 >= .05 
prob += 0.05*x2 + x6 <= .08

# defines the objective function to maximize
prob += .2*x1 + .25*x2 + .3*x3 + .2*x4 + .28*x5 + .5*x6

# solve the problem
status = prob.solve(GLPK(msg=0))
LpStatus[status]

# print the results
print prob
print 'Solucao'
print 'x1=', value(x1)
print 'x2=', value(x2)
print 'x3=', value(x3)
print 'x4=', value(x4)
print 'x5=', value(x5)
print 'x6=', value(x6)
print 'Z=', .2*value(x1) + .25*value(x2) + .3*value(x3) + .2*value(x4) + .28*value(x5) + .5*value(x6)
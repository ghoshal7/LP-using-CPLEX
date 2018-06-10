### Model file for Lot-Sizing with Constant Capacity (LSC) problem

# Definiing the production period parameter
param n;			# n is the production period

## Setting the time indices
set time:= {1..n};		# set of idices

## Define all other parameters of cost, demand and capacity

param p {time} >= 0;	# p is per unit production cost which should be >=0 for all periods
param h {time} >= 0;	# h is per unit holding cost which should be >=0 for all periods
param d {time} >= 0;	# d is demand in any period which should be >=0 for all periods
param C {time} >= 0;	# production capacity in any period which should be >=0 for all periods

## Declaraing the variables 
var x {t in time} >= 0;  # x units are producted at time t which should be >= 0 and less then capacity at time t (constant in this problem)
var s {t in 0..n} >= 0; # Remaining Inventory at time period t after satisfying the demand. It should always be positive so that backorders are not carried in next period.

## Defining objective function. This is sum of production cost and inventory storing cost for all period.
minimize cost : sum {t in time} (p[t] * x[t] + h[t] * s[t]); 

# Defining constraint 1, production at time t is <= capacity in that period
s.t. prod {t in time} : x[t] <= C [t];
# Defining constraint 2, at t=0, inventory = 0
s.t. initial_inventory : s [0] = 0;

# Defining constraint 3, inventory at time t = carry over inventory from previous period + production in current period - demand of current period
s.t. flow_constraint {t in time} : s[t] = s[t-1] + x[t] - d[t];




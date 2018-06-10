### Model file for Lot-Sizing with Capacity modules (LSCM) problem

# Defining the production period parameter
param n;			# n is the production period

## Setting the time indices
set time:= {1..n};		# set of indices

## Define all other parameters of cost, demand, capacity and module installation cost
param p {time} >= 0;	# p is per unit production cost (>=0 for any periods)
param h {time} >= 0;	# h is per unit holding cost (>=0 for any periods)
param d {time} >= 0;	# d is demand in any period (>=0 for any periods)
param C {time} >= 0;	# production capacity in any period (>=0 for any periods)
param f {time} >= 0; 	# module installation cost (given as 5000)

## Declaraing the variables 
var y {t in 1..n} integer>= 0; # no. of modules installed at each time period (this should be an integer value)
var x {t in time} >= 0; # x units are producted at time t which should be >= 0 and less then capacity at time t
var s {t in 0..n} >= 0; # Remaining Inventory at time period t after satisfying the demand.

## Defining objective function. This is sum of production cost, inventory storing cost and module installation cost for all period.
minimize cost : sum {t in time} (f[t] * y[t] + p[t] * x[t] + h[t] * s[t]); 

# Defining constraint 1 on production units. this should be lesser than or equal to number of modules*capacity of each module
s.t. production_constraint {t in time} : x[t] <= y[t]*C[t];

# Defining constraint 2, at t=0, inventory = 0
s.t. initial_inventory : s [0] = 0;

# Defining constraint 3, inventory at time t = carry over inventory from previous period + production in current period - demand of current period
s.t. flow_constraint {t in time} : s[t] = s [t-1] + x[t] - d[t];



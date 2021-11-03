# Zero to Aiyagari (dev)

---

## Introduction

- Goals? 

---

## Consumption-Savings Model


----

### Consumption Savings

- Setup
    - $e_t$ is an i.i.d. process
    - $w$ and $r$ are two exogenous scalars
    - Utility function $U(c) = \frac{c^ {1-\gamma}}{1-\gamma}$ with $\gamma>1$
    - Discount factor $\beta\in [0,1[$

- Transition equation: $$a_t = w e_t + r a_{t-1} - c_t$$

- Objective: $$\max_{0 \leq c_t \leq w e_t + r a_{t-1}} \sum \beta^t U(c_t)$$

---

### Assumptions 

Some assumptions:
- $u$ continuously differentiable, strictly increasing, strictly concave and bounded.
- $u$ satisfies the Inada conditions: $\lim_{c \rightarrow 0} u'(c) = \infty$ and $\lim_{c \rightarrow +\infty} u'(c) = 0$.

---

### First-order conditions

Combining the first-order conditions and the envelope theorem yields the following Euler equation:

$$ \beta r u'(c_{t+1}) = u'(c_t) $$

Since $u(c) = \frac{c^{1-\gamma}}{1-\gamma}$, this rewrites: $\beta r \left(\frac{c_{t+1}}{c_t}\right)^{-\gamma} = 1$.

Yet, the FOCs are not sufficient for a solution to the maximisation problem to exist.

Besides, knowing $a_0$ (initial condition) is not enough to fully characterise a solution.

A transversality condition is added: $\lim_{t\rightarrow +\infty} \beta^t u'(c_t) r a_t = 0$.

---

### Recursive formulation

The sequential problem can be rewritten recursively:

$$ v(a_{t-1}, e_t) = \max_{0 \leq c_t \leq w e_t + ra_{t-1}} U(c_t) + \beta v(a_t, e_{t+1}) $$

where $c_t,~a_t$ are control variables and $e_t, a_{t-1}$ state ones.

This recursive formulation exploits the stationarity of the problem: the decisions depend upon the past level of capital and the exogenous shock but not on the time period itself.

---
### Principle of optimality

The principle of optimality ensures that the optimal policy function of the recursive problem coincides with the optimal sequence of decisions of the sequential problem.

TO CONTINUE

---
### Functional equation


---
### Existence and uniqueness of a fixed point

---
###


---
## Simulations

---

## Aggregate Equilibrium


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

- Objective: $$\max_{0 \leq c_t \leq w e_t + r a_{t-1}} \mathbb{E}_0 \sum \beta^t U(c_t)$$

---

### Consumption Savings (2)

- $Z$ is the set of all possible values for the exogenous shock $e_t$
- $(Z, \mathcal{Z})$ is the associated measurable space
- $X$ is the set of all possible values for the endogenous state variable $a_{t-1}$
- $(X, \mathcal{X})$ is the associated measurable space
- $(S, \mathcal{S}) = (X\times Z,\mathcal{X}\times\mathcal{Z})$ is the product space
- The stochastic shocks $\{e_t\}$ evolution can be described by a stationary transition function $Q$ on $(Z, \mathcal{Z})$
- In period $t$, the agent chooses $a_t$ the endogenous state variable in the next period. $a_t \in \Gamma(a_{t-1}, e_t)$ where $\Gamma(a_{t-1}, e_t)$ is the set of feasible values given the current state $(a_{t-1}, e_t)$.
- $A = \{ (x,y,z) \in X\times X\times Z: y \in \Gamma(x,z)\}$

---

### Feasible plan

In period $\tau$, the agent knows the current state $s_{\tau} = (a_{\tau-1}, e_{\tau})$ and chooses $a_{\tau}$. It also makes contingency plans for $t\geq \tau$ (these decisions will depend upon the information available at that time). As a result, he chooses a sequences $\{a_t\}_{t\geq\tau}$. 

- A plan is an initial value $\pi_0 \in X$ and a sequence of measurable functions $\pi_t : Z^t \rightarrow X$ for $t\geq 1$.
- A plan $\pi$ is feasible from $s_0$ if $\pi_0 \in \Gamma(s_0)$ and $\pi_t (z^t) \in \Gamma(\pi_{t-1}(z^{t-1}),z_t)$ for all $z^t \in Z^t, t\geq 1$. 
- $\Pi(s_0)$ denotes the set of plans that are feasible from $s_0$.

---

### Non-empty set of feasible plans

Assumptions:
- $\Gamma$ is nonempty-valued and $(\mathcal{X} \times \mathcal{X} \times \mathcal{Z})$-measurable.
- $\Gamma$ has a measurable selection (i.e. $h$ measurable such that $h(s)\in\Gamma(s)$ for all $s$).

This results in $\Pi(s_0)$ being nonempty for all $s_0$.

---

### Recursive formulation

This sequential problem can be rewritten recursively:

$$ v(a_{t-1}, e_t) = \max_{0 \leq c_t \leq w e_t + ra_{t-1}} U(c_t) + \beta \mathbb{E}_t v(a_t, e_{t+1}) $$

where $c_t,~a_t$ are control variables and $e_t,~a_{t-1}$ state ones.

This recursive formulation exploits the stationarity of the problem: the decisions depend upon the past level of capital and the exogenous shock but not on the time period itself.

---

### Assumptions

- $U$ is continuous and bounded.
- $\Gamma$ is continuous and compact-valued.

These continous and compact-valued assumptions are required to ensure the solution exists.

---

### Bellman operator

Let's define the following operators:
- Bellman operator $T$: $(Tv)(s) = \max_{a\in A(s)} u(c) + \beta \sum_{s'} v(s')Q(s,a,s')$
- Operator $T_{\sigma}$ associated to policy function $\sigma$: $(T_{\sigma}v)(s) = u(c) + \beta \sum_{s'} v(s')Q(s,\sigma(s),s')$ which can be written in the compact form: $T_{\sigma} v = u + \beta Q_{\sigma} v$.

$\sigma$ is the policy function, that is: $a_t = \sigma(s_t) = \sigma((a_{t-1},e_t))$.

---

### Properties of these operators

- The two operators are monotone: $v\leq w$ implies that $Tv\leq Tw$ and $T_{\sigma} v \leq T_{\sigma}w$ pointwise.
- The two operators are contraction mappings with modulus $\beta$: $\left \| Tv-Tw \right \| \leq \beta \left \| v-w \right \|$ and $\left \| T_{\sigma}v-T_{\sigma}w \right \| \leq \beta \left \| v-w \right \|$

---

### Principle of optimality (Theorem 10.1.11 of Stachurski (2009))

The principle of optimality ensures that the optimal policy function of the recursive problem coincides with the optimal sequence of decisions of the sequential problem.

- The optimal value function $v^*$ is the unique solution to the Bellman equation (i.e. the unique fixed point of $T$).
- $\sigma^*$ is an optimal policy function if and only if it is $v^*$-greedy, that is: $\sigma^* (s) \in \argmax_{a\in A(s)} u(c) + \beta \sum_{s' \in S} v^*(s') Q(s,\sigma(s),s') $

---
## Simulations

---

## Aggregate Equilibrium


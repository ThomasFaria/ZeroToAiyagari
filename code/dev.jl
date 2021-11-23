using Plots
using Dolo
import Dolo: ergodic_distribution

model = Model("code/consumption_savings.yaml")

Dolo.set_calibration!(model; K=39)
println("r: ", model.calibration.flat[:r])
println("w: ", model.calibration.flat[:w])

init_dr = (i,s)->max.(s, 2 .+0.01.*(s.-2))

sol0 = improved_time_iteration(model; dr0=init_dr)


dr = sol0.dr


dr([1.0])


w = model.calibration.flat[:w]
r = model.calibration.flat[:r]

tab = tabulate(model, dr, :m)

plot(tab[:m], tab[:m], ylim=(0,4), xlabel="\$m_t\$", ylabel="\$c(m_t)\$")
plot!(tab[:m], tab[:c])
plot!(tab[:m], (w .+tab[:m]*r)./(1+r), label="\$E(m_{t+1}) = m_t\$")




N=1000
T=1000
sim = simulate(model, sol0.dr; N=N, s0=[2.5], T=T)
pl = plot()
for n=1:N
    plot!(pl, sim[N=n,V=:m, T=1:40], label=nothing, color=:red, alpha=0.1)
end
pl


import StatsPlots

sim = simulate(model, sol0.dr; N=N, s0=[2.5], T=T)

pl1 = StatsPlots.density(sim[T=1000, V=:m])

StatsPlots.density!(pl1, sim[N=1, V=:m, T=40:1000])


###
###
###

pl = plot(xlims=(0,10))
Kvec = [37,38,39, 40,41,45, 50, 55]

for K in Kvec

Dolo.set_calibration!(model; K=K)

sol = improved_time_iteration(model; dr0=(i,s)->sol0.dr(s))
# μ = ergodic_distribution(model, sol)

grid_exo = sol.dr.grid_exo
gg = sol.dr.grid_endo
grid_endo = Dolo.UCGrid([gg.min...],[10.0],1000)
 
μ, Π = ergodic_distribution(model, sol.dr, grid_exo, grid_endo, sol.dprocess )
x = cat(grid_endo.nodes...; dims=1)
plot!(pl, x, μ, label="K=$K")


end

pl
###
###
###

δ = model.calibration.flat[:delta]

function capital_supply(K0)
    Dolo.set_calibration!(model; K = K0)
    sol = improved_time_iteration(model;dr0=(i,s)->sol0.dr(s), verbose=false)
    μ = ergodic_distribution(model, sol)
    m = μ.axes[1].val
    c = sol.dr(m[:,[CartesianIndex()]])
    a = (m-c)/δ
    K1 = a'*μ.data
    return K1[1]
end




K0vec = range(35, 50; length=10)

@time K1vec = [capital_supply(k) for k in K0vec]

plot(K0vec, K1vec)
plot!(K0vec, K0vec)


ε=0.00001

function fun!(out, K)
    K0 = K[1]
    K1 = capital_supply(K0)
    # K1_d = capital_supply(K0+ε)
    # D = (K1_d - K1)/ε -1
    # return (K1 - K0, D)
    out[1] = K1-K0
end


xx0 = [40.0]

out0 = [0.0]

using NLsolve

@time NLsolve.nlsolve(fun!, xx0; show_trace=true)

using Plots
using Dolo
import Dolo: ergodic_distribution

model = Model("code/consumption_savings.yaml")

Dolo.set_calibration!(model; K=38)
println("r: ", model.calibration.flat[:r])
println("w: ", model.calibration.flat[:w])

sol0 = time_iteration(model, (m,s)->min.(s, 1 .+0.01*(s.-1)), maxit=2)


sol0 = improved_time_iteration(model, sol0.dr)


dr = sol0.dr


dr([1.0])


w = model.calibration.flat[:w]
r = model.calibration.flat[:r]

tab = tabulate(model, sol0.dr, :m)

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




μ = ergodic_distribution(model, sol0)

plot(μ.axes[1].val, μ)






function capital_supply(K0)
    Dolo.set_calibration!(model; K = K0)
    sol = improved_time_iteration(model, sol0.dr, verbose=false)
    μ = ergodic_distribution(model, sol)
    m = μ.axes[1].val
    c = sol.dr(m[:,[CartesianIndex()]])
    a = m .- c
    return (;m,c,a)
    K1 = a'*μ.data
    return K1[1]
end


res = capital_supply(39)

plot(res.m, res.m)
plot!(res.m, res.m-res.c)


K0vec = range(38, 41; length=100)

@time K1vec = [capital_supply(k) for k in K0vec]

plot(K0vec, K1vec)
plot!(K0vec, K0vec)


function fun(K0)
    K1 = capital_supply(K0)
    return K1 - K0
end

fun()

import Roots

x0 = 30

@time Roots.find_zero(fun, x0)



# TODO: update set_calibration
# check starting arguments of time_iteration
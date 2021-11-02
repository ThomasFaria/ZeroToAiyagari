using Plots
using Dolo
import Dolo: ergodic_distribution

model = Model("code/consumption_savings.yaml")

sol0 = time_iteration(model)
grid = sol0.dr.grid_endo

x = Dolo.nodes(Matrix, grid)[:]

Dolo.set_calibration!(model, :K, 38)
P, μ = ergodic_distribution(model, sol0)
plot(μ)



pl = plot(x,x, label="K0")
pl


@time begin
    K0 = 50

    Dolo.set_calibration!(model, :K, K0)
    sol = improved_time_iteration(model, sol0.dr)
    P, μ = ergodic_distribution(model, sol.dr, sol.dr.grid_exo, sol.dr.grid_endo, sol0.dprocess)

    K1 = x'*μ

    scatter!(pl, [K0], [K1])
end



function fun(K0)
    Dolo.set_calibration!(model, :K, K0)
    sol = improved_time_iteration(model, sol0.dr, verbose=false)
    grid = sol.dr.grid_endo
    P, μ = ergodic_distribution(model, sol.dr, sol.dr.grid_exo, sol.dr.grid_endo, sol0.dprocess)

    K1 = x'*μ
    return K1-K0
end


import Roots

x0 = 48

@time Roots.find_zero(fun, x0)



# TODO: update set_calibration
# check starting arguments of time_iteration
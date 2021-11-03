### A Pluto.jl notebook ###
# v0.17.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 824b3790-1dec-4bcc-a8f8-b50147d2b7ec
# let
#     import Pkg
#     Pkg.activate(".")
# end

# ╔═╡ e9a4f662-6f9f-485b-935e-9809c7a0964d
using PlutoUI

# ╔═╡ 31697a95-4af1-4195-81b4-576f74de5944
using Plots

# ╔═╡ 5255970e-9ed0-4352-8886-d635c156fb8b
using Dolo

# ╔═╡ 9ce5cb6c-6c0d-4324-8be2-1fb57ba1a8e7
cd("/home/pablo/Mobilhome/econforge/ZeroToAiyagari")

# ╔═╡ 394d2ee2-7d7e-46e7-8bc1-592e19aee1ec
import Dolo: ergodic_distribution

# ╔═╡ e9832098-c6ca-4197-8d72-a179e5390d97
model = Model("code/consumption_savings.yaml")

# ╔═╡ d30ba6b4-b482-4ca1-8614-16256fb23cfc
Dolo.set_calibration!(model, :K, 38)

# ╔═╡ 43873320-8e2b-4a74-a857-146970c055ec
sol0 = time_iteration(model)

# ╔═╡ 387a5f62-ede4-46ee-8256-e7b285e38e77
grid = sol0.dr.grid_endo

# ╔═╡ 6e40b3ad-e336-42c2-aec9-33a862408fff
x = Dolo.nodes(Matrix, grid)[:]

# ╔═╡ 27600263-6104-41a1-bb68-104761bb006c
pl1 = plot(x,x, label="K0");

# ╔═╡ 7387b8ae-e8dc-4471-ae8c-96716d7fb0dd
pl2 = plot(x,x*0, label="K0");

# ╔═╡ 5e6e8b3f-59ae-4e23-9508-cd9bfc0f9840
md"Shall we plot the distribution? $(@bind plot_distribution CheckBox())"



# ╔═╡ d864ba59-7587-4245-928f-4115fe620a98


# ╔═╡ 711fd2ca-c330-411e-9be5-57f6085ffc2b
@bind K0 Slider(25 : 0.1 : 60, default=35.0, show_value=true)


# ╔═╡ 842c2970-ccd5-42d8-b2d5-4f891f97398c


# ╔═╡ 0acded3c-c2b8-40fa-a2f3-98f7645f2797
begin
	
	    Dolo.set_calibration!(model, :K, K0)
	    sol = improved_time_iteration(model, sol0.dr, verbose=false)
	    P, μ = ergodic_distribution(model, sol.dr, sol.dr.grid_exo, sol.dr.grid_endo, sol0.dprocess)
	
	    K1 = x'*μ
	scatter!(pl1, [K0], [K1], legend=nothing)
	if plot_distribution
		plot!(pl2, x, μ, legend=nothing)
		pl = plot(pl1, pl2)
	else
		pl = pl1
	end
	pl  
		
end

# ╔═╡ Cell order:
# ╠═9ce5cb6c-6c0d-4324-8be2-1fb57ba1a8e7
# ╠═824b3790-1dec-4bcc-a8f8-b50147d2b7ec
# ╠═e9a4f662-6f9f-485b-935e-9809c7a0964d
# ╠═31697a95-4af1-4195-81b4-576f74de5944
# ╠═394d2ee2-7d7e-46e7-8bc1-592e19aee1ec
# ╠═5255970e-9ed0-4352-8886-d635c156fb8b
# ╠═e9832098-c6ca-4197-8d72-a179e5390d97
# ╠═d30ba6b4-b482-4ca1-8614-16256fb23cfc
# ╠═43873320-8e2b-4a74-a857-146970c055ec
# ╠═387a5f62-ede4-46ee-8256-e7b285e38e77
# ╠═6e40b3ad-e336-42c2-aec9-33a862408fff
# ╠═27600263-6104-41a1-bb68-104761bb006c
# ╠═7387b8ae-e8dc-4471-ae8c-96716d7fb0dd
# ╠═5e6e8b3f-59ae-4e23-9508-cd9bfc0f9840
# ╠═d864ba59-7587-4245-928f-4115fe620a98
# ╠═711fd2ca-c330-411e-9be5-57f6085ffc2b
# ╠═842c2970-ccd5-42d8-b2d5-4f891f97398c
# ╠═0acded3c-c2b8-40fa-a2f3-98f7645f2797

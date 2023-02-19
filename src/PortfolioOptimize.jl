"""
    PortfolioOptimize(R::TSFrame)

Calculates the `optimal Portfolio weights` for `minumum-variance portfolio`.

# Arguments:
 * `R::TSFrame`: columns of TSFrame object of asset returns

# Example
```julia
julia> opt = PortfolioOptimize(returns)

EXIT: Optimal Solution Found.
(preturn = -0.025216712326596998, pvar = 0.06893199595428622, pweights = 3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────────
TSLA             │ 1.46169e-7
NFLX             │ 5.31995e-8
MSFT             │        1.0)

julia> portreturn = opt.preturn # or opt[1]
-0.025216712326596998

julia> portvar = opt.pvar # or opt[2]
0.06893199595428622

julia> portweights = opt.pweights # or opt[3]
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────────
TSLA             │ 1.46169e-7
NFLX             │ 5.31995e-8
MSFT             │        1.0
```

# Output:
Named Tuple
  * 1, `preturn` : portfolio mean return
  * 2, `pvar`: portfolio variable
  * 3, `pweights`: optimal portfolio weights for minumum variance portfolio
"""
function PortfolioOptimize(R::TSFrame)

    means = mean.(eachcol(Matrix(R)))
    covMatrix = cov(Matrix(R))
    
    model = Model(Ipopt.Optimizer)
    
    @variable(model, 0 <= w[1:size(R)[2]] <= 1)
    @constraint(model, sum(w) == 1)
    
    @expression(model, quad_expr, w' * covMatrix * w)
    
    @NLobjective(model, Min, sqrt(quad_expr))
    
    optimize!(model)

    portvar = objective_value(model)
    
    weights = value.(w)
    
    pmreturn = weights' * means

    colnames = names(R) # used only for naming array
    weights = NamedArray(weights, colnames, "Optimal Weights")


    return (preturn = pmreturn, pvar = portvar, pweights = weights)
end
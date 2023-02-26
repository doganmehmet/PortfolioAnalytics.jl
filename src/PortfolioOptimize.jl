"""
    PortfolioOptimize(R::TSFrame, objective::String = "minumum variance"; target = Nothing, Rf::Number = 0)

Calculates the `optimal Portfolio weights` for a given `objective` and `target` return.

# Arguments:
 * `R::TSFrame`: columns of TSFrame object of asset returns
 * `objective::String = "minumum variance"`: portfolio objective, minimizes the standard deviation for the portfolio. Available objecives; `"minumum variance"` and `"maximum sharpe"`
 * `target = Nothing`: target portfolio mean return for a chosen objective. It allows to move accross the efficient frontier
 * `Rf::Number = 0`: risk-free rate, used with `maximum sharpe`

# Example
```julia
julia> opt1 = PortfolioOptimize(returns, "minumum variance")
julia> opt_weights = opt1.pweights
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────
TSLA             │   -0.0
NFLX             │ 0.4438
MSFT             │ 0.5562


# plotting efficient frontier and decision space
julia> opt1.plt
```

Optimize minumum-variance portfolio with a minumum return target of 4%
```julia
julia> opt2 = PortfolioOptimize(returns, "minumum variance", target = 0.04)

# optimal portfolio weights for a chosen objective and target return
julia> opt2.pweights
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────
TSLA             │ 0.5142
NFLX             │    0.0
MSFT             │ 0.4858
```

Optimization of maximum sharpe portfolio
```julia
julia> opt3 = PortfolioOptimize(returns, "maximum sharpe")
julia> opt3.pweights
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼─────
TSLA             │ -0.0
NFLX             │  0.0
MSFT             │  1.0

julia> opt3.plt
```

Optimization of maximum sharpe portfolio with target return of at least 4%
```julia
julia> opt4 = PortfolioOptimize(returns, "maximum sharpe", target = 0.04)
julia> opt4.pweights
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────
TSLA             │ 0.5142
NFLX             │   -0.0
MSFT             │ 0.4858
```

# Output:
Named Tuple
  * 1, `preturn` : portfolio mean return
  * 2, `prisk`: portfolio standard deviation
  * 3, `psharpe`: portfolio sharpe ratio
  * 4, `pweights`: optimal portfolio weights for chosen `objective` and defined `target`
  * 5, `plt`: plot of the `efficient frontier` and `decision space`
  * 6, `pm`: list of `expected returns` per each solution
  * 7, `po`: list of objective values per portfolio. If the objective is `minimum-variance`, then standard deviations of each optimal portfolio. If the objective is set to the `maximum-sharpe`, then the Sharpe Ratios of each portfolio.
  * 8, `pw`: list of `weights` per each solution
"""
function PortfolioOptimize(R::TSFrame, objective::String = "minumum variance"; target = Nothing, Rf::Number = 0)

    colnames = names(R) # used only for naming array
    R = Matrix(R)

    μ = vec(Statistics.mean(R; dims = 1))
    Q = Statistics.cov(R)

    model = Model(() -> MultiObjectiveAlgorithms.Optimizer(Ipopt.Optimizer))
    set_silent(model)
    set_optimizer_attribute(model, MultiObjectiveAlgorithms.Algorithm(), MultiObjectiveAlgorithms.EpsilonConstraint())
    set_optimizer_attribute(model, MultiObjectiveAlgorithms.SolutionLimit(), 25)

    @variable(model, 0 <= w[1:size(R, 2)] <= 1)
    @constraint(model, sum(w) == 1)
    @expression(model, variance, w' * Q * w)
    @expression(model, expected_return, w' * μ)
     
    if objective == "minumum variance"
        # We want to minimize variance and maximize expected return, but we must pick
        # a single objective sense `Min`, and negate any `Max` objectives:
        @objective(model, Min, [variance, -expected_return])
        if target != Nothing
            @constraint(model, expected_return >= target)
        end

    elseif objective == "maximum sharpe"
        @variable(model, sharpe)
        @NLconstraint(model, sharpe <= expected_return / sqrt(variance)) 
        
        @objective(model, Max, [expected_return, sharpe])
        if target != Nothing
            @constraint(model, expected_return >= target)
        end
    else
        throw(ArgumentError("one of the available objective must be chosen"))
    end

    
    optimize!(model)
    
    weights = round.(value.(w), digits = 4)
    portreturn = round(weights' * μ, digits = 4)
    portrisk = round(sqrt(weights' * Q * weights), digits = 4)
    portsharpe = round(((weights' * μ) - Rf) / portrisk, digits = 4)
    weights = NamedArray(weights, colnames, "Optimal Weights")

    pm = [value(expected_return; result = i) for i in 1:result_count(model)]
    pw = [value.(w; result = i) for i in 1:result_count(model)]

    if objective == "minumum variance"
        po = sqrt.([value(variance; result = i) for i in 1:result_count(model)])
        plt_objective = Plots.scatter(
            po,
            pm * 100;
            xlabel = "StdDev",
            ylabel = "Expected Return (%)",
            label = "",
            markersize = 5,
            legend = :bottomright,
            )
    
        decision_space = StatsPlots.groupedbar(
            vcat([value.(w; result = i)'*100 for i in 1:result_count(model)]...);
            bar_position = :stack,
            label = reshape(colnames,1,length(colnames)),
            xlim = (0.5,25.5),
            xlabel = "Portfolio #",
            ylabel = "Weight (%)",
            title = "",
        )
    
        plt = Plots.plot(plt_objective, decision_space; layout = (2, 1))
    end

    if objective == "maximum sharpe"
            po = [value(sharpe; result = i) for i in 1:result_count(model)]
            plt_objective = Plots.scatter(
            po,
            pm * 100;
            xlabel = "Sharpe",
            ylabel = "Expected Return (%)",
            label = "",
            markersize = 5,
            legend = :bottomright,
        )

        decision_space = StatsPlots.groupedbar(
            vcat([value.(w; result = i)'*100 for i in 1:result_count(model)]...);
            bar_position = :stack,
            label = reshape(colnames,1,length(colnames)),
            xlim = (0.5,25.5),
            xlabel = "Portfolio #",
            ylabel = "Weight (%)",
            title = "",
        )

        plt = Plots.plot(plt_objective, decision_space; layout = (2, 1))
    end

    return (preturn = portreturn, prisk = portrisk, psharpe = portsharpe, pweights = weights, plt = plt, pm = pm, po = po, pw = pw)

end
# Functions

```@index
```

```julia
using PortfolioAnalytics
using Dates
using TSFrames

dates = Date(2020, 12, 31):Month(1):Date(2021, 12, 31)
TSLA = [235.22,264.51,225.16,222.64,236.48,208.40,226.56,229.06,245.24,258.49,371.33,381.58,352.26]
NFLX = [540.73,532.39,538.85,521.66,513.47,502.81,528.21,517.57,569.19,610.34,690.31,641.90,602.44]
MSFT = [222.42,231.96,232.38,235.77,252.18,249.68,270.90,284.91,301.88,281.92,331.62,330.59,336.32]

prices_ts = TSFrame([TSLA NFLX MSFT], dates, colnames=[:TSLA, :NFLX, :MSFT])

13×3 TSFrame with Date Index
 Index       TSLA     NFLX     MSFT    
 Date        Float64  Float64  Float64 
───────────────────────────────────────
 2020-12-31   235.22   540.73   222.42 
 2021-01-31   264.51   532.39   231.96 
 2021-02-28   225.16   538.85   232.38 
 2021-03-31   222.64   521.66   235.77 
 2021-04-30   236.48   513.47   252.18 
 2021-05-31   208.4    502.81   249.68 
 2021-06-30   226.56   528.21   270.9  
 2021-07-31   229.06   517.57   284.91 
 2021-08-31   245.24   569.19   301.88 
 2021-09-30   258.49   610.34   281.92 
 2021-10-31   371.33   690.31   331.62
 2021-11-30   381.58   641.9    330.59
 2021-12-31   352.26   602.44   336.32

weights = [0.4, 0.4, 0.2]
3-element Vector{Float64}:
 0.4
 0.4
 0.2
```

```@docs
asset_return
```

```@docs
portfolio_return
```

```julia
julia> all_returns = TSFrames.join(returns, preturns)
12×4 TSFrame with Date Index
 Index       TSLA        NFLX        MSFT         PORT        
 Date        Float64?    Float64?    Float64?     Float64?    
──────────────────────────────────────────────────────────────
 2021-01-31   0.124522   -0.0154236   0.0428918    0.0522176
 2021-02-28  -0.148766    0.012134    0.00181066  -0.0542905
 2021-03-31  -0.011192   -0.0319013   0.0145882   -0.0143197
 2021-04-30   0.0621631  -0.0156999   0.0696017    0.0325056
 2021-05-31  -0.118742   -0.0207607  -0.00991355  -0.0577836
 2021-06-30   0.0871401   0.0505161   0.0849888    0.0720602
 2021-07-31   0.0110346  -0.0201435   0.0517165    0.00669974
 2021-08-31   0.0706365   0.0997353   0.0595627    0.0800613
 2021-09-30   0.0540287   0.0722957  -0.066119     0.037306
 2021-10-31   0.436535    0.131025    0.176291     0.262282
 2021-11-30   0.0276035  -0.0701279  -0.00310596  -0.017631
 2021-12-31  -0.0768384  -0.0614737   0.0173326   -0.0518583
```

```@docs
sharpe
```

```@docs
mean_return
```

```@example
using NamedArrays# hide
returns = [0.0431772, 0.010848, 0.0366371] # hide
tickers = ["TSLA", "NFLX", "MSFT"] # hide
mreturn = NamedArray(returns, tickers)# hide

using Plots
# plotting mean return of stocks and portfolio
bar(names(mreturn), mreturn, labels = false)
```

```@docs
stddev
```

```@docs
moments
```

```@docs
value_at_risk
```

```@docs
es
```

```@docs
portfolio_optimize
```
##### Example
```@example half-loop; continued = true
using JuMP # hide
using Ipopt # hide
using Statistics # hide
using TSFrames # hide
using NamedArrays # hide

using JuMP # hide
using Ipopt # hide
using MultiObjectiveAlgorithms # hide
using Plots # hide
using StatsPlots # hide

function portfolio_optimize(R::TSFrame, objective::String = "minumum variance"; target = Nothing, Rf::Number = 0) # hide

    colnames = names(R) # used only for naming array # hide
    R = Matrix(R) # hide

    μ = vec(Statistics.mean(R; dims = 1)) # hide
    Q = Statistics.cov(R) # hide

    model = Model(() -> MultiObjectiveAlgorithms.Optimizer(Ipopt.Optimizer)) # hide
    set_silent(model) # hide
    set_optimizer_attribute(model, MultiObjectiveAlgorithms.Algorithm(), MultiObjectiveAlgorithms.EpsilonConstraint()) # hide
    set_optimizer_attribute(model, MultiObjectiveAlgorithms.SolutionLimit(), 25) # hide

    @variable(model, 0 <= w[1:size(R, 2)] <= 1) # hide
    @constraint(model, sum(w) == 1) # hide
    @expression(model, variance, w' * Q * w) # hide
    @expression(model, expected_return, w' * μ) # hide
     
    if objective == "minumum variance" # hide
        # We want to minimize variance and maximize expected return, but we must pick # hide
        # a single objective sense `Min`, and negate any `Max` objectives: # hide
        @objective(model, Min, [variance, -expected_return]) # hide
        if target != Nothing # hide
            @constraint(model, expected_return >= target) # hide
        end # hide

    elseif objective == "maximum sharpe" # hide
        @variable(model, sharpe) # hide
        @NLconstraint(model, sharpe <= expected_return / sqrt(variance))  # hide
        
        @objective(model, Max, [expected_return, sharpe]) # hide
        if target != Nothing # hide
            @constraint(model, expected_return >= target) # or # hide
        end # hide
    else # hide
        throw(ArgumentError("one of the available objective must be chosen")) # hide
    end # hide

    
    optimize!(model) # hide
    
    weights = round.(value.(w), digits = 4) # hide
    portreturn = round(weights' * μ, digits = 4) # hide
    portrisk = round(sqrt(weights' * Q * weights), digits = 4) # hide
    portsharpe = round(((weights' * μ) - Rf) / portrisk, digits = 4) # hide
    weights = NamedArray(weights, colnames, "Optimal Weights") # hide

    pm = [value(expected_return; result = i) for i in 1:result_count(model)] # hide
    pw = [value.(w; result = i) for i in 1:result_count(model)] # hide

    if objective == "minumum variance" # hide
        po = sqrt.([value(variance; result = i) for i in 1:result_count(model)]) # hide
        plt_objective = Plots.scatter( # hide
            po, # hide
            pm*100; # hide
            xlabel = "StdDev", # hide
            ylabel = "Return (%)", # hide
            label = "", # hide
            markersize = 5, # hide
            legend = :bottomright, # hide
            ) # hide
    
        decision_space = StatsPlots.groupedbar( # hide
            vcat([value.(w; result = i)'*100 for i in 1:result_count(model)]...); # hide
            bar_position = :stack, # hide
            label = reshape(colnames,1,length(colnames)), # hide
            xlim = (0.5,25.5), # hide
            xlabel = "Portfolio #", # hide
            ylabel = "Weight (%)", # hide
            title = "", # hide
        ) # hide
    
        plt = Plots.plot(plt_objective, decision_space; layout = (2, 1)) # hide
    end # hide

    if objective == "maximum sharpe" # hide
            po = [value(sharpe; result = i) for i in 1:result_count(model)] # hide
            plt_objective = Plots.scatter( # hide
            po, # hide
            pm*100; # hide
            xlabel = "Sharpe", # hide
            ylabel = "Return (%)", # hide
            label = "", # hide
            markersize = 5, # hide
            legend = :bottomright, # hide
        ) # hide

        decision_space = StatsPlots.groupedbar( # hide
            vcat([value.(w; result = i)'*100 for i in 1:result_count(model)]...); # hide
            bar_position = :stack, # hide
            label = reshape(colnames,1,length(colnames)), # hide
            xlim = (0.5,25.5), # hide
            xlabel = "Portfolio #", # hide
            ylabel = "Weight (%)", # hide
            title = "", # hide
        ) # hide

        plt = Plots.plot(plt_objective, decision_space; layout = (2, 1)) # hide
    end # hide

    return (preturn = portreturn, prisk = portrisk, psharpe = portsharpe, pweights = weights, plt = plt, pm = pm, po = po, pw = pw) # hide

end # hide

bond = [0.06276629, 0.03958098, 0.08456482,0.02759821,0.09584956,0.06363253,0.02874502,0.02707264,0.08776449,0.02950032]
stock = [0.1759782,0.20386651,0.21993588,0.3090001,0.17365969,0.10465274,0.07888138,0.13220847,0.28409742,0.14343067]

R = TSFrame([bond stock], colnames  = [:bond, :stock])
```

Minumum variance portfolio.
```@example half-loop
opt = portfolio_optimize(R, "minumum variance")
opt.pweights
```


Minumum variance portfolio with 10% target return.
```@example half-loop
opt1 = portfolio_optimize(R, "minumum variance", target = 0.1)
opt1.plt
```

Maximum Sharpe portfolio with 15% target return.
```@example half-loop
opt2 = portfolio_optimize(R, "maximum sharpe", target = 0.15)
opt2.plt
```

```@example half-loop
using Plots
# plotting optimal weights for maximum sharpe portfolio with 15% return target
bar(names(opt2.pweights), opt2.pweights, labels = false)
```

```@docs
cumulative_return
```

```@docs
drawdowns
```


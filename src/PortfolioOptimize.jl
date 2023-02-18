"""
Calculates the optimal Portfolio weights for minumum-variance portfolio

```
PortfolioOptimize(returns[2:13])
```

Arguments:
    R: columns of TSFrame object of asset returns

Output:
    - Named Tuple
        - 1, preturn : portfolio mean return
        - 2, pvar: portfolio variable
        - 3, pweights: optimal portfolio weights for minumum variance portfolio
Notes:
    -

Issues:
    - Doesn't work in presense of NAs or missing values. Will be fixed in the next release
    
To do:
    - Maximize SharpeRatio
    - Custom constraints
    - NamedArray to be used for weights
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

    pvar = objective_value(model)
    
    weights = value.(w)
    
    pmreturn = weights' * means

    colnames = names(R) # used only for naming array
    weights = NamedArray(weights, colnames, "Optimal Weights")


    return pmreturn, pvar, weights
end
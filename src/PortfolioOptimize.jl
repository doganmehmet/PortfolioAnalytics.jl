# Calculates the optimal Portfolio weights for minumum-variance portfolio
# Output is a tupple
    # first element is mean portfolio return
    # second is portfolio variance
    # third is optimal weights
    
# Minimizes the portfolio variance
# To me implemented:
    # Maximize SharpeRatio
    # Custom constraints

# Arguments
    #  R: columns of TSFrame, or columns of DataFrame object of asset returns
function PortfolioOptimize(R)

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
    
    mreturn = weights' * means

    return mreturn, pvar, weights
end
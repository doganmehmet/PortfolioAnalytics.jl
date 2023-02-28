"""
    es(R::TSFrame, p::Number=0.95; method::String="historical")

Calculates `Expected Shortfall (Conditional Value at Risk)` from `asset returns`. Output is a `NamedArray`.

# Arguments:
 * `R::TSFrame`: column(s) of TSFrame object of asset returns
 * `p::Number=0.95`: confidence level
 * `method::String="historical"`: method of Expected Shortfall calculation

# Example
```julia
julia> ES = es(all_returns)
4-element Named Vector{Any}
95% historical ES  │
───────────────────┼───────────
TSLA               │  -0.148766
NFLX               │ -0.0701279
MSFT               │  -0.066119
PORT               │ -0.0577836
```


# Notes:
 * Available methods: `"historical"` and `"parametric"`
 * Monte Carlo method will be implemented as part of the next release
"""
function es(R::TSFrame, p::Number=0.95; method::String="historical")
    
valueatrisk = vec(VaR(R, p, method = method))
idx = Matrix(R) .< valueatrisk'
counts = sum.(skipmissing.(eachcol(idx)))

es = []
for (index, col) in enumerate(eachcol(Matrix(R)))
    
    exsfall = sum(col[isless.(col, valueatrisk[index])]) / counts[index]
    push!(es, exsfall)

end

colnames = names(R)
conf = Int(100*p)

return NamedArray(es, colnames, "$conf% $method ES")

end
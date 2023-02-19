"""
    SharpeRatio(R::TSFrame, Rf::Number=0)

Calculates `Sharpe Ratio` from `asset returns`. Output is a `NamedArray`.

# Arguments:
 * `R::TSFrame`: column(s) of TSFrame object of asset returns
 * `Rf::Number=0`: Risk free rate

# Example
```julia
julia> sharpe = SharpeRatio(all_returns)
4-element Named Vector{Float64}
Sharpe  │ 
────────┼──────────
TSLA    │ -0.372359
NFLX    │ -0.164948
MSFT    │  -0.36582
PRETURN │  -0.32811
```
"""
function SharpeRatio(R::TSFrame, Rf::Number=0)
    meanReturn = mean.(eachcol(Matrix(R)))
    StdDev = std.(eachcol(Matrix(R)))
    sharpe = (meanReturn .- Rf) ./ StdDev

    colnames = names(R)

    return NamedArray(sharpe, colnames, "Sharpe") 
    
end

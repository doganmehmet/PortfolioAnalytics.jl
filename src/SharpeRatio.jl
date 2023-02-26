"""
    SharpeRatio(R::TSFrame, Rf::Number=0)

Calculates `Sharpe Ratio` from `asset returns`. Output is a `NamedArray`.

# Arguments:
 * `R::TSFrame`: column(s) of TSFrame object of asset returns
 * `Rf::Number=0`: Risk-free rate

# Example
```julia
julia> sharpe = SharpeRatio(all_returns)
4-element Named Vector{Float64}
Sharpe Ratio (Rf=0)  │
─────────────────────┼─────────
TSLA                 │ 0.288602
NFLX                 │ 0.170242
MSFT                 │ 0.606824
PORT                 │ 0.329079
```
"""
function SharpeRatio(R::TSFrame, Rf::Number=0)
    
    colnames = names(R)
    R = Matrix(R)

    if any(ismissing.(R))
        @warn("missing's detected: skipping missing's")
    end
    
    meanReturn = mean.(skipmissing.(eachcol(R)))
    StdDev = std.(skipmissing.(eachcol(R)))
    sharpe = (meanReturn .- Rf) ./ StdDev


    return NamedArray(sharpe, colnames, "Sharpe Ratio (Rf=$Rf)") 
    
end


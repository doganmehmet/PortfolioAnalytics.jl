"""
    MeanReturn(R::TSFrame)

Calculates the `mean return` from `asset returns`. Output is a `NamedArray`.

# Example
```julia
julia> mreturn = MeanReturn(all_returns)
4-element Named Vector{Float64}
Mean Return  │
─────────────┼───────────
TSLA         │ -0.0688762
NFLX         │  -0.034517
MSFT         │ -0.0252167
PRETURN      │ -0.0464006
```
"""
function MeanReturn(R::TSFrame)
    mreturn = Statistics.mean.(eachcol(Matrix(R)))
    colnames = names(R) 
    meanReturn = NamedArray(mreturn, colnames, "Mean Return")
    return meanReturn
end
"""
    StdDev(R::TSFrame)

Calculates the `standard deviation` of `asset returns`. Output is a `NamedArray`.

# Example
```julia
julia> StdDev(all_returns)
4-element Named Vector{Float64}
σ    │
─────┼──────────
TSLA │  0.149608
NFLX │ 0.0637211
MSFT │ 0.0603753
PORT │ 0.0879347
```
"""
function StdDev(R::TSFrame)

    colnames = names(R)
    R = Matrix(R)

    if any(ismissing.(R))
        @warn("missing's detected: skipping missing's")
    end

    sddev = Statistics.std.(skipmissing.(eachcol(R)))
    standev = NamedArray(sddev, colnames, "σ")

    return standev
end
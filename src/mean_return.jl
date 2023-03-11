"""
    mean_return(R::TSFrame; geometric::Bool=true)

Calculates the `mean return` from `asset returns`. Output is a `NamedArray`.

# Arguments:
 * `R::TSFrame`: column(s) of TSFrame object of asset returns
 * `geometric::Bool=true`: if true, calculates geometric mean

# Example
```julia
julia> mean_return(returns)
4-element Named Vector{Float64}
μ    │
─────┼───────────
TSLA │  0.0342267
NFLX │ 0.00904634
MSFT │  0.0350585


julia> mean_return(returns, geometric=false)
4-element Named Vector{Float64}
μ    │
─────┼──────────
TSLA │ 0.0431772
NFLX │  0.010848
MSFT │ 0.0366371
```
"""
function mean_return(R::TSFrame; geometric::Bool=true)
    colnames = names(R)
    R = Matrix(R)

    if any(ismissing.(R))
        @warn("missing's detected: skipping missing's")
    end

    if geometric == false    
        mreturn = Statistics.mean.(skipmissing.(eachcol(R)))
    else 
        R1 = R + ones(size(R))
        Rprod = last.(cumprod.(Vector{Float64}.(filter.(!ismissing, eachcol(R1)))))
        mreturn = (Rprod .^ (1/size(R)[1])) .- 1
    end

    meanReturn = NamedArray(mreturn, colnames, "μ")
    return meanReturn
end
"""
    VaR(R::TSFrame, p::Number=0.95; method::String="historical")

Calculates `Value-at-Risk(VaR)` from `asset returns`. Output is a `NamedArray`.

# Arguments:
 * `R::TSFrame`: column(s) of TSFrame object of asset returns
 * `p::Number=0.95`: confidence level
 * `method::String="historical"`: method of VaR calculation, available methods; `"historical"` and `"parametric"`

# Example
```julia
julia> var_historical = VaR(returns)
4-element Named Vector{Float64}
95% historical VaR  │
────────────────────┼───────────
TSLA                │  -0.132252
NFLX                │ -0.0653681
MSFT                │  -0.035206

julia> var_parametric = VaR(returns, 0.90, method = "parametric")
4-element Named Vector{Float64}
90% parametric VaR  │
────────────────────┼───────────
TSLA                │  -0.148553
NFLX                │ -0.0708139
MSFT                │ -0.0407369
```
"""
function VaR(R::TSFrame, p::Number=0.95; method::String="historical")
    
    colnames = names(R)
    R = Matrix(R)

    if any(ismissing.(R))
        @warn("missing's detected: skipping missing's")
    end

    alpha = 1 - p

    if method == "historical"
        VAR = Distributions.quantile.(skipmissing.(eachcol(R)), alpha)
    elseif method == "parametric"
        VAR = mean.(skipmissing.(eachcol(R))) - (std.(skipmissing.(eachcol(R))) .* Distributions.quantile(Normal(), p))
    else
        throw(ArgumentError("one of the available method must be chosen"))
    end
    
    conf = Int(100*p)
    
    return NamedArray(VAR, colnames, "$conf% $method VaR")

end



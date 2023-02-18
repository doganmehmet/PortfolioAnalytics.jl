"""
    VaR(R::TSFrame; p::Number = 0.95, method::String = "historical")

Calculates `Value-at-Risk(VaR)` from `asset returns`. Output is a `NamedArray`.

# Arguments:
 * `R::TSFrame`: column(s) of TSFrame object
 * `p::Number = 0.95`: confidence interval
 * `method::String = "historical"`: method of VaR calculation

# Example
```julia
julia> var_historical = VaR(all_returns)
4-element Named Vector{Float64}
95% VaR  │ 
─────────┼──────────
TSLA     │ -0.274019
NFLX     │ -0.381359
MSFT     │ -0.104097
preturn  │ -0.230885

julia> var_parametric = VaR(all_returns, p = 0.90, method = "parametric")
4-element Named Vector{Float64}
90% VaR  │
─────────┼──────────
TSLA     │ -0.305928
NFLX     │ -0.302693
MSFT     │ -0.113557
preturn  │ -0.227635
```

# Notes:
 * Available methods: `"historical"` and `"parametric"`
 * Monte Carlo method will be implemented as part of the next release
"""
function VaR(R::TSFrame; p::Number = 0.95, method::String = "historical")

    alpha = 1 - p

    if method == "parametric"
        VAR = mean.(eachcol(Matrix(R))) - (std.(eachcol(Matrix(R))) .* Distributions.quantile(Normal(), p)) 
    else
        VAR = Distributions.quantile.(eachcol(Matrix(R)), alpha) 
    end

    colnames = names(R) # used only for naming array
    conf = Int(100*p) # used only for naming array
    
    
    return NamedArray(VAR, colnames, "$conf% VaR")

end


"""
    Moments(R::TSFrame)

Calculates the `(statistical) moments` of `asset returns`. Output is a `NamedArray`.

# Example
```julia
julia> pmoments = Moments(all_returns)
4×4 Named Matrix{Float64}
Tickers ╲ Moments │      Mean        Std   Skewness   Kurtosis
──────────────────┼───────────────────────────────────────────
TSLA              │ 0.0431772   0.149608    1.36882    2.19682
NFLX              │  0.010848  0.0637211   0.604374  -0.808401
MSFT              │ 0.0366371  0.0603753   0.681468   0.790701
PORT              │ 0.0289375  0.0879347    1.53379    2.19321
```

# Output:
 * `NamedArray`; rows: `tickers`, columns: `moments`

# Notes:
 * `Kurtosis`: `excess kurtosis`
"""
function Moments(R::TSFrame)
    
    colnames = names(R)
    R = Matrix(R)

    if any(ismissing.(R))
        @warn("missing's detected: skipping missing's")
    end

    Mean = Statistics.mean.(skipmissing.(eachcol(R)))
    StdDev = Statistics.std.(skipmissing.(eachcol(R)))
    skew = Distributions.skewness.(Vector{Float64}.(filter.(!ismissing, eachcol(R))))
    kurt = Distributions.kurtosis.(Vector{Float64}.(filter.(!ismissing, eachcol(R))))
       
    return NamedArray([Mean StdDev skew kurt], (colnames, ["Mean", "Std", "Skewness", "Kurtosis"]), ("Tickers", "Moments"))  
    
end
"""
    Moments(R::TSFrame)

Calculates the `(statistical) moments` of `asset returns`. Output is a `NamedArray`.

# Examples
```julia
julia> pmoments = testModule.Moments(all_returns)
4×4 Named Matrix{Float64}
Rows ╲ Cols │       TSLA        NFLX        MSFT     preturn
────────────┼───────────────────────────────────────────────
Mean        │ -0.0688762   -0.034517  -0.0252167  -0.0464006
Std         │   0.184973    0.209259    0.068932    0.141418
Skewness    │   0.868756   -0.600014    0.724772    0.415989
Kurtosis    │   0.529269    0.333629   -0.635292    0.415647
```

# Output:
 * `NamedArray`; rows: `moments`, columns: `tickers`

# Notes:
 * `Kurtosis`: `excess kurtosis`
"""
function Moments(R::TSFrame)
    
    Mean = Statistics.mean.(eachcol(Matrix(R)))
    StdDev = Statistics.std.(eachcol(Matrix(R)))
    skew = Distributions.skewness.(eachcol(Matrix{Float64}(Matrix(R))))
    kurt = Distributions.kurtosis.(eachcol(Matrix{Float64}(Matrix(R))))

    colnames = names(R)
       
    return NamedArray([Mean'; StdDev'; skew'; kurt'], (["Mean", "Std", "Skewness", "Kurtosis"], colnames), ("Rows", "Cols"))
end
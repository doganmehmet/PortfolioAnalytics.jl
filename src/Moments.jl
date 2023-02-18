"""Calculates the (statistical) moments of asset returns

```
Moments(R)
```

Arguments:
    R: column(s) of TSFrame object of asset returns

Output:
    - NamedArray, rows: moments, columns: tickers
Notes:
    - Kurtosis: excess kurtosis

Issues:
    - Doesn't work in presense of NAs or missing values. Will be fixed in the next release
    
To do:
    - 
"""
function Moments(R::TSFrame)
    
    Mean = Statistics.mean.(eachcol(Matrix(R)))
    StdDev = Statistics.std.(eachcol(Matrix(R)))
    skew = Distributions.skewness.(eachcol(Matrix{Float64}(Matrix(R))))
    kurt = Distributions.kurtosis.(eachcol(Matrix{Float64}(Matrix(R))))

    colnames = names(R)
       
    return NamedArray([Mean'; StdDev'; skew'; kurt'], (["Mean", "Std", "Skewness", "Kurtosis"], colnames), ("Rows", "Cols"))
end
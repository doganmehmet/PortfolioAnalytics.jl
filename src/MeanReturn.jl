"""Calculates the mean return from asset return

```
MeanReturn(returns)
```

Arguments:
    R: column(s) of TSFrame object of asset returns

Output:
    - NamedArray
Notes:
    -

Issues:
    - Doesn't work in presense of NAs or missing values. Will be fixed in the next release
    
To do:
    - 
"""
function MeanReturn(R::TSFrame)
    mreturn = Statistics.mean.(eachcol(Matrix(R)))
    colnames = names(R) 
    meanReturn = NamedArray(mreturn, colnames, "Mean Return")
    return meanReturn
end
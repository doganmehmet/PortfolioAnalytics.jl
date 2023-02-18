"""Calculates Sharpe Ratio

```
preturns_ts = TSFrame(preturns[2:end])
SharpeRatio(preturns_ts)
```

Arguments:
    - R: column(s) of TSFrame object of asset returns
    - Rf: Risk free rate, default = 0

Output:
    - NamedArray

Notes:
    - 

Issues:
    - It does not accept the missing values. Will be fixed in the next release.
    - Needs to be passed single column only. if multiple columns are passed it will be calculaing one single SharpeRatio which is wrong. Will be fixed in the next release.

To do:
    - 
"""
function SharpeRatio(R::TSFrame, Rf::Number = 0)
    meanReturn = mean.(eachcol(Matrix(R)))
    StdDev = std.(eachcol(Matrix(R)))
    sharpe = (meanReturn .- Rf) ./ StdDev

    colnames = names(R)

    return NamedArray(sharpe, colnames, "Sharpe") 
    
end

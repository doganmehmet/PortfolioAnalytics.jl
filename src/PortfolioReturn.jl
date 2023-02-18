""" Calculates portfolio return

```
preturns = PortfolioReturn(prices_ts, [0.4, 0.4, 0.2])
```

Arguments:
    - price: column(s) of TSFrame object of asset prices
    - weights: weights of assets of type Vector{Float64}
    - period: Period, Int

Output:
    - TSFrame object, missing period is automatically removed

Notes:
    -

Issues:
    -

To do:
    - Rebalancing to be added
"""
function PortfolioReturn(price::TSFrame, weights::Vector{Float64}, period::Int = 1)
    
    preturns = Matrix(TSFrames.pctchange(price, period)) * weights

    ts = TSFrame(preturns, TSFrames.index(price))[(period+1):end]
    TSFrames.rename!(ts, ["preturn"])
    
    return ts

end

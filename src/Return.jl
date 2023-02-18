"""
    Return(price::TSFrame, period::Int=1)
    
Calculates `returns` form asset `prices`

# Arguments:
 * `price::TSFrame`: column(s) of TSFrame object of asset prices
 * `period::Int=1`: return period


# Examples
```julia
 julia> Return(prices_ts)
 12×3 TSFrame with Date Index
 Index       TSLA        NFLX        MSFT        
 Date        Float64?    Float64?    Float64?    
─────────────────────────────────────────────────
 2022-01-31  -0.113609   -0.290983   -0.0753449
 2022-02-28  -0.0707789  -0.0763684  -0.0391987
 2022-03-31   0.238023   -0.0505171   0.0318618
 2022-04-30  -0.191954   -0.491818   -0.099867
 2022-05-31  -0.129199    0.0371927  -0.0203589
 2022-06-30  -0.111889   -0.114313   -0.0553206
 2022-07-31   0.323785    0.286098    0.0930966
 2022-08-31  -0.0724886  -0.0059582  -0.06864
 2022-09-30  -0.0375893   0.0531401  -0.109267
 2022-10-31  -0.142168    0.239721   -0.00330614
 2022-11-30  -0.144326    0.0467658   0.0991255
 2022-12-31  -0.374319   -0.0471639  -0.0553814
```

# Notes:
 * `missing` resulting from the function is automatically removed
 * `Return()` does not calculate the portfolio return. Portfolio return is calcuated by `PortfolioReturn()` function.
"""
function Return(price::TSFrame, period::Int=1)

    return TSFrames.pctchange(price, period)[(period+1):end]

end

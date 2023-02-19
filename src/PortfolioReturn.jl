"""
    PortfolioReturn(price::TSFrame, weights::Vector{<:Number}; period::Int=1, colname::String="PRETURN")

Calculates `portfolio return` from `asset prices` and given `weights`.

# Arguments:
 * `price::TSFrame`: column(s) of TSFrame object of asset prices
 * `weights::Vector{<:Number}`: weights of assets
 * `period::Int=1`: return period
 * `colname::String="PRETURN"`: name of the column of portfolio return

# Example
```julia
julia> preturns = PortfolioReturn(prices_ts, weights)
12×1 TSFrame with Date Index
 Index       PRETURN    
 Date        Float64?   
────────────────────────
 2022-01-31  -0.176906
 2022-02-28  -0.0666986
 2022-03-31   0.0813747
 2022-04-30  -0.293482
 2022-05-31  -0.0408743
 2022-06-30  -0.101545
 2022-07-31   0.262573
 2022-08-31  -0.0451067
 2022-09-30  -0.0156331
 2022-10-31   0.0383602
 2022-11-30  -0.0191991
 2022-12-31  -0.17967
```

# Notes:
 * `missing` resulting from the function is automatically removed.
"""
function PortfolioReturn(price::TSFrame, weights::Vector{<:Number}; period::Int=1, colname::String="PRETURN")
    
    preturns = Matrix(TSFrames.pctchange(price, period)) * weights

    ts = TSFrame(preturns, TSFrames.index(price))[(period+1):end]
    TSFrames.rename!(ts, [colname])
    
    return ts

end

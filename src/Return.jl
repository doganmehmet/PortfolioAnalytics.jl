"""
    Return(price::TSFrame, period::Int=1; method::String="simple")
    
Calculates `returns` form `asset prices`.

# Arguments:
 * `price::TSFrame`: column(s) of TSFrame object of asset prices
 * `period::Int=1`: return period
 * `method::String="simple"`: return method, available methods; `"simple"` and `"log"`


# Example
```julia
julia> returns = Return(prices_ts)
12×3 TSFrame with Date Index
 Index       TSLA        NFLX        MSFT        
 Date        Float64?    Float64?    Float64?    
─────────────────────────────────────────────────
 2021-01-31   0.124522   -0.0154236   0.0428918
 2021-02-28  -0.148766    0.012134    0.00181066
 2021-03-31  -0.011192   -0.0319013   0.0145882
 2021-04-30   0.0621631  -0.0156999   0.0696017
 2021-05-31  -0.118742   -0.0207607  -0.00991355
 2021-06-30   0.0871401   0.0505161   0.0849888
 2021-07-31   0.0110346  -0.0201435   0.0517165
 2021-08-31   0.0706365   0.0997353   0.0595627
 2021-09-30   0.0540287   0.0722957  -0.066119
 2021-10-31   0.436535    0.131025    0.176291
 2021-11-30   0.0276035  -0.0701279  -0.00310596
 2021-12-31  -0.0768384  -0.0614737   0.0173326


 julia> log_returns = Return(prices_ts, method = "log")
12×3 TSFrame with Date Index
 Index       TSLA        NFLX        MSFT        
 Date        Float64?    Float64?    Float64?    
─────────────────────────────────────────────────
 2021-01-31   0.117358   -0.0155438   0.0419975
 2021-02-28  -0.161068    0.0120609   0.00180902
 2021-03-31  -0.0112551  -0.0324212   0.0144828
 2021-04-30   0.0603075  -0.0158244   0.0672864
 2021-05-31  -0.126404   -0.0209792  -0.00996302
 2021-06-30   0.0835505   0.0492816   0.0815697
 2021-07-31   0.0109742  -0.0203492   0.0504236
 2021-08-31   0.0682533   0.0950695   0.0578562
 2021-09-30   0.0526197   0.0698019  -0.0684062
 2021-10-31   0.362234    0.123125    0.162366
 2021-11-30   0.0272294  -0.0727082  -0.0031108
 2021-12-31  -0.079951   -0.0634445   0.0171842
```

# Notes:
 * `missing` resulting from the function is automatically removed
"""
function Return(price::TSFrame, period::Int=1; method::String="simple")

    if period <= 0
        throw(ArgumentError("period must be a positive int"))
    end

    if method == "simple"
        return TSFrames.pctchange(price, period)[(period+1):end]
    elseif method == "log"
        returns = log.(price.coredata[:,2:end] ./ TSFrames.lag(price, period).coredata[:,2:end])
        ts = TSFrame(returns, TSFrames.index(price))[(period+1):end]
        return ts
    else
        throw(ArgumentError("one of the available method must be chosen"))
    end

end
"""
    drawdowns(R::TSFrame; geometric::Bool=true, max_drawdown::Bool=false)

Calculates the drawdowns of asset or portfolio returns. Output is a TSFrame object of drawdowns. 

# Arguments:
 * `R::TSFrame`: column(s) of TSFrame object of asset returns
 * `geometric::Bool=true`: if true, calculates drawdowns from the geometric returns
 * `max_drawdown::Bool=false`: if true, returns maximum drawdown for asset(s) or a portfolio

# Example
```julia
julia> drawdowns(returns)
12×3 TSFrame with Date Index
 Index       TSLA        NFLX        MSFT        
 Date        Float64     Float64     Float64     
─────────────────────────────────────────────────
 2021-01-31   0.0         0.0         0.0
 2021-02-28  -0.148766    0.0         0.0
 2021-03-31  -0.158293   -0.0319013   0.0
 2021-04-30  -0.10597    -0.0471003   0.0
 2021-05-31  -0.212128   -0.0668832  -0.00991355
 2021-06-30  -0.143473   -0.0197458   0.0
 2021-07-31  -0.134021   -0.0394915   0.0
 2021-08-31  -0.0728517   0.0         0.0
 2021-09-30  -0.0227591   0.0        -0.066119
 2021-10-31   0.0         0.0         0.0
 2021-11-30   0.0        -0.0701279  -0.00310596
 2021-12-31  -0.0768384  -0.127291    0.0

julia> drawdowns(returns, geometric=false)
12×3 TSFrame with Date Index
 Index       TSLA        NFLX         MSFT        
 Date        Float64     Float64      Float64     
──────────────────────────────────────────────────
 2021-01-31   0.0        -0.0154236    0.0
 2021-02-28  -0.132292   -0.00328963   0.0
 2021-03-31  -0.142245   -0.0351909    0.0
 2021-04-30  -0.0869655  -0.0508908    0.0
 2021-05-31  -0.192558   -0.0716515   -0.00878166
 2021-06-30  -0.115068   -0.0211354    0.0
 2021-07-31  -0.105255   -0.0412789    0.0
 2021-08-31  -0.0424401   0.0          0.0
 2021-09-30   0.0         0.0         -0.0502712
 2021-10-31   0.0         0.0          0.0
 2021-11-30   0.0        -0.0555787   -0.00217898
 2021-12-31  -0.0481756  -0.104299     0.0

julia> drawdowns(returns,  max_drawdown=true)
3-element Named Vector{Float64}
Maximum Drawdown  │
──────────────────┼──────────
TSLA              │ -0.212128
NFLX              │ -0.127291
MSFT              │ -0.066119


julia> drawdowns(returns, geometric=false, max_drawdown=true)
3-element Named Vector{Float64}
Maximum Drawdown  │
──────────────────┼───────────
TSLA              │  -0.192558
NFLX              │  -0.104299
MSFT              │ -0.0502712
```
"""
function drawdowns(R::TSFrame; geometric::Bool=true, max_drawdown::Bool=false)

    colnames = names(R)
    idx = TSFrames.index(R)

    R = Matrix(R)

    if geometric == true
        R1 = R + ones(size(R))
        Rprod = cumprod(R1, dims = 1)
        maxCumulativeReturns = accumulate(max, Rprod, dims = 1)
        ddowns = (Rprod ./ maxCumulativeReturns) .- 1

    else
        cumulativeSum = cumsum(R, dims = 1)
        R1 = cumulativeSum + ones(size(R))
        first_row = ones(1, size(R)[2])
        maxCumulativeReturns = accumulate(max, vcat(first_row, R1), dims = 1)[2:end, :]
        ddowns = (R1 ./ maxCumulativeReturns) .- 1
    
    end

    if max_drawdown == true
        max_ddowns = minimum(ddowns, dims=1)
        return NamedArray(vec(max_ddowns), colnames, "Maximum Drawdown")
    else
        ts = TSFrame(ddowns, idx)
        TSFrames.rename!(ts, colnames)
        return ts
    end
    
    
end

# PortfolioAnalytics.jl

[![Build Status](https://github.com/doganmehmet/PortfolioAnalytics.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/doganmehmet/PortfolioAnalytics.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://doganmehmet.github.io/PortfolioAnalytics.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://doganmehmet.github.io/PortfolioAnalytics.jl/dev)

## Tool for Quantitative Portfolio Analytics

The **PortfolioAnalytics.jl** aims to provide users with functionality for performing quantitative portfolio analytics. The package is under heavy development, and new functionalities will be added as part of ongoing releases.

### Getting started
Read the [documentation](https://doganmehmet.github.io/PortfolioAnalytics.jl/dev/) to get started with **PortfolioAnalytics.jl**.

The following functions are available in the stable version:
* Return( )
* portfolio_return( )
* sharpe( )
* VaR( )
* portfolio_optimize( )
* mean_return( )
* stddev( )
* moments( )
* es( )

### Contributions are most welcome
We greatly value contributions of any kind. Contributions could include but are not limited to documentation improvements, bug reports, new or improved code, scientific and technical code reviews, infrastructure improvements, mailing lists, chat participation, community help/building, education, and outreach.

### Bug reports
Please report any issues via the GitHub issue tracker. All kinds of issues are welcome and encouraged; this includes bug reports, documentation typos, feature requests, etc.

### Acknowledgement
The package is inspired by *PerformanceAnalytics* and *PortfolioAnalytics* packages in R and *pyfolio* in Python.

### Release notes
Please read the release notes for more information on releases.

## User Guide
The package is under development, and the dev version may differ from the stable version.

### Installing PortfolioAnalytics
#### Development version
```julia
julia> using Pkg
julia> Pkg.add(url="https://github.com/doganmehmet/PortfolioAnalytics.jl")
```
#### Stable version
```julia
julia> using Pkg
julia> Pkg.add("PortfolioAnalytics")
```

#### Update the currently installed version
```julia
julia> using Pkg
julia> Pkg.update("PortfolioAnalytics")
```

### Examples
```julia
using PortfolioAnalytics
using Dates
using TSFrames

dates = Date(2020, 12, 31):Month(1):Date(2021, 12, 31)
TSLA = [235.22,264.51,225.16,222.64,236.48,208.40,226.56,229.06,245.24,258.49,371.33,381.58,352.26]
NFLX = [540.73,532.39,538.85,521.66,513.47,502.81,528.21,517.57,569.19,610.34,690.31,641.90,602.44]
MSFT = [222.42,231.96,232.38,235.77,252.18,249.68,270.90,284.91,301.88,281.92,331.62,330.59,336.32]

prices_ts = TSFrame([TSLA NFLX MSFT], dates, colnames=[:TSLA, :NFLX, :MSFT])

13×3 TSFrame with Date Index
 Index       TSLA     NFLX     MSFT    
 Date        Float64  Float64  Float64 
───────────────────────────────────────
 2020-12-31   235.22   540.73   222.42 
 2021-01-31   264.51   532.39   231.96 
 2021-02-28   225.16   538.85   232.38 
 2021-03-31   222.64   521.66   235.77 
 2021-04-30   236.48   513.47   252.18 
 2021-05-31   208.4    502.81   249.68 
 2021-06-30   226.56   528.21   270.9  
 2021-07-31   229.06   517.57   284.91 
 2021-08-31   245.24   569.19   301.88 
 2021-09-30   258.49   610.34   281.92 
 2021-10-31   371.33   690.31   331.62
 2021-11-30   381.58   641.9    330.59
 2021-12-31   352.26   602.44   336.32

weights = [0.4, 0.4, 0.2]
3-element Vector{Float64}:
 0.4
 0.4
 0.2
```

### Return( )
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

### portfolio_return( )
```julia
julia> preturns = portfolio_return(prices_ts, weights)
12×1 TSFrame with Date Index
 Index       PORT        
 Date        Float64?    
─────────────────────────
 2021-01-31   0.0522176
 2021-02-28  -0.0542905
 2021-03-31  -0.0143197
 2021-04-30   0.0325056
 2021-05-31  -0.0577836
 2021-06-30   0.0720602
 2021-07-31   0.00669974
 2021-08-31   0.0800613
 2021-09-30   0.037306
 2021-10-31   0.262282
 2021-11-30  -0.017631
 2021-12-31  -0.0518583

 julia> log_preturns = portfolio_return(prices_ts, weights, method = "log")
 12×1 TSFrame with Date Index
  Index       PORT        
  Date        Float64?    
 ─────────────────────────
  2021-01-31   0.0491251
  2021-02-28  -0.0592409
  2021-03-31  -0.014574
  2021-04-30   0.0312505
  2021-05-31  -0.060946
  2021-06-30   0.0694468
  2021-07-31   0.00633473
  2021-08-31   0.0769004
  2021-09-30   0.0352874
  2021-10-31   0.226617
  2021-11-30  -0.0188137
  2021-12-31  -0.0539213
```

You can join TSFrame objects with ***join( )*** function from *TSFrames* package.
```julia
julia> all_returns = TSFrames.join(returns, preturns)
12×4 TSFrame with Date Index
 Index       TSLA        NFLX        MSFT         PORT        
 Date        Float64?    Float64?    Float64?     Float64?    
──────────────────────────────────────────────────────────────
 2021-01-31   0.124522   -0.0154236   0.0428918    0.0522176
 2021-02-28  -0.148766    0.012134    0.00181066  -0.0542905
 2021-03-31  -0.011192   -0.0319013   0.0145882   -0.0143197
 2021-04-30   0.0621631  -0.0156999   0.0696017    0.0325056
 2021-05-31  -0.118742   -0.0207607  -0.00991355  -0.0577836
 2021-06-30   0.0871401   0.0505161   0.0849888    0.0720602
 2021-07-31   0.0110346  -0.0201435   0.0517165    0.00669974
 2021-08-31   0.0706365   0.0997353   0.0595627    0.0800613
 2021-09-30   0.0540287   0.0722957  -0.066119     0.037306
 2021-10-31   0.436535    0.131025    0.176291     0.262282
 2021-11-30   0.0276035  -0.0701279  -0.00310596  -0.017631
 2021-12-31  -0.0768384  -0.0614737   0.0173326   -0.0518583
```

### sharpe( )
```julia
julia> sharpe = sharpe(all_returns)
4-element Named Vector{Float64}
Sharpe Ratio (Rf=0)  │
─────────────────────┼─────────
TSLA                 │ 0.288602
NFLX                 │ 0.170242
MSFT                 │ 0.606824
PORT                 │ 0.329079
```

### mean_return( )
```julia
julia> mreturn = mean_return(all_returns)
4-element Named Vector{Float64}
μ    │
─────┼──────────
TSLA │ 0.0431772
NFLX │  0.010848
MSFT │ 0.0366371
PORT │ 0.0289375


julia> mean_return(all_returns, geometric=true)
4-element Named Vector{Float64}
μ    │
─────┼───────────
TSLA │  0.0342267
NFLX │ 0.00904634
MSFT │  0.0350585
PORT │  0.0257348
```

### stddev( )
```julia
julia> stddev(all_returns)
4-element Named Vector{Float64}
σ    │
─────┼──────────
TSLA │  0.149608
NFLX │ 0.0637211
MSFT │ 0.0603753
PORT │ 0.0879347
```

### moments( )
```julia
julia> pmoments = moments(all_returns)
4×4 Named Matrix{Float64}
Tickers ╲ Moments │      Mean        Std   Skewness   Kurtosis
──────────────────┼───────────────────────────────────────────
TSLA              │ 0.0431772   0.149608    1.36882    2.19682
NFLX              │  0.010848  0.0637211   0.604374  -0.808401
MSFT              │ 0.0366371  0.0603753   0.681468   0.790701
PORT              │ 0.0289375  0.0879347    1.53379    2.19321
```

### VaR( )
```julia
julia> var_historical = VaR(all_returns)
4-element Named Vector{Float64}
95% historical VaR  │
────────────────────┼───────────
TSLA                │  -0.132252
NFLX                │ -0.0653681
MSFT                │  -0.035206
PORT                │ -0.0558624


julia> var_parametric = VaR(all_returns, 0.90, method = "parametric")
4-element Named Vector{Float64}
90% parametric VaR  │
────────────────────┼───────────
TSLA                │  -0.148553
NFLX                │ -0.0708139
MSFT                │ -0.0407369
PORT                │ -0.0837553
```

### es( )
```julia
julia> ES = es(all_returns)
4-element Named Vector{Any}
95% historical ES  │
───────────────────┼───────────
TSLA               │  -0.148766
NFLX               │ -0.0701279
MSFT               │  -0.066119
PORT               │ -0.0577836
```

### portfolio_optimize( )
```julia
julia> opt1 = portfolio_optimize(returns, "minumum variance")

julia> opt_weights = opt1.pweights
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────
TSLA             │   -0.0
NFLX             │ 0.4438
MSFT             │ 0.5562

# plotting efficient frontier and decision space
julia> opt1.plt

# Optimize minumum-variance portfolio with a minumum return target of 4%
julia> opt2 = portfolio_optimize(returns, "minumum variance", target = 0.04)

# optimal portfolio weights for a chosen objective and target return
julia> opt2.pweights
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────
TSLA             │ 0.5142
NFLX             │    0.0
MSFT             │ 0.4858

# Maximum-Sharpe portfolios
julia> opt3 = portfolio_optimize(returns, "maximum sharpe")

# Optimal weights for maximum-sharpe portfolio 
julia> opt3.pweights
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼─────
TSLA             │ -0.0
NFLX             │  0.0
MSFT             │  1.0

# Plot the efficient frontier and decision space
julia> opt3.plt
```
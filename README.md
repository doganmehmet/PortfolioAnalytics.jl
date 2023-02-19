# PortfolioAnalytics.jl

[![Build Status](https://github.com/doganmehmet/PortfolioAnalytics.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/doganmehmet/PortfolioAnalytics.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Tool for Quantitative Portfolio Analytics

Inspired by *PerformanceAnalytics* and *PortoflioAnalytics* packages in R, ***PortfolioAnalytics.jl*** aims to provide users with functionality for performing portfolio analytics.

### Documentation
Vist the PortfolioAnalytics.jl [user guide](https://doganmehmet.github.io/PortfolioAnalytics.jl/dev/guide.html#Installation) for more examples and functionality.


### Installing PortfolioAnalytics
#### Development version (Suggested)
```julia
julia> using Pkg
julia> Pkg.add(url="https://github.com/doganmehmet/PortfolioAnalytics.jl")
```
#### Stable version
```julia
julia> using Pkg
julia> Pkg.add("PortfolioAnalytics")
```

#### Update version
```julia
julia> using Pkg
julia> Pkg.update("PortfolioAnalytics")
```

PortfolioAnalytics.jl is minimal now, but it is **under heavy development**. 

The following functions are available in stable version:
* Return()
* PortfolioReturn()
* SharpeRatio()
* VaR()
* PortfolioOptimize()

Additonal functions available in dev version:
* MeanReturns()
* Moments()
* ExpectedShortfall() - available soon

### Known issues
These are just a few examples of known issues with functions in the package. These issues will be fixed in the next release.
* **All Functions:**
    * Types (e.g., TSFrame, Vector{Float64}) still need to be specified. This hasn't been done on purpose. The best candidate looks TSFrame but I'm still open to suggestions. Nevertheless, **the types of parameters to be passed to the functions will be set in the next release.** - adressed in dev version
* PortfolioReturn()
    * It returns a vector instead of a proper object with dates. This issue is connected to #1 (All Functions) and **will be fixed in the next release.** - fixed in dev version
* Sharpe Ratio()
    * Does not work in presense of NAs or missing vlaues. **Will be fixed in the next release.**
    * Needs to be passed single column only. if multiple columns are passed it will be calculaing one single SharpeRatio which is wrong. **Will be fixed in the next release.**  - fixed in dev version
* VaR()
    * It cannot run on multiple columns. **Will be fixed in the next release.**  - fixed in dev version
    * Does not work in presense of NAs or missing vlaues. **Will be fixed in the next release.**
* PortfolioOptimize()
    * Doesn't work in presense of NAs or missing values. **Will be fixed in the next release.**

### TO DO
New functionalities will also be added to the existing functions.
* Return()
    * ***period*** parameter to be added for multi-period returns - available in dev version
* PortfolioReturn()
    * ***Rebalancing*** parameter will be added
    * ***period*** parameter will be added for multi-period returns - available in dev version
* VaR()
    * ***VaR with Monte Carlo*** to be added
* PortfolioOptimize()
    * ***Maximization by SharpeRatio*** will be added
    * ***Custom constraints*** functionality will be included.
    * ***NamedArray*** to be added for weights. - available in dev version


### Contributions are most welcome
We greatly value contributions of any kind. Contributions could include but are not limited to documentation improvements, bug reports, new or improved code, scientific and technical code reviews, infrastructure improvements, mailing lists, chat participation, community help/building, education, and outreach.


### Bug reports
Please report any issues via the GitHub issue tracker. All kinds of issues are welcome and encouraged; this includes bug reports, documentation typos, feature requests, etc.

## User Guide
This guide refers to development version. Installation of the dev version is suggested.


```julia
using PortfolioAnalytics
using Dates
using TSFrames

dates = Date(2021, 12, 31):Month(1):Date(2022, 12, 31)
TSLA = [352.26,312.24,290.14,359.2,290.25,252.75,224.47,297.15,275.61,265.25,227.54,194.7,121.82]
NFLX = [602.44,427.14,394.52,374.59,190.36,197.44,174.87,224.9,223.56,235.44,291.88,305.53,291.12]
MSFT = [336.32,310.98,298.79,308.31,277.52,271.87,256.83,280.74,261.47,232.9,232.13,255.14,241.01]

prices_ts = TSFrame([TSLA NFLX MSFT], dates, colnames=[:TSLA, :NFLX, :MSFT])

13×3 TSFrame with Date Index
 Index       TSLA     NFLX     MSFT    
 Date        Float64  Float64  Float64 
───────────────────────────────────────
 2021-12-31   352.26   602.44   336.32 
 2022-01-31   312.24   427.14   310.98 
 2022-02-28   290.14   394.52   298.79 
 2022-03-31   359.2    374.59   308.31 
 2022-04-30   290.25   190.36   277.52 
 2022-05-31   252.75   197.44   271.87 
 2022-06-30   224.47   174.87   256.83
 2022-07-31   297.15   224.9    280.74
 2022-08-31   275.61   223.56   261.47
 2022-09-30   265.25   235.44   232.9
 2022-10-31   227.54   291.88   232.13
 2022-11-30   194.7    305.53   255.14
 2022-12-31   121.82   291.12   241.01

weights = [0.4, 0.4, 0.2]
3-element Vector{Float64}:
 0.4
 0.4
 0.2
```

### Return()
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

### PortfolioReturn()
```julia
julia> preturns = PortfolioReturn(prices_ts, weights)
12×1 TSFrame with Date Index
 Index       preturn    
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

You can join TSFrame objects with ***join()*** function from TSFrames package.
```julia
julia> all_returns = TSFrames.join(returns, preturns)
12×4 TSFrame with Date Index
 Index       TSLA        NFLX        MSFT         PRETURN    
 Date        Float64?    Float64?    Float64?     Float64?   
─────────────────────────────────────────────────────────────
 2022-01-31  -0.113609   -0.290983   -0.0753449   -0.176906
 2022-02-28  -0.0707789  -0.0763684  -0.0391987   -0.0666986
 2022-03-31   0.238023   -0.0505171   0.0318618    0.0813747
 2022-04-30  -0.191954   -0.491818   -0.099867    -0.293482
 2022-05-31  -0.129199    0.0371927  -0.0203589   -0.0408743
 2022-06-30  -0.111889   -0.114313   -0.0553206   -0.101545
 2022-07-31   0.323785    0.286098    0.0930966    0.262573
 2022-08-31  -0.0724886  -0.0059582  -0.06864     -0.0451067
 2022-09-30  -0.0375893   0.0531401  -0.109267    -0.0156331
 2022-10-31  -0.142168    0.239721   -0.00330614   0.0383602
 2022-11-30  -0.144326    0.0467658   0.0991255   -0.0191991
 2022-12-31  -0.374319   -0.0471639  -0.0553814   -0.17967
```

### SharpeRatio()
```julia
ulia> sharpe = SharpeRatio(all_returns)
4-element Named Vector{Float64}
Sharpe  │ 
────────┼──────────
TSLA    │ -0.372359
NFLX    │ -0.164948
MSFT    │  -0.36582
PRETURN │  -0.32811
```

### MeanReturn()
```julia
julia> mreturn = MeanReturn(all_returns)
4-element Named Vector{Float64}
Mean Return  │
─────────────┼───────────
TSLA         │ -0.0688762
NFLX         │  -0.034517
MSFT         │ -0.0252167
PRETURN      │ -0.0464006
```

```julia
julia> using Plots
# plotting mean return of stocks and portfolio
julia> bar(names(mreturn), mreturn, labels = false)
```

### Moments()
```julia
julia> pmoments = Moments(all_returns)
4×4 Named Matrix{Float64}
Rows ╲ Cols │       TSLA        NFLX        MSFT     PRETURN
────────────┼───────────────────────────────────────────────
Mean        │ -0.0688762   -0.034517  -0.0252167  -0.0464006
Std         │   0.184973    0.209259    0.068932    0.141418
Skewness    │   0.868756   -0.600014    0.724772    0.415989
Kurtosis    │   0.529269    0.333629   -0.635292    0.415647
```

### VaR()
```julia
julia> var_historical = VaR(all_returns)
4-element Named Vector{Float64}
95% VaR  │ 
─────────┼──────────
TSLA     │ -0.274019
NFLX     │ -0.381359
MSFT     │ -0.104097
PRETURN  │ -0.230885

julia> var_parametric = VaR(all_returns, p = 0.90, method = "parametric")
4-element Named Vector{Float64}
90% VaR  │
─────────┼──────────
TSLA     │ -0.305928
NFLX     │ -0.302693
MSFT     │ -0.113557
PRETURN  │ -0.227635
```

### PortfolioOptimize()
```julia
julia> opt = PortfolioOptimize(returns)

EXIT: Optimal Solution Found.
(preturn = -0.025216712326596998, pvar = 0.06893199595428622, pweights = 3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────────
TSLA             │ 1.46169e-7
NFLX             │ 5.31995e-8
MSFT             │        1.0)

julia> portreturn = opt.preturn # or opt[1]
-0.025216712326596998

julia> portvar = opt.pvar # or opt[2]
0.06893199595428622

julia> portweights = opt.pweights # or opt[3]
3-element Named Vector{Float64}
Optimal Weights  │
─────────────────┼───────────
TSLA             │ 1.46169e-7
NFLX             │ 5.31995e-8
MSFT             │        1.0
```

```julia
julia> using Plots
# plotting optimal weights for minumum variance portfolio
julia> bar(names(portweights), portweights, labels = false)
```
# PortfolioAnalytics.jl

[![Build Status](https://github.com/doganmehmet/PortfolioAnalytics.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/doganmehmet/PortfolioAnalytics.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Tool for Quantitative Portfolio Analytics

Inspired by *PerformanceAnalytics* and *PortoflioAnalytics* packages in R, ***PortfolioAnalytics.jl*** aims to provide users with functionality for performing portfolio analytics.

### Installing PortfolioAnalytics
```julia
julia> using Pkg
julia> Pkg.add("PortfolioAnalytics")
```

PortfolioAnalytics.jl is minimal now, but it is under heavy development. 

The following functions are available:
* Return()
* PortfolioReturn()
* SharpeRatio()
* VaR()
* PortfolioOptimize()

**On the pipe:**
* ExpectedShortfall()

### Known issues
These are just a few examples of known issues with functions in the package. These issues will be fixed in the next release.

* Sharpe Ratio()
    * Does not work in presense of NAs or missing vlaues. **Will be fixed in the next release.**
    * Needs to be passed single column only. if multiple columns are passed it will be calculaing one single SharpeRatio which is wrong. **Will be fixed in the next release.**
* VaR()
    * It cannot run on multiple columns. **Will be fixed in the next release.**
    * Does not work in presense of NAs or missing vlaues. **Will be fixed in the next release.**
* PortfolioOptimize()
    * Doesn't work in presense of NAs or missing values. **Will be fixed in the next release.**

### TO DO
New functionalities will also be added to the existing functions.
* PortfolioReturn()
    * ***Rebalancing*** will be added
* VaR()
    * ***VaR with Monte Carlo*** to be added
* PortfolioOptimize()
    * ***Maximization by SharpeRatio*** will be added
    * ***Custom constraints*** functionality will be included.
    * ***NamedArray*** to be added for weights.



### Contributions are most welcome
We greatly value contributions of any kind. Contributions could include but are not limited to documentation improvements, bug reports, new or improved code, scientific and technical code reviews, infrastructure improvements, mailing lists, chat participation, community help/building, education, and outreach.


### Bug reports
Please report any issues via the GitHub issue tracker. All kinds of issues are welcome and encouraged; this includes bug reports, documentation typos, feature requests, etc.

### Usage
Proper documentation is under development. Until it is ready, "Usage" will be displayed here.

```julia
julia> using DataFrames

julia> date = ["2021-12-31","2022-01-31","2022-02-28","2022-03-31","2022-04-30","2022-05-31","2022-06-30","2022-07-31","2022-08-31","2022-09-30","2022-10-31","2022-11-30","2022-12-31"]
julia> TSLA = [352.26,312.24,290.14,359.2,290.25,252.75,224.47,297.15,275.61,265.25,227.54,194.7,121.82]
julia> NFLX = [602.44,427.14,394.52,374.59,190.36,197.44,174.87,224.9,223.56,235.44,291.88,305.53,291.12]
julia> MSFT = [336.32,310.98,298.79,308.31,277.52,271.87,256.83,280.74,261.47,232.9,232.13,255.14,241.01]

julia> prices = DataFrame(date = date, TSLA = TSLA, NFLX = NFLX, MSFT = MSFT)
julia> prices.date = Date.(prices.date, "yyyy-mm-dd")
```

```julia
julia> using TSFrames

julia> prices_ts = TSFrame(prices)
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

```

#### Return()
```julia
julia> returns = Return(prices_ts)
13×3 TSFrame with Date Index
 Index       TSLA             NFLX             MSFT
 Date        Float64?         Float64?         Float64?
────────────────────────────────────────────────────────────────
 2021-12-31  missing          missing          missing
 2022-01-31       -0.113609        -0.290983        -0.0753449
 2022-02-28       -0.0707789       -0.0763684       -0.0391987
 2022-03-31        0.238023        -0.0505171        0.0318618
 2022-04-30       -0.191954        -0.491818        -0.099867
 2022-05-31       -0.129199         0.0371927       -0.0203589
 2022-06-30       -0.111889        -0.114313        -0.0553206
 2022-07-31        0.323785         0.286098         0.0930966
 2022-08-31       -0.0724886       -0.0059582       -0.06864
 2022-09-30       -0.0375893        0.0531401       -0.109267
 2022-10-31       -0.142168         0.239721        -0.00330614
 2022-11-30       -0.144326         0.0467658        0.0991255
 2022-12-31       -0.374319        -0.0471639       -0.0553814

```

#### PortfolioReturn()
```julia
julia> preturns = PortfolioReturn(prices_ts, [0.4, 0.4, 0.2])
13-element Vector{Union{Missing, Float64}}:
   missing
 -0.17690602205121858
 -0.0666986491934299
  0.08137474427977387
 -0.29348222886964276
 -0.040874290158098486
 -0.10154508259254014
  0.262572584168498
 -0.0451067428577845
 -0.015633067758222274
  0.03836021460141191
 -0.019199093251286613
 -0.17966963603703354
```

#### SharpeRatio()
```julia
julia> preturns_ts = TSFrame(preturns[2:end]) # transfering it to TSFrame otherwise SharpeRatio does not work. it will be fixed in the next release
12×1 TSFrame with Int64 Index
 Index  x1
 Int64  Float64?
───────────────────
     1  -0.176906
     2  -0.0666986
     3   0.0813747
     4  -0.293482
     5  -0.0408743
     6  -0.101545
     7   0.262573
     8  -0.0451067
     9  -0.0156331
    10   0.0383602
    11  -0.0191991
    12  -0.17967

julia> SharpeRatio(preturns_ts)
-0.3281102588233226
```


#### Var()
```julia
"""
Arguments:
    - R: a vector, column of TSFrame, or column of DataFrame object of asset returns
    - p: confidence interval
    - method: default = "historical", available methods: "historical" and "parametric" 
"""

# historical
julia> VaR(preturns_ts[:,1], 0.95, "historical")
-0.23088530281170763

# parametric
julia> VaR(preturns_ts[:,1], 0.95, "parametric")
-0.27901206097437814
```

#### PortfolioOptimize()
```julia

"""
Arguments:
    R: columns of TSFrame, or columns of DataFrame object of asset returns

Output:
    - is a 3-element tupple
        - first element is portfolio mean return
        - second is portfolio variance
        - third is optimal weights
"""

julia> PortfolioOptimize(returns[2:13])

EXIT: Optimal Solution Found.
(-0.025216712326596998, 0.06893199595428622, [1.4616864319901446e-7, 5.319947696629003e-8, 0.9999998006318798])
```

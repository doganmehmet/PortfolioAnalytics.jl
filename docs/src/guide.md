# Guide

## Installation

#### Development version (Suggested)
```julia
julia> using Pkg
Pkg.add(url="https://github.com/doganmehmet/PortfolioAnalytics.jl")
```

#### Stable version
```julia
julia> using Pkg
julia> Pkg.add("PortfolioAnalytics")
```

**Caution:** The package is under heavy development, and this documentation refers to the development verison. Development version will significantly differ from the current stable version. Installation of the dev version is suggested.

## Functions

```@index
```

```julia
using PortfolioAnalytics
using Dates
using TSFrames

dates = Date(2021, 12, 31):Month(1):Date(2022, 12, 31)
TSLA = [352.26,312.24,290.14,359.2,290.25,252.75,224.47,297.15,275.61,265.25,227.54,194.7,121.82]
NFLX = [602.44,427.14,394.52,374.59,190.36,197.44,174.87,224.9,223.56,235.44,291.88,305.53,291.12]
MSFT = [336.32,310.98,298.79,308.31,277.52,271.87,256.83,280.74,261.47,232.9,232.13,255.14,241.01]

prices_ts = TSFrame([TSLA NFLX MSFT], dates, colnames=[:TSLA, :NFLX, :MSFT])

weights = [0.4, 0.4, 0.2]

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

```@docs
Return
```

```@docs
PortfolioReturn
```

```julia
julia> all_returns = TSFrames.join(returns, preturns)
12×4 TSFrame with Date Index
 Index       TSLA        NFLX        MSFT         preturn    
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

```@docs
SharpeRatio
```

```@docs
MeanReturn
```

```julia
julia> using Plots
# plotting mean return of stocks and portfolio
julia> bar(names(mreturn), mreturn, labels = false)
```

```@docs
Moments
```

```@docs
VaR
```

```@docs
PortfolioOptimize
```

```julia
julia> using Plots
# plotting optimal weights for minumum variance portfolio
julia> bar(names(portweights), portweights, labels = false)
```
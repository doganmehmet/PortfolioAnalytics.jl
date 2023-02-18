# Introduction

### Tool for Quantitative Portfolio Analytics

Inspired by *PerformanceAnalytics* and *PortoflioAnalytics* packages in R, *pyfolio* in Python, **PortfolioAnalytics.jl** aims to provide users with functionality for performing portfolio analytics.

PortfolioAnalytics.jl is minimal now, but it is **under heavy development**. 

The following functions are available:
* Return()
* PortfolioReturn()
* SharpeRatio()
* VaR()
* PortfolioOptimize()

**On the pipe:**
* MeanReturns()
* Moments()
* ExpectedShortfall()

### Known issues
These are just a few examples of known issues with functions in the package. These issues will be fixed in the next release.
* **All Functions:**
    * Types (e.g., TSFrame, Vector{Float64}) still need to be specified. This hasn't been done on purpose. The best candidate looks TSFrame but I'm still open to suggestions. Nevertheless, **the types of parameters to be passed to the functions will be set in the next release.**
* PortfolioReturn()
    * It returns a vector instead of a proper object with dates. This issue is connected to #1 (All Functions) and **will be fixed in the next release.**
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
* Return()
    * ***period*** parameter to be added for multi-period returns
* PortfolioReturn()
    * ***Rebalancing*** parameter will be added
    * ***period*** parameter will be added for multi-period returns
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


# User Guide

## Installation

```julia
julia> using Pkg
julia> Pkg.add("PortfolioAnalytics")
```

```@autodocs
Modules = [PortfolioAnalytics]
```
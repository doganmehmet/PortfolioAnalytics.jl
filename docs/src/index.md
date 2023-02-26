# PortfolioAnalytics.jl

### Tool for Quantitative Portfolio Analytics

The **PortfolioAnalytics.jl** aims to provide users with functionality for performing quantitative portfolio analytics. The package is under heavy development, and new functionalities will be added as part of ongoing releases.

The following functions are available in stable version:
* Return( )
* PortfolioReturn( )
* SharpeRatio( )
* VaR( )
* PortfolioOptimize( )
* MeanReturns( )
* StdDev( )
* Moments( )
* ExpectedShortfall( )

This package generally requires return (rather than price) data. Almost all functions will work with any periodicity, from annual, monthly, daily, to even minutes and seconds, either regular or irregular.

### Getting started
* The best place to get started with **PortfolioAnalytics** is the [Tutorials](@ref) section, where you can find the demonstration of functions' use.
* Go to the [Installation](@ref) guide to learn how you can install *PortfolioAnalytics*.
* Read the [Functions](@ref) section to learn more about functions' parameters and default arguments.


### Contributions are most welcome
We greatly value contributions of any kind. Contributions could include but are not limited to documentation improvements, bug reports, new or improved code, scientific and technical code reviews, infrastructure improvements, mailing lists, chat participation, community help/building, education, and outreach.


### Bug reports and feature requests
Please report any issues via the GitHub issue tracker. All kinds of issues are welcome and encouraged; this includes bug reports, documentation typos, feature requests, etc.


### Acknowledgement
The package is inspired by *PerformanceAnalytics* and *PortfolioAnalytics* packages in R and *pyfolio* in Python.
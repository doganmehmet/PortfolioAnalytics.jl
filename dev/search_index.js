var documenterSearchIndex = {"docs":
[{"location":"guide/#Guide","page":"Guide","title":"Guide","text":"","category":"section"},{"location":"guide/#Installation","page":"Guide","title":"Installation","text":"","category":"section"},{"location":"guide/#Development-version-(Suggested)","page":"Guide","title":"Development version (Suggested)","text":"","category":"section"},{"location":"guide/","page":"Guide","title":"Guide","text":"julia> using Pkg\njulia> Pkg.add(url=\"https://github.com/doganmehmet/PortfolioAnalytics.jl\")","category":"page"},{"location":"guide/#Stable-version","page":"Guide","title":"Stable version","text":"","category":"section"},{"location":"guide/","page":"Guide","title":"Guide","text":"julia> using Pkg\njulia> Pkg.add(\"PortfolioAnalytics\")","category":"page"},{"location":"guide/#Update-version","page":"Guide","title":"Update version","text":"","category":"section"},{"location":"guide/","page":"Guide","title":"Guide","text":"julia> using Pkg\njulia> Pkg.update(\"PortfolioAnalytics\")","category":"page"},{"location":"guide/","page":"Guide","title":"Guide","text":"Caution: The package is under heavy development, and this documentation refers to the development version which will significantly differ from the current stable version. Installation of the dev version is suggested.","category":"page"},{"location":"guide/#Functions","page":"Guide","title":"Functions","text":"","category":"section"},{"location":"guide/","page":"Guide","title":"Guide","text":"","category":"page"},{"location":"guide/","page":"Guide","title":"Guide","text":"using PortfolioAnalytics\nusing Dates\nusing TSFrames\n\ndates = Date(2021, 12, 31):Month(1):Date(2022, 12, 31)\nTSLA = [352.26,312.24,290.14,359.2,290.25,252.75,224.47,297.15,275.61,265.25,227.54,194.7,121.82]\nNFLX = [602.44,427.14,394.52,374.59,190.36,197.44,174.87,224.9,223.56,235.44,291.88,305.53,291.12]\nMSFT = [336.32,310.98,298.79,308.31,277.52,271.87,256.83,280.74,261.47,232.9,232.13,255.14,241.01]\n\nprices_ts = TSFrame([TSLA NFLX MSFT], dates, colnames=[:TSLA, :NFLX, :MSFT])\n\nweights = [0.4, 0.4, 0.2]\n\n13×3 TSFrame with Date Index\n Index       TSLA     NFLX     MSFT    \n Date        Float64  Float64  Float64 \n───────────────────────────────────────\n 2021-12-31   352.26   602.44   336.32 \n 2022-01-31   312.24   427.14   310.98 \n 2022-02-28   290.14   394.52   298.79 \n 2022-03-31   359.2    374.59   308.31 \n 2022-04-30   290.25   190.36   277.52 \n 2022-05-31   252.75   197.44   271.87 \n 2022-06-30   224.47   174.87   256.83\n 2022-07-31   297.15   224.9    280.74\n 2022-08-31   275.61   223.56   261.47\n 2022-09-30   265.25   235.44   232.9\n 2022-10-31   227.54   291.88   232.13\n 2022-11-30   194.7    305.53   255.14\n 2022-12-31   121.82   291.12   241.01","category":"page"},{"location":"guide/","page":"Guide","title":"Guide","text":"Return","category":"page"},{"location":"guide/#PortfolioAnalytics.Return","page":"Guide","title":"PortfolioAnalytics.Return","text":"Return(price::TSFrame, period::Int=1)\n\nCalculates returns form asset prices.\n\nArguments:\n\nprice::TSFrame: column(s) of TSFrame object of asset prices\nperiod::Int=1: return period\n\nExample\n\n julia> Return(prices_ts)\n 12×3 TSFrame with Date Index\n Index       TSLA        NFLX        MSFT        \n Date        Float64?    Float64?    Float64?    \n─────────────────────────────────────────────────\n 2022-01-31  -0.113609   -0.290983   -0.0753449\n 2022-02-28  -0.0707789  -0.0763684  -0.0391987\n 2022-03-31   0.238023   -0.0505171   0.0318618\n 2022-04-30  -0.191954   -0.491818   -0.099867\n 2022-05-31  -0.129199    0.0371927  -0.0203589\n 2022-06-30  -0.111889   -0.114313   -0.0553206\n 2022-07-31   0.323785    0.286098    0.0930966\n 2022-08-31  -0.0724886  -0.0059582  -0.06864\n 2022-09-30  -0.0375893   0.0531401  -0.109267\n 2022-10-31  -0.142168    0.239721   -0.00330614\n 2022-11-30  -0.144326    0.0467658   0.0991255\n 2022-12-31  -0.374319   -0.0471639  -0.0553814\n\nNotes:\n\nmissing resulting from the function is automatically removed\nReturn() does not calculate the portfolio return. Portfolio return is calcuated by PortfolioReturn() function.\n\n\n\n\n\n","category":"function"},{"location":"guide/","page":"Guide","title":"Guide","text":"PortfolioReturn","category":"page"},{"location":"guide/#PortfolioAnalytics.PortfolioReturn","page":"Guide","title":"PortfolioAnalytics.PortfolioReturn","text":"PortfolioReturn(price::TSFrame, weights::Vector{<:Number}; period::Int=1, colname::String=\"PRETURN\")\n\nCalculates portfolio return from asset prices and given weights.\n\nArguments:\n\nprice::TSFrame: column(s) of TSFrame object of asset prices\nweights::Vector{<:Number}: weights of assets\nperiod::Int=1: return period\ncolname::String=\"PRETURN\": name of the column of portfolio return\n\nExample\n\njulia> preturns = PortfolioReturn(prices_ts, weights)\n12×1 TSFrame with Date Index\n Index       PRETURN    \n Date        Float64?   \n────────────────────────\n 2022-01-31  -0.176906\n 2022-02-28  -0.0666986\n 2022-03-31   0.0813747\n 2022-04-30  -0.293482\n 2022-05-31  -0.0408743\n 2022-06-30  -0.101545\n 2022-07-31   0.262573\n 2022-08-31  -0.0451067\n 2022-09-30  -0.0156331\n 2022-10-31   0.0383602\n 2022-11-30  -0.0191991\n 2022-12-31  -0.17967\n\nNotes:\n\nmissing resulting from the function is automatically removed.\n\n\n\n\n\n","category":"function"},{"location":"guide/","page":"Guide","title":"Guide","text":"julia> all_returns = TSFrames.join(returns, preturns)\n12×4 TSFrame with Date Index\n Index       TSLA        NFLX        MSFT         PRETURN    \n Date        Float64?    Float64?    Float64?     Float64?   \n─────────────────────────────────────────────────────────────\n 2022-01-31  -0.113609   -0.290983   -0.0753449   -0.176906\n 2022-02-28  -0.0707789  -0.0763684  -0.0391987   -0.0666986\n 2022-03-31   0.238023   -0.0505171   0.0318618    0.0813747\n 2022-04-30  -0.191954   -0.491818   -0.099867    -0.293482\n 2022-05-31  -0.129199    0.0371927  -0.0203589   -0.0408743\n 2022-06-30  -0.111889   -0.114313   -0.0553206   -0.101545\n 2022-07-31   0.323785    0.286098    0.0930966    0.262573\n 2022-08-31  -0.0724886  -0.0059582  -0.06864     -0.0451067\n 2022-09-30  -0.0375893   0.0531401  -0.109267    -0.0156331\n 2022-10-31  -0.142168    0.239721   -0.00330614   0.0383602\n 2022-11-30  -0.144326    0.0467658   0.0991255   -0.0191991\n 2022-12-31  -0.374319   -0.0471639  -0.0553814   -0.17967","category":"page"},{"location":"guide/","page":"Guide","title":"Guide","text":"SharpeRatio","category":"page"},{"location":"guide/#PortfolioAnalytics.SharpeRatio","page":"Guide","title":"PortfolioAnalytics.SharpeRatio","text":"SharpeRatio(R::TSFrame, Rf::Number=0)\n\nCalculates Sharpe Ratio from asset returns. Output is a NamedArray.\n\nArguments:\n\nR::TSFrame: column(s) of TSFrame object of asset returns\nRf::Number=0: Risk free rate\n\nExample\n\njulia> sharpe = SharpeRatio(all_returns)\n4-element Named Vector{Float64}\nSharpe  │ \n────────┼──────────\nTSLA    │ -0.372359\nNFLX    │ -0.164948\nMSFT    │  -0.36582\nPRETURN │  -0.32811\n\n\n\n\n\n","category":"function"},{"location":"guide/","page":"Guide","title":"Guide","text":"MeanReturn","category":"page"},{"location":"guide/#PortfolioAnalytics.MeanReturn","page":"Guide","title":"PortfolioAnalytics.MeanReturn","text":"MeanReturn(R::TSFrame)\n\nCalculates the mean return from asset returns. Output is a NamedArray.\n\nExample\n\njulia> mreturn = MeanReturn(all_returns)\n4-element Named Vector{Float64}\nMean Return  │\n─────────────┼───────────\nTSLA         │ -0.0688762\nNFLX         │  -0.034517\nMSFT         │ -0.0252167\nPRETURN      │ -0.0464006\n\n\n\n\n\n","category":"function"},{"location":"guide/","page":"Guide","title":"Guide","text":"julia> using Plots\n# plotting mean return of stocks and portfolio\njulia> bar(names(mreturn), mreturn, labels = false)","category":"page"},{"location":"guide/","page":"Guide","title":"Guide","text":"Moments","category":"page"},{"location":"guide/#PortfolioAnalytics.Moments","page":"Guide","title":"PortfolioAnalytics.Moments","text":"Moments(R::TSFrame)\n\nCalculates the (statistical) moments of asset returns. Output is a NamedArray.\n\nExample\n\njulia> pmoments = Moments(all_returns)\n4×4 Named Matrix{Float64}\nRows ╲ Cols │       TSLA        NFLX        MSFT     PRETURN\n────────────┼───────────────────────────────────────────────\nMean        │ -0.0688762   -0.034517  -0.0252167  -0.0464006\nStd         │   0.184973    0.209259    0.068932    0.141418\nSkewness    │   0.868756   -0.600014    0.724772    0.415989\nKurtosis    │   0.529269    0.333629   -0.635292    0.415647\n\nOutput:\n\nNamedArray; rows: moments, columns: tickers\n\nNotes:\n\nKurtosis: excess kurtosis\n\n\n\n\n\n","category":"function"},{"location":"guide/","page":"Guide","title":"Guide","text":"VaR","category":"page"},{"location":"guide/#PortfolioAnalytics.VaR","page":"Guide","title":"PortfolioAnalytics.VaR","text":"VaR(R::TSFrame; p::Number=0.95, method::String=\"historical\")\n\nCalculates Value-at-Risk(VaR) from asset returns. Output is a NamedArray.\n\nArguments:\n\nR::TSFrame: column(s) of TSFrame object\np::Number=0.95: confidence interval\nmethod::String=\"historical\": method of VaR calculation\n\nExample\n\njulia> var_historical = VaR(all_returns)\n4-element Named Vector{Float64}\n95% VaR  │ \n─────────┼──────────\nTSLA     │ -0.274019\nNFLX     │ -0.381359\nMSFT     │ -0.104097\nPRETURN  │ -0.230885\n\njulia> var_parametric = VaR(all_returns, p = 0.90, method = \"parametric\")\n4-element Named Vector{Float64}\n90% VaR  │\n─────────┼──────────\nTSLA     │ -0.305928\nNFLX     │ -0.302693\nMSFT     │ -0.113557\nPRETURN  │ -0.227635\n\nNotes:\n\nAvailable methods: \"historical\" and \"parametric\"\nMonte Carlo method will be implemented as part of the next release\n\n\n\n\n\n","category":"function"},{"location":"guide/","page":"Guide","title":"Guide","text":"PortfolioOptimize","category":"page"},{"location":"guide/#PortfolioAnalytics.PortfolioOptimize","page":"Guide","title":"PortfolioAnalytics.PortfolioOptimize","text":"PortfolioOptimize(R::TSFrame)\n\nCalculates the optimal Portfolio weights for minumum-variance portfolio.\n\nArguments:\n\nR::TSFrame: columns of TSFrame object of asset returns\n\nExample\n\njulia> opt = PortfolioOptimize(returns)\n\nEXIT: Optimal Solution Found.\n(preturn = -0.025216712326596998, pvar = 0.06893199595428622, pweights = 3-element Named Vector{Float64}\nOptimal Weights  │\n─────────────────┼───────────\nTSLA             │ 1.46169e-7\nNFLX             │ 5.31995e-8\nMSFT             │        1.0)\n\njulia> portreturn = opt.preturn # or opt[1]\n-0.025216712326596998\n\njulia> portvar = opt.pvar # or opt[2]\n0.06893199595428622\n\njulia> portweights = opt.pweights # or opt[3]\n3-element Named Vector{Float64}\nOptimal Weights  │\n─────────────────┼───────────\nTSLA             │ 1.46169e-7\nNFLX             │ 5.31995e-8\nMSFT             │        1.0\n\nOutput:\n\nNamed Tuple\n\n1, preturn : portfolio mean return\n2, pvar: portfolio variable\n3, pweights: optimal portfolio weights for minumum variance portfolio\n\nNotes:\n\nCustom constraints will be added in the next release.\n\n\n\n\n\n","category":"function"},{"location":"guide/","page":"Guide","title":"Guide","text":"julia> using Plots\n# plotting optimal weights for minumum variance portfolio\njulia> bar(names(portweights), portweights, labels = false)","category":"page"},{"location":"#PortfolioAnalytics.jl","page":"Introduction","title":"PortfolioAnalytics.jl","text":"","category":"section"},{"location":"#Tool-for-Quantitative-Portfolio-Analytics","page":"Introduction","title":"Tool for Quantitative Portfolio Analytics","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"Inspired by PerformanceAnalytics and PortoflioAnalytics packages in R, pyfolio in Python, PortfolioAnalytics.jl aims to provide users with functionality for performing portfolio analytics.","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"PortfolioAnalytics.jl is minimal now, but it is under heavy development. ","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"The following functions are available:","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"Return()\nPortfolioReturn()\nSharpeRatio()\nVaR()\nPortfolioOptimize()","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"On the pipe:","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"MeanReturns()\nMoments()\nExpectedShortfall()","category":"page"},{"location":"#Contributions-are-most-welcome","page":"Introduction","title":"Contributions are most welcome","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"We greatly value contributions of any kind. Contributions could include but are not limited to documentation improvements, bug reports, new or improved code, scientific and technical code reviews, infrastructure improvements, mailing lists, chat participation, community help/building, education, and outreach.","category":"page"},{"location":"#Bug-reports","page":"Introduction","title":"Bug reports","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"Please report any issues via the GitHub issue tracker. All kinds of issues are welcome and encouraged; this includes bug reports, documentation typos, feature requests, etc.","category":"page"}]
}

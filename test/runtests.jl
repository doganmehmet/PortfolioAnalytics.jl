using PortfolioAnalytics
using Test


@testset "PortfolioAnalytics.jl" begin
    # Write your tests here.
    
    using TSFrames

    TSLA = [235.22,264.51,225.16,222.64,236.48,208.40,226.56,229.06,245.24,258.49,371.33,381.58,352.26];
    NFLX = [540.73,532.39,538.85,521.66,513.47,502.81,528.21,517.57,569.19,610.34,690.31,641.90,602.44];
    MSFT = [222.42,231.96,232.38,235.77,252.18,249.68,270.90,284.91,301.88,281.92,331.62,330.59,336.32];

    prices_ts = TSFrame([TSLA NFLX MSFT], colnames=[:TSLA, :NFLX, :MSFT])

    weights = [0.4, 0.4, 0.2]

    @test round(PortfolioAnalytics.Return(prices_ts,1)[1,1], digits = 4) ==  0.1245

    @test round(PortfolioAnalytics.PortfolioReturn(prices_ts, weights)[1,1], digits = 4) ==  0.0522

    @test round(PortfolioAnalytics.VaR(prices_ts)["TSLA"], digits = 4) == 216.944
    @test round(PortfolioAnalytics.VaR(prices_ts, 0.9, method = "parametric")["TSLA"], digits = 4) == 188.3264

    @test round(PortfolioAnalytics.SharpeRatio(prices_ts)["TSLA"], digits = 4) == 4.3921

    @test round(PortfolioAnalytics.MeanReturn(prices_ts)["TSLA"], digits=4) == 265.9177

    @test round(PortfolioAnalytics.StdDev(prices_ts)["TSLA"], digits=4) == 60.5448

    @test round(PortfolioAnalytics.Moments(prices_ts)["TSLA", "Mean"], digits = 4) == 265.9177

    @test round(PortfolioAnalytics.PortfolioOptimize(prices_ts).prisk, digits=4) == 40.8902

    @test round(PortfolioAnalytics.ExpectedShortfall(prices_ts)["TSLA"], digits=4) == 208.4



end

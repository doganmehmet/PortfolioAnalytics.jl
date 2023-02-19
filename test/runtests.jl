using PortfolioAnalytics
using Test


@testset "PortfolioAnalytics.jl" begin
    # Write your tests here.
    
    using TSFrames

    TSLA = [352.26,312.24,290.14,359.2,290.25,252.75,224.47,297.15,275.61,265.25,227.54,194.7,121.82];
    NFLX = [602.44,427.14,394.52,374.59,190.36,197.44,174.87,224.9,223.56,235.44,291.88,305.53,291.12];
    MSFT = [336.32,310.98,298.79,308.31,277.52,271.87,256.83,280.74,261.47,232.9,232.13,255.14,241.01]; 

    prices_ts = TSFrame([TSLA NFLX MSFT], colnames=[:TSLA, :NFLX, :MSFT])

    weights = [0.4, 0.4, 0.2]

    @test round(PortfolioAnalytics.Return(prices_ts,1)[1,1], digits = 4) ==  -0.1136

    @test round(PortfolioAnalytics.PortfolioReturn(prices_ts, weights)[1,1], digits = 4) ==  -0.1769

    @test round(PortfolioAnalytics.VaR(prices_ts)["TSLA"], digits = 4) == 165.548
    @test round(PortfolioAnalytics.VaR(prices_ts, p=0.9, method = "parametric")["TSLA"], digits = 4) == 183.8988

    @test round(PortfolioAnalytics.SharpeRatio(prices_ts)["TSLA"], digits = 4) == 4.1377

    @test round(PortfolioAnalytics.MeanReturn(prices_ts)["TSLA"], digits=4) == 266.4138
    @test round(PortfolioAnalytics.Moments(prices_ts)["Mean","TSLA"], digits = 4) == 266.4138

    @test round(PortfolioAnalytics.PortfolioOptimize(prices_ts).pvar, digits=4) == 32.2015



end

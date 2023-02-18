using PortfolioAnalytics
using Test

@testset "PortfolioAnalytics.jl" begin
    # Write your tests here.

    bond = [0.06276629, 0.03958098, 0.08456482,0.02759821,0.09584956,0.06363253,0.02874502,0.02707264,0.08776449,0.02950032]
    stock = [0.1759782,0.20386651,0.21993588,0.3090001,0.17365969,0.10465274,0.07888138,0.13220847,0.28409742,0.14343067]
    
    using TSFrames
    using Statistics
    
    ts = TSFrame(bond)
    @test PortfolioAnalytics.Return(ts)[2:10] ==  pctchange(ts)[2:10]

    ts1 = TSFrame([bond stock])

    @test PortfolioAnalytics.PortfolioReturn(ts1, [0.5, 0.5])[2:10] ==  (Matrix(pctchange(ts1))*[0.5, 0.5])[2:10]

    @test PortfolioAnalytics.SharpeRatio(ts) == 1.9817916066368684

    @test PortfolioAnalytics.PortfolioOptimize(ts1) == (0.06068400223854824, 0.02739914954609405, [0.953258665455051, 0.04674133454494899])

    @test PortfolioAnalytics.VaR(ts[:,1], 0.95, "historical") == 0.0273091465
    @test PortfolioAnalytics.VaR(ts[:,1], 0.95, "parametric") == 0.009301194810178992


end

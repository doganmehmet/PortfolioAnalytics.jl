using TSFrames
using Statistics
using Distributions
using JuMP
using Ipopt

date = ["2022-12-01","2022-12-02","2022-12-03","2022-12-04","2022-12-05","2022-12-06","2022-12-07","2022-12-08","2022-12-09","2022-12-10"]
bond = [0.06276629, 0.03958098, 0.08456482,0.02759821,0.09584956,0.06363253,0.02874502,0.02707264,0.08776449,0.02950032]
stock = [0.1759782,0.20386651,0.21993588,0.3090001,0.17365969,0.10465274,0.07888138,0.13220847,0.28409742,0.14343067]

df = DataFrame(date =  date, bond = bond, stock = stock)
df.date = Date.(df.date, "yyyy-mm-dd")

ts = TSFrame(df)

SharpeRatio(Matrix(ts))

mean.(Matrix(ts))

PortfolioOptimize(ts)

VaR(ts[:,1], 0.95, "parametric")
VaR(ts[:,1], 0.95, "historical")


ts.coredata

R = [3.42 ,-3.51 ,32.23 ,-7.36 ,19.77 ,25.86 ,25.71 ,3.30 ,-20.32 ,-28.62,3.45,-2.48,-31.84,23.89,-15.33,-0.92]./100

VaR(R, 0.95, "historical")
mean(R)
std(R)

mean(R) - (std(R) * Distributions.quantile(Normal(), 0.95))



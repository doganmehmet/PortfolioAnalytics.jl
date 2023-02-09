# Calculates Sharpe Ratio
function SharpeRatio(R, Rf = 0)
    meanReturn = mean(Matrix(R))
    StdDev = std(Matrix(R))
    sharpe = (meanReturn - Rf) / StdDev 

    return sharpe
    
end

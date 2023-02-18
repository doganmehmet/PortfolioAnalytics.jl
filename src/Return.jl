"""
    Return(price::TSFrame, period::Int=1)
    
Calculates `returns` form asset `prices`

Arguments:
    - price: column(s) of TSFrame object of asset prices
    - period: period, Int

Output:
    - TSFrame object, missing period is automatically removed

Notes:
    - This function does not calculate the portfolio return. Portfolio return is calcuated by PortfolioReturn function.

Issues:
    -

To do:
    - 
"""
function Return(price::TSFrame, period::Int=1)

    return TSFrames.pctchange(price, period)[(period+1):end]

end

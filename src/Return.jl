# Function for return calculations
# pctchange functions is from TSFrames
# It only accepts TSFrame type from TSFrames.jl package
# This does not calculate the portfolio return. 
# Portfolio return is calcuated by PortfolioReturn function.

# Arguments
    # price: column(s) of TSFrame object of asset prices

function Return(price)

    return pctchange(price)

end

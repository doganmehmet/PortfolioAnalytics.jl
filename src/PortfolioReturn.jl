# Function for portfolio return
# pctchange functions is from TSFrames
# It only accepts TSFrame type from TSFrames.jl package 
# At the moment there is no rebalancing options

# To be done:
    # Rebalancing to be added

# Arguments
    # R: column(s) of TSFrame object of asset returns
    # weights: weights of assets

function PortfolioReturn(data, weights)

    
    return Matrix(pctchange(data)) * weights
    

end

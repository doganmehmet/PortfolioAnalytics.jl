# Calculates Value-at-Risk(VaR)
# Methods include "historical" and "parametric"

# To be done:
    # Monte Carlo to be implemented

# Issues
    # It cannot run on multiple columns but working on implementation

# Arguments
    #  R: a vector, column of TSFrame, or column of DataFrame object of asset returns
    #  p: confidence interval
    #  method: default = "historical" or "parametric"
function VaR(R, p=0.95, method = "historical")

    alpha = 1 - p

    if method == "parametric"

        VAR = mean(R) - (std(R) * Distributions.quantile(Normal(), p)) 
    else
        VAR = quantile(R, alpha)

    end

    return VAR

end
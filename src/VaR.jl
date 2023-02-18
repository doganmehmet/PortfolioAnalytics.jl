"""Calculates Value-at-Risk(VaR)

Arguments:
    - R: column(s) of TSFrame object
    - p: confidence interval, Number
    - method: method of VaR calculation, default = "historical", available methods: "historical" and "parametric", String

Output:
    - NamedArray

Notes:
    - 

Issues:
    - Does not work in presense of NAs or missing vlaues. Will be fixed in the next release.

To do:
    - VaR with Monte Carlo to be implemented

"""
function VaR(R::TSFrame, p::Number = 0.95, method::String = "historical")

    alpha = 1 - p

    if method == "parametric"
        VAR = mean.(eachcol(Matrix(R))) - (std.(eachcol(Matrix(R))) .* Distributions.quantile(Normal(), p)) 
    else
        VAR = Distributions.quantile.(eachcol(Matrix(R)), alpha) 
    end

    colnames = names(R) # used only for naming array
    conf = Int(100*p) # used only for naming array
    
    
    return NamedArray(VAR, colnames, "$conf% VaR")

end


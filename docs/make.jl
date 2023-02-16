push!(LOAD_PATH,"../src/")
using Documenter
using PortfolioAnalytics

makedocs(
    sitename = "PortfolioAnalytics",
    format = Documenter.HTML(),
    modules = [PortfolioAnalytics]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/doganmehmet/PortfolioAnalytics.jl.git"
)

using Documenter, PortfolioAnalytics

makedocs(
    sitename = "PortfolioAnalytics.jl",
    authors = "Mehmet Dogan",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "false"),
    modules = [PortfolioAnalytics],
    pages = [
        "Introduction" => "index.md",
        "Guide" => "guide.md"
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/doganmehmet/PortfolioAnalytics.jl.git"
)

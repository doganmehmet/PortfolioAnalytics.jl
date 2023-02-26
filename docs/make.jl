using Documenter, PortfolioAnalytics

makedocs(
    sitename = "PortfolioAnalytics.jl",
    authors = "Mehmet Dogan",
    format = Documenter.HTML(),
    modules = [PortfolioAnalytics],
    pages = [
        "Introduction" => "index.md",
        "Installation" => "installation.md",
        "Tutorials" => "tutorials.md",
        "Functions" => "functions.md" 
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/doganmehmet/PortfolioAnalytics.jl.git"
)

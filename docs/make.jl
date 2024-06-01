using ReusWork
using Documenter

DocMeta.setdocmeta!(ReusWork, :DocTestSetup, :(using ReusWork); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers

function nice_name(file)
  file = replace(file, r"^[0-9]*-" => "")
  if haskey(page_rename, file)
    return page_rename[file]
  end
  return splitext(file)[1] |> x -> replace(x, "-" => " ") |> titlecase
end

makedocs(;
  modules = [ReusWork],
  doctest = true,
  linkcheck = true,
  authors = "Abel Soares Siqueira <abel.s.siqueira@gmail.com> and contributors",
  repo = "https://github.com/abelsiqueira/ReusWork.jl/blob/{commit}{path}#{line}",
  sitename = "ReusWork.jl",
  format = Documenter.HTML(;
    prettyurls = true,
    canonical = "https://abelsiqueira.github.io/ReusWork.jl",
    assets = ["assets/style.css"],
  ),
  pages = [
    "Home" => "index.md"
    [
      nice_name(file) => file for
      file in readdir(joinpath(@__DIR__, "src")) if file != "index.md" && splitext(file)[2] == ".md"
    ]
  ],
)

deploydocs(; repo = "github.com/abelsiqueira/ReusWork.jl", push_preview = true)

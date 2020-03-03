# Create LaTeX slides

function create-slides -d "Create LaTeX slides"
  if not test (echo $argv)
    set argv slides
  end
  cp ~/Documents/projects/latex-templates/slides-preamble.tex .
  cp ~/Documents/projects/latex-templates/slides.tex $argv.tex
end

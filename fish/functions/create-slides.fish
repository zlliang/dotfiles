# Create LaTeX slides

function create-slides -d "Create LaTeX slides"
  if not test (echo $argv)
    set argv slides
  end
  cp ~/projects/latex-templates/slides-preamble.tex .
  cp ~/projects/latex-templates/slides.tex $argv.tex
end

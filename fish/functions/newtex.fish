# Location: ~/.config/fish/functions/newtex.fish

function newtex -d "Create a new LaTeX project"
  set_color yellow
  cp ~/Documents/projects/latex-templates/document-pre.tex .
  cp ~/Documents/projects/latex-templates/document.tex .
  cp ~/Documents/projects/latex-templates/abbrs.bib .
  cp ~/Documents/projects/latex-templates/references.bib .
  cp ~/Documents/projects/latex-templates/siamplain.bst .
  echo "New LaTeX project created!"
  set_color normal
end

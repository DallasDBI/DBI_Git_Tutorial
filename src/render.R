# Helper script to render README and slide-deck versions of the tutorial here::i_am("README.md")

library(here)
library(rmarkdown)
library(readr)

tmp <- tempfile()

# README.md
readme <- read_lines(here("src/tutorial.Rmd"))
readme[!grepl("^### <|^## ", readme)] |>
  write_lines(tmp)  # Remove code highlighting

render(tmp, output_file = here("README.md"),
       output_format = github_document())

# Slide Deck
slides <- read_lines(here("src/tutorial.Rmd"))
slides[!grepl("^!", slides)] |> write_lines(tmp)  # Remove images

render(tmp, output_file = here("slide_deck.html"),
       output_format = ioslides_presentation(widescreen = T))

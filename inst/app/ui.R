

fluidPage(

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "stylesheet.css"),
    tags$script(src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"),
    tags$script(src="script.js")
  ),

  titlePanel("Guess the Mean, Mean Deviation (MD), Scaled Mean Squared Deviation (SMSD), and Root Mean Squared Deviation (RMSD)"),
  plotOutput(outputId = "ecdf"),

  tags$p("Note: You can horizontally resize the plot image by dragging from the bottom right corner of the plot."),



  source("ui_src/meanUI.R", local = TRUE)[1],
  source("ui_src/mdUI.R", local = TRUE)[1],
  source("ui_src/smsdUI.R", local = TRUE)[1],
  source("ui_src/rmsdUI.R", local = TRUE)[1],
  source("ui_src/sdUI.R", local = TRUE)[1]

)

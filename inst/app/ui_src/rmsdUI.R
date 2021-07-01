tags$div(class="grid", id="rmsdRow",
    tags$div(class="radioCol",
        tags$input(
            type="radio", id="rmsdRadio", name="Guess",
            onclick="handleRadio(this)", value="RMSD", tags$label(class = "radioTxt", "RMSD", tags$br(), "(Uncompressed Dev.)")
        )
    ),
    tags$div(class="sliderCol",
        sliderInput(
            inputId = "rmsdSlider",
            label = "",
            ticks = FALSE,
            round = -2,
            width = '100%',
            value = 0, min = 0, max = 0,
            step = 0.01
        )
    ),
    tags$div(class="buttonCol",
        actionButton(
            inputId = "rmsdBtn",
            label = "Submit"
        )
    ),
    tags$div(class="feedbackCol",
        textOutput(outputId = "adjustRMSD")
    ),
    tags$div(class="checkboxCol")
)

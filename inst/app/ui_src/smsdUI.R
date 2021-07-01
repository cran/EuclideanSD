tags$div(class="grid", id="smsdRow",
    tags$div(class="radioCol",
        tags$input(
            type="radio", id="smsdRadio", name="Guess",
            onclick="handleRadio(this)", value="SMSD", tags$label(class = "radioTxt", "Scaled MSD", tags$br(), "(Compressed Dev.)")
        )
    ),
    tags$div(class="sliderCol",
        sliderInput(
            inputId = "smsdSlider",
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
            inputId = "smsdBtn",
            label = "Submit"
        )
    ),
    tags$div(class="feedbackCol",
        textOutput(outputId = "adjustSMSD")
    ),
    tags$div(class="checkboxCol")
)

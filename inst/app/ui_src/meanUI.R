tags$div(class="grid",
    tags$div(class="radioCol",
        tags$input(
            type="radio", id="meanRadio", checked="checked", name="Guess",
            onclick="handleRadio(this)", value="Mean", tags$label(class="radioTxt", "Mean/Center")
        )
    ),
    tags$div(class="sliderCol",
        sliderInput(
            inputId = "meanSlider",
            label = "",
            ticks = FALSE,
            width = '100%',
            round = -2,
            value = 0, min = 0, max = 0,
            step = 0.01
        )
    ),
    tags$div(class="buttonCol",
        actionButton(
            inputId = "meanBtn",
            label = "Submit"
        )
    ),
    tags$div(class="feedbackCol",
        textOutput(outputId = "adjustGuess")
    ),
    tags$div(class="checkboxCol")
)

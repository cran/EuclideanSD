tags$div(class="grid",
    tags$div(class="radioCol",
        tags$input(
            type="radio", id="mdRadio", name="Guess",
            onclick="handleRadio(this)", value="MD", tags$label(class = "radioTxt", "Mean Deviation", tags$br(), "(Uncompressed Dev.)")
        )
    ),
    tags$div(class="sliderCol",
        sliderInput(
            inputId = "mdSlider",
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
            inputId = "mdBtn",
            label = "Submit"
        )
    ),
    tags$div(class="feedbackCol",
        textOutput(outputId = "adjustMD")
    ),
    tags$div(class="checkboxCol",
        checkboxInput(
            inputId = "toggleExpand",
            label = "Expand Plot",
            value = FALSE
        ),
        checkboxInput(
            inputId = "toggleSort",
            label = "Sort (Convert to ECDF of D)",
            value = FALSE
        )
    )
)

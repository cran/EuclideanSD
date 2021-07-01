tags$div(class="grid", id="sdRow",
    tags$div(class="radioCol",
        tags$input(
            type="radio", id="sdRadio", name="Guess",
            onclick="handleRadio(this)", value="SD", tags$label(class = "radioTxt", "SD")
        )
    ),
    tags$div(class="sliderCol"),
    tags$div(class="buttonCol"),
    tags$div(class="feedbackCol"),
    tags$div(class="checkboxCol",
        checkboxInput(
            inputId = "popSDToggle",
            label = "Show Population SD",
            value = FALSE
        ),
        checkboxInput(
            inputId = "sampleSDToggle",
            label = "Show Sample SD",
            value = FALSE
        )
    )
)

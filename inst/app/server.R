library(ggplot2)
function(input, output, session) {
  df <- data.frame(values = EuclideanSD::nums)
  n <- nrow(df)
  mean <- mean(df$values)
  median <- median(df$values) # used to verify certain mathematical properties
  # print(paste("Mean: ", mean))
  # print(paste("Median: ", median))
  absmin = min(df$values)
  absmax = max(df$values)


  correctMean <- reactiveVal(FALSE)
  correctSMSD <- reactiveVal(FALSE)
  correctRMSD <- reactiveVal(FALSE)
  correctMD <- reactiveVal(FALSE)

  # These variables store the values with full precision if the guess is correct
  fullMD <- reactiveVal(0)
  fullRMSD <- reactiveVal(0)
  fullSMSD <- reactiveVal(0)

  mode <- reactiveVal("Mean") # Used for initial setting of mode
  e <- new.env()
  e$initialized <- FALSE # Used to indicate whether or not sliders are initialized

  e$popSD <- 0
  e$sampleSD <- 0
  popToggle <- reactiveVal(1)
  sampleToggle <- reactiveVal(1)

  # Initializes sliders with proper values
  updateSliderInput(
    session,
    "meanSlider",
    value = round(absmin, digits=2),
    min = round(absmin, digits=2),
    max = round(absmax, digits=2)
  )

  # Code for plot
  source("server_src/plot.R", local = TRUE)


  # Handles button presses
  source("server_src/button_handling.R", local = TRUE)


  # Lets JS know that slider values are updated
  observeEvent(input$meanSlider, {
    if (input$meanSlider != mean) {
      correctMean(FALSE)
    }
    session$sendCustomMessage("updateSliderVal", input$meanSlider)
    output$adjustGuess <- renderText({""})
  })

  observeEvent(input$mdSlider, {
    if (correctMD()) {
      correctMD(FALSE)
    }
    session$sendCustomMessage("updateMdSliderVal", input$mdSlider)
    output$adjustMD <- renderText({""})
  })

  observeEvent(input$smsdSlider, {
    if (correctSMSD()) {
      correctSMSD(FALSE)
    }
    updateSliderInput(
      session,
      inputId = "rmsdSlider",
      value = 0,
    )
    session$sendCustomMessage("updateSmsdSliderVal", input$smsdSlider)
    session$sendCustomMessage("correctMD", correctMD())
    output$adjustSMSD <- renderText({""})
  })

  observeEvent(input$rmsdSlider, {
    if (correctRMSD()) {
      correctRMSD(FALSE)
    }
    session$sendCustomMessage("updateRmsdSliderVal", input$rmsdSlider)
    session$sendCustomMessage("correctSMSD", correctSMSD()) # lets max value of slider reappear

    output$adjustRMSD <- renderText({""})
  })


  # Updates max of other sliders based on mean
  observeEvent(input$meanSlider, {
    updateSliderInput(
      session,
      inputId = "mdSlider",
      value = 0,
      max = max(c( (input$meanSlider - round(min(df$values), digits = 3)), round(max(df$values), digits = 3) - input$meanSlider ))
    )
    updateSliderInput(
      session,
      inputId = "smsdSlider",
      value = 0,
      max = max(c( (input$meanSlider - round(min(df$values), digits = 3)), round(max(df$values), digits = 3) - input$meanSlider ))
    )
    updateSliderInput(
      session,
      inputId = "rmsdSlider",
      value = 0,
      max = max(c( (input$meanSlider - round(min(df$values), digits = 3)), round(max(df$values), digits = 3) - input$meanSlider ))
    )
  })


  # Updates sliders from arrow keys
  observeEvent(input$meanSliderNew, {
    updateSliderInput(session, "meanSlider", value = input$meanSliderNew)
    updateSliderInput(session, "mdSlider", value = 0)
    updateSliderInput(session, "smsdSlider", value = 0)
  })

  observeEvent(input$mdSliderNew, {
    updateSliderInput(session, "mdSlider", value = input$mdSliderNew)
  })

  observeEvent(input$smsdSliderNew, {
    updateSliderInput(session, "smsdSlider", value = input$smsdSliderNew)
  })

  observeEvent(input$rmsdSliderNew, {
    updateSliderInput(session, "rmsdSlider", value = input$rmsdSliderNew)
  })


  # Handles changes in radio buttons
  observeEvent(input$mode, {
    mode(input$mode) # updates reactive mode variable
  })

  observe( # sends JS the change in radio button
    session$sendCustomMessage("updateMode", mode())
  )


  # Handles clicking of SD toggles
  observeEvent(input$popSDToggle, {
    popToggle((popToggle() + 1) %% 2)
  })

  observeEvent(input$sampleSDToggle, {
    sampleToggle((sampleToggle() + 1) %% 2)
  })


  # Lets JS know if the guessed mean is correct
  observeEvent({
    correctMean()
    correctSMSD()
    correctRMSD()
    correctMD()
  }, {
    session$sendCustomMessage("correctSMSD", correctSMSD())
    session$sendCustomMessage("correctGuess", ((correctMean() & correctRMSD()) & correctMD()))
    session$sendCustomMessage("correctMD", correctMD())
  })

}

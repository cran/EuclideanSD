var sliderVal;
var mode;
var mdSliderVal;
var smsdSliderVal;
var rmsdSliderVal;
var popToggle;
var sampleToggle;

$(document).on('keydown', function(e) { // handles arrow keys
    if (e.which == 39) { // right arrow
        if (mode == "Mean") {
            Shiny.setInputValue("meanSliderNew", sliderVal + 0.01, {priority: "event"});
        } else if (mode == "MD") {
            Shiny.setInputValue("mdSliderNew", mdSliderVal + 0.01, {priority: "event"});
        } else if (mode == "SMSD") {
            Shiny.setInputValue("smsdSliderNew", smsdSliderVal + 0.01, {priority: "event"});
        } else if (mode == "RMSD") {
            Shiny.setInputValue("rmsdSliderNew", rmsdSliderVal + 0.01, {priority: "event"});
        }
    } else if (e.which == 37) { // left arrow
        if (mode == "Mean") {
            Shiny.setInputValue("meanSliderNew", sliderVal - 0.01, {priority: "event"});
        } else if (mode == "MD") {
            Shiny.setInputValue("mdSliderNew", mdSliderVal - 0.01, {priority: "event"});
        } else if (mode == "SMSD") {
            Shiny.setInputValue("smsdSliderNew", smsdSliderVal - 0.01, {priority: "event"});
        } else if (mode == "RMSD") {
            Shiny.setInputValue("rmsdSliderNew", rmsdSliderVal - 0.01, {priority: "event"});
        }
    }
});


// Updates javascript values for sliders
Shiny.addCustomMessageHandler("updateSliderVal", function(x) {
    sliderVal = x;
});

Shiny.addCustomMessageHandler("updateMdSliderVal", function(x) {
    mdSliderVal = x;
});

Shiny.addCustomMessageHandler("updateSmsdSliderVal", function(x) {
    smsdSliderVal = x;
});

Shiny.addCustomMessageHandler("updateRmsdSliderVal", function(x) {
    rmsdSliderVal = x;
});

Shiny.addCustomMessageHandler("updateMode", function(m) {
    mode = m;
});


// Toggles displaying standard deviations
Shiny.addCustomMessageHandler("showPopSD", function(s) {
    document.querySelector("#popSDToggle + span").textContent = "Show Population SD: " + s.toFixed(4);
});

Shiny.addCustomMessageHandler("showSampleSD", function(s) {
    document.querySelector("#sampleSDToggle + span").textContent = "Show Sample SD: " + s.toFixed(4);
});

Shiny.addCustomMessageHandler("hidePopSD", function(s) {
    document.querySelector("#popSDToggle + span").textContent = "Show Population SD";
});

Shiny.addCustomMessageHandler("hideSampleSD", function(s) {
    document.querySelector("#sampleSDToggle + span").textContent = "Show Sample SD";
});


// Handles radio buttons
function handleRadio(el) {
    var radio;
    var elements = document.getElementsByName("Guess");
    for (var i = 0; i < elements.length; i++) {
        if (elements[i].checked) {
            radio = elements[i];
        }
    }
    Shiny.setInputValue("mode", radio.value);
}

// Sets visibility of SD row based on whether or not the mean/smsd guessed is correct
Shiny.addCustomMessageHandler("correctGuess", function(b) {
    if (b) {
        document.getElementById("sdRow").style.visibility = "visible";
    } else {
        document.getElementById("sdRow").style.visibility = "hidden";
        if (mode == "SD") {
            Shiny.setInputValue("mode", "Mean")
            document.getElementsByName("Guess")[0].checked = "checked"
        }
    }
});

Shiny.addCustomMessageHandler("correctSMSD", function(b) {
    if (b) {
        document.getElementById("rmsdRow").style.visibility = "visible";
        document.getElementById("rmsdRow").getElementsByClassName("irs-max")[0].style.setProperty("visibility", "visible", "important");
        document.getElementById("rmsdRow").getElementsByClassName("irs-min")[0].style.setProperty("visibility", "visible", "important");
    } else {
        document.getElementById("rmsdRow").style.visibility = "hidden";
        document.getElementById("rmsdRow").getElementsByClassName("irs-max")[0].style.setProperty("visibility", "hidden", "important");
        document.getElementById("rmsdRow").getElementsByClassName("irs-min")[0].style.setProperty("visibility", "hidden", "important");
        if (mode == "RMSD") {
            Shiny.setInputValue("mode", "Mean")
            document.getElementsByName("Guess")[0].checked = "checked"
        }
    }
});

Shiny.addCustomMessageHandler("correctMD", function(b) {
    if (b) {
        document.getElementById("smsdRow").style.visibility = "visible";
        document.getElementById("smsdRow").getElementsByClassName("irs-max")[0].style.setProperty("visibility", "visible", "important");
        document.getElementById("smsdRow").getElementsByClassName("irs-min")[0].style.setProperty("visibility", "visible", "important");
    } else {
        document.getElementById("smsdRow").style.visibility = "hidden";
        document.getElementById("smsdRow").getElementsByClassName("irs-max")[0].style.setProperty("visibility", "hidden", "important");
        document.getElementById("smsdRow").getElementsByClassName("irs-min")[0].style.setProperty("visibility", "hidden", "important");
        document.getElementById("rmsdRow").style.visibility = "hidden";
        document.getElementById("rmsdRow").getElementsByClassName("irs-max")[0].style.setProperty("visibility", "hidden", "important");
        document.getElementById("rmsdRow").getElementsByClassName("irs-min")[0].style.setProperty("visibility", "hidden", "important");
        
        if (mode == "SMSD") {
            Shiny.setInputValue("mode", "Mean")
            document.getElementsByName("Guess")[0].checked = "checked"
        }
    }
});

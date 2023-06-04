pacman::p_load(shiny,tidyverse)

edges_aggr <- read_csv("data/Exam_data.csv")
#to speed up, the calculation can be done and saved here instead of rendering

ui <- fluidPage(

    titlePanel("Pupils Examination Results Dashboard"),
    sidebarLayout( 
        sidebarPanel("sidebar",
            selectInput(inputId = "variable", #inputid must be unique
                        label="Subject:",
                        choices = c("English"="ENGLISH",
                                    "Maths" = "MATHS",
                                    "Science"="SCIENCE"),
                        selected = "English"),
            sliderInput(inputId="bins",
                        label = "Number of bins",
                        min=5,
                        max=20,
                        value=10)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$distPlot <- renderPlot({
    #x <- unlist(exam[,input$variable])
    ggplot(data=exam, aes_string(x=input$variable)) +
      geom_histogram(bins = input$bins,
                     color="black", 
                     fill="light blue")
    })
  
}




shinyApp(ui = ui, server = server)

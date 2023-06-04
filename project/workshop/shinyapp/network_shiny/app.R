pacman::p_load(shiny,tidyverse,ggraph)


edges_aggr <- read_rds("data/mc2_edges_aggregated.rds")
nodes_extracted <- read_rds("data/mc2_nodes_extracted.rds")
graph <- read_rds("data/mc2_graph.rds")

ui <- fluidPage(
 # theme = 
  titlePanel("network visualization"),
  sidebarLayout( 
    sidebarPanel(width=3,"Select Layout",
                 selectInput(inputId = "variable", 
                             label="Layout:",
                             choices = c("fr"="fr", "kk"="kk"),
                             selected = "fr")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(width=9,
      plotOutput("distPlot",height="500px")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    set.seed(1234)
    ggraph(graph,layout = input$variable) + 
        geom_edge_link(aes(), 
                       alpha=0.2) +
        geom_node_point(aes(), size = 3)
    
    
  })
  
}




shinyApp(ui = ui, server = server)



login_module_ui<-function(id){
  
  ns <- NS(id)
  
  tagList(
    
    fluidRow(
      
      column(
        width = 2,
        textInput(ns("login"),"login"),
      ),
      column(
        width = 2,
        textInput(ns("password"),"Password")
      )
    ),
    fluidRow(
      
      column(
        width = 1,
        actionButton(ns("login_btn"),"login",
                     class = "btn-success",
                     style = "color: #fff;",
                     icon = icon('sign-in'),
                     width = '100%')
      )
    ),
    
    fluidRow(
      
      column(
        
        width = 10,
        offset = 1,
        plotOutput(ns("cereals"))
      )
    )
    
    
    )
}


#Server side

login_module_server <- function(id,parent_session){
  
moduleServer(
  id,
  function(input,output,session){
    
    output$cereals <- renderImage({
      
      filename <- normalizePath("www/food2.jpg")
      list(src = filename,
           width="100%",
           height="149%")
    }, deleteFile = FALSE)
    
    observeEvent(input$login_btn, {
      updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Home")
    })
    
  
    
  }
  
  
  
)
  
}
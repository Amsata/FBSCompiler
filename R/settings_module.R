

settings_module_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    fluidRow(
      
      column(
        width = 1,
        actionButton(ns("home_btn"),"Home",
                     class = "btn-success",
                     style = "color: #fff;",
                     icon = icon('arrow-left'),
                     width = '100%')
      ),
      column(
        width = 2,
        actionButton(ns("database_init_btn"),"Initialize the database",
                     class = "btn-success",
                     style = "color: #fff; background:#F1C40F;",
                     icon = icon('book'),
                     width = '100%')
      )
    )
    
  )
}






settings_module_server <- function(id, parent_session){
  
  
  moduleServer(
    id,
    
    function(input,output,session){
      
      observeEvent(input$home_btn, {
        updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Home")
      })
      
      observeEvent(input$database_init_btn, {
        SetupDatabase(con)
              })
    }
  )
}
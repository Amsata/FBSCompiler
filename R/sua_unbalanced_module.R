sua_unbalanced_module_ui <- function(id){
  
  ns <- NS(id)
  tagList(
    
    tags$head(
      tags$style(HTML("hr {border-top: 1px solid #000000;}"))
    ),

    
  fluidRow(
    
    column(12,
           
           tags$div(fluidRow(id=ns('aTextBox'), column(1,
                                                       actionButton(ns("home_bt"),"Home",
                                                                    class = "btn-success",
                                                                    style = "color: #fff;",
                                                                    icon = icon('arrow-left'),
                                                                    width = '100%')
           ),
           column(2,
                  downloadButton(ns("downloadResults"),"Download Results")),
           column(2,
                  selectInput(
                    inputId=ns("si_sua_items"),
                    label="sua items",
                    choices=fbs_item,
                    selected = NULL,
                    multiple = TRUE,
                    selectize = TRUE,
                    width = NULL,
                    size = NULL
                  )),
           column(2,
                  selectInput(
                    inputId=ns("si_years"),
                    label="sua years",
                    choices=years,
                    selected = NULL,
                    multiple = TRUE,
                    selectize = TRUE,
                    width = NULL,
                    size = NULL
                  )),
           column(1,
                  actionButton(ns("pull_btn"),"Pull data",
                               class = "btn-success",
                               style = "color: #fff;font-size:11px;background-color:#85C1E9;",
                               icon = icon('bezier-curve'),
                               width = '100%')
           ),
           column(1,
                  actionButton(ns("compile_btn"),"Compile",
                               class = "btn-success",
                               style = "color: #fff;font-size:11px;background-color:#85C1E9;",
                               icon = icon('chalkboard-teacher'),
                               width = '100%')
           ),
           column(3,
                  actionButton(ns("save_btn"),"Save to database",
                               class = "btn-success",
                               style = "color: #fff;font-size:11px;background-color:#85C1E9;",
                               icon = icon('database'),
                               width = '120px')
           )
           
           
           
           ))
           
           )
  ),
  tags$hr(),
  fluidRow(
    
    column(12,offset = 0, tags$head(
      tags$style(
        HTML("
          .datatables {
              font-size: 1.5vw;
              font-family: arial;
          }

          @media screen and (min-width: 1024px) {
              .datatables {
                  font-size: 12px;
              }
          }
        ")
      )
    ),
           
           DTOutput(ns("Dtab")) %>% withSpinner()
    )
    # )
  )
    
  )
}


sua_unbalanced_module_server <- function(id,parent_session){
  
  
  moduleServer(id,
               function(input,output,session){

                 observeEvent(input$home_bt, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Home")
                 })
                 
                
                
                 observe({
                   
                   browseData(id,input,output,session,domain='SUA')
                 }) 
                 
               })
}
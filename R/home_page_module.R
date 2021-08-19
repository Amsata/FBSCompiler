
home_page_module_ui <- function(id){
  
  ns <- NS(id)
  tagList(
    
    tags$head(
      tags$style(HTML("hr {border-top: 1px solid #000000;}"))
    ),
    # titlePanel(
    #   h1("SUA/FBS compilation",align='center')
    # ),
    # 
    fluidRow(
      
      column(
        width = 1,
        actionButton(ns("login_bt"),"Home",
                     class = "btn-success",
                     style = "color: #fff;",
                     icon = icon('arrow-left'),
                     width = '100%')
      ),
      column(
        width = 2,
        actionButton(ns("sua_unbalanced_btn"),"SUA Unbalanced",
                     class = "btn-success",
                     style = "color: #fff; background:#F1C40F;",
                     icon = icon('book'),
                     width = '100%')
      ),
      column(
        width = 2,
        actionButton(ns("sua_balanced_btn"),"SUA balanced",
                     class = "btn-success",
                     style = "color: #fff; background:#F1C40F;",
                     icon = icon('book'),
                     width = '100%')
      ),
      column(
        width = 2,
        actionButton(ns("fbs_btn"),"FBS",
                     class = "btn-success",
                     style = "color: #fff; background:#F1C40F;",
                     icon = icon('balance-scale'),
                     width = '100%')
      ),
      column(
        width = 2,
        actionButton(ns("login_bnt"),"Analytics",
                     class = "btn-success",
                     style = "color: #fff; background:#F1C40F;",
                     icon = icon('chart-line'),
                     width = '100%')
      ),
      
      column(
        width = 2,
        actionButton(ns("setting_btn"),"Settings",
                     class = "btn-success",
                     style = "color: #fff; background:#F1C40F;",
                     icon = icon('machine'),
                     width = '100%')
      )
    ),
    
    tags$hr(),
    
    fluidRow(
      column(12,
             fluidRow(
               column(2,
                      titlePanel(
                        "Supply"
                      ),
                      style = "background-color:#EBF5FB;",
                      fluidRow(
                        column(12, 
                               actionButton(ns("production_btn"),"Production",
                                            class = "btn-success",
                                            style = "color: #fff; 
                                            background:#3498DB;
                                            border-color:#F1C40F;",
                                            icon = icon('project-diagram'),
                                            width = '100%',
                                            height='4'))
                      ),
                      
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("import_btn"),"Imports",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('share-square'),
                                            width = '100%'))
                      ),
                      
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("export_btn"),"Exports",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('reply-all'),
                                            width = '100%'))
                      ),
                      
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("stock_btn"),"Stock Variations",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('pepper-hot'),
                                            width = '100%'))
                      ),
                    
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("ostock_btn"),"Opening Stocks",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('pepper-hot'),
                                            width = '100%'))
                      ),
                      
                      
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("cstock_btn"),"Closing Stocks",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('pepper-hot'),
                                            width = '100%'))
                      ),
                      tags$br(),
                      
                      
               ),
               # column(width = 2),
               column(width = 8,
                      plotOutput(ns("img"))),
               column(2,
                      titlePanel(
                        "Utilizations"
                      ),
                      style = "background-color:#EBF5FB;",
                      fluidRow(
                        column(12, 
                               actionButton(ns("food_btn"),"Food",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('pepper-hot'),
                                            width = '100%'))
                      ),
                      
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("processing_btn"),"Food processing",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('blender'),
                                            width = '100%'))
                      ),
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("feed_btn"),"Feed",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('cat'),
                                            width = '100%'))
                      ),
                      
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("seed_btn"),"Seed",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('seedling'),
                                            width = '100%'))
                      ),
                      
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("loss_btn"),"Loss",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('leaf'),
                                            width = '100%'))
                      ),
                      
                      tags$br(),
                      
                      fluidRow(
                        column(12, 
                               actionButton(ns("industrial_btn"),"Industrial uses",
                                            class = "btn-success",
                                            style = "color: #fff; background:#3498DB;",
                                            icon = icon('gas-pump'),
                                            width = '100%'))
                      ),
                      tags$br(),
                      
               )
             )
      )
    )
    
  )
}


home_page_module_server <- function(id,parent_session){
  
  
  moduleServer(id,
               function(input,output,session){
                 
                 output$img <- renderImage({
                   
                   filename <- normalizePath("www/pulses.jpg")
                   list(src = filename,
                        width="100%",
                        height="136%")
                 }, deleteFile = FALSE)
                 

                 observeEvent(input$login_bt, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Login")
                 })
                  #Go to production page                
                 observeEvent(input$production_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to imports page                
                 observeEvent(input$import_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to export page                
                 observeEvent(input$export_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to Stock variations page                
                 observeEvent(input$stock_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 #Go to Opening Stocks page                
                 observeEvent(input$ostock_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to closing Stocks page                
                 observeEvent(input$cstock_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to setting page                
                 observeEvent(input$setting_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Settings")
                 })
                 #Go to food page                
                 observeEvent(input$food_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to food processing page                
                 observeEvent(input$processing_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to feed page                
                 observeEvent(input$feed_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to seed page                
                 observeEvent(input$seed_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to industrials uses page                
                 observeEvent(input$industrial_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to loss page                
                 observeEvent(input$loss_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Production")
                 })
                 
                 #Go to SUA unbalanced page                
                 observeEvent(input$sua_unbalanced_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "SUA unbalanced")
                 })
                 
                 #Go to SUA unbalanced page                
                 observeEvent(input$sua_balanced_btn, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "SUA unbalanced")
                 })
                 
               }

               
  )
}
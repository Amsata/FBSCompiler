sua_unbalanced_module_ui <- function(id){
  
  ns <- NS(id)
  tagList(
    
    tags$head(
      tags$style(HTML("hr {border-top: 1px solid #000000;}"))
    ),
    titlePanel(
      h1("SUA unbalanced",align='center')
    ),
    
    
    tags$div(fluidRow(id=ns('aTextBox'), column(1,
                                                actionButton(ns("home_bt"),"Home",
                                                             class = "btn-success",
                                                             style = "color: #fff;",
                                                             icon = icon('arrow-left'),
                                                             width = '100%')
    ))),
    
    fluidRow(
      column(
        
        width = 12,
        # dataTableOutput(ns("Prod"))
        # actionButton(ns("add"),"adds")
        
        
        
      )
    )
    
  )
}


sua_unbalanced_module_server <- function(id,parent_session){
  
  
  moduleServer(id,
               function(input,output,session){
                 output$ Prod <- renderDataTable(mtcars)
                 
                 observeEvent(input$home_bt, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Home")
                 })
                 
                 crop=c("rice","wheat","millet","maize")
                 
                 for (ids in crop) {
                   insertUI(
                     selector = paste0('#',session$ns('aTextBox')),
                     where = "afterEnd",
                     ui = tagList(
                       tags$hr(),
                       h3(textOutput(session$ns(paste0("txt_",ids)))),
                       fluidRow(
                         column(12,
                                DTOutput(session$ns(ids)) %>% withSpinner()
                         )
                       )
                     )
                   )
                   
                   
                 }
                 
                 Map (function(i){
                   output[[i]] <-renderDT(head(mtcars))},crop)
                 
                 Map(function(i){
                   output[[i]] <-renderText(paste0(gsub("txt_","",i)))
                 },paste0("txt_",crop))
                 
                 
                 # trigegr to reload data from the "mtcars" table
                 session$userData$mtcars_trigger <- reactiveVal(0)
                 
                 # Read in "mtcars" table from the database
                 cars <- reactive({
                   
                   out <- NULL
                   
                   out <- mtcars %>% 
                     mutate(
                       uid=1:nrow(mtcars))
                   
                   out
                   
                 })
                 
                 car_table_prep <- reactiveVal(NULL)
                 
                 observeEvent(cars(), {
                   out <- cars()
                   
                   ids <- out$uid
                   
                   actions <- purrr::map_chr(ids, function(id_) {
                     paste0(
                       '<div class="btn-group" style="width: 80px;" role="group" aria-label="Basic example">
          <button class="btn btn-primary btn-sm edit_btn" data-toggle="tooltip" data-placement="top" title="Edit" id = ', id_, ' style="margin: 0"><i class="fa fa-pencil-square-o"></i></button>
          <button class="btn btn-danger btn-sm delete_btn" data-toggle="tooltip" data-placement="top" title="Delete" id = ', id_, ' style="margin: 0"><i class="fa fa-trash-o"></i></button>
        </div>'
                     )
                   })
                   
                   # Remove the `uid` column. We don't want to show this column to the user
                   out <- out %>%
                     select(-uid)
                   
                   # Set the Action Buttons row to the first column of the `mtcars` table
                   out <- cbind(
                     tibble(" " = actions),
                     out
                   )
                   
                   if (is.null(car_table_prep())) {
                     # loading data into the table for the first time, so we render the entire table
                     # rather than using a DT proxy
                     car_table_prep(out)
                     
                   } else {
                     
                     # table has already rendered, so use DT proxy to update the data in the
                     # table without rerendering the entire table
                     replaceData(car_table_proxy, out, resetPaging = FALSE, rownames = FALSE)
                     
                   }
                 })
                 
                 
                 Map (function(i){
                   output[[i]] <-renderDT({
                     req(car_table_prep())
                     out <- car_table_prep()
                     
                     datatable(
                       out,
                       rownames = FALSE,
                       colnames = c('Model', 'Miles/Gallon', 'Cylinders', 'Displacement (cu.in.)',
                                    'Horsepower', 'Rear Axle Ratio', 'Weight (lbs)', '1/4 Mile Time',
                                    'Engine', 'Transmission', 'Forward Gears', 'Carburetors'),
                       selection = "none",
                       class = "compact stripe row-border nowrap",
                       # Escape the HTML in all except 1st column (which has the buttons)
                       escape = -1,
                       extensions = c("Buttons"),
                       options = list(
                         scrollX = TRUE,
                         dom = 'Bftip',
                         buttons = list(
                           list(
                             extend = "excel",
                             text = "Download",
                             title = paste0("mtcars-", Sys.Date()),
                             exportOptions = list(
                               columns = 1:(length(out) - 1)
                             )
                           )
                         ),
                         columnDefs = list(
                           list(targets = 0, orderable = FALSE)
                         ),
                         drawCallback = JS("function(settings) {
          // removes any lingering tooltips
          $('.tooltip').remove()
        }")
                       )
                     )
                     
                   })
                 },crop)
                 
                 
                 
               })
}
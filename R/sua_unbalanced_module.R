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
                    inputId="si_sua_items",
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
                    inputId="si_years",
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
    # style='padding:0px;background-color:#EBF5FB;',
    # div(style = "font-size: 10px; padding: 14px 0px; margin:0%",
    # h3(textOutput(session$ns(paste0("txt_",ids)))),
    
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
                 output$ Prod <- renderDataTable(mtcars)
                 
                 observeEvent(input$home_bt, {
                   updateTabsetPanel(session=parent_session, "SuaFbs",selected = "Home")
                 })
                 
                 # crop=unique(sua_data$Item)[1:2]
                 
                 # for (ids in crop) {
                 #   insertUI(
                 #     selector = paste0('#',session$ns('aTextBox')),
                 #     where = "afterEnd",
                 #     ui = tagList(
                 #       tags$hr(),
                 #       # h3(textOutput(session$ns(paste0("txt_",ids)))),
                 #       
                 #       fluidRow(
                 #         style='padding:0px;background-color:#EBF5FB;',
                 #         # div(style = "font-size: 10px; padding: 14px 0px; margin:0%",
                 #         h3(textOutput(session$ns(paste0("txt_",ids)))),
                 #         
                 #         column(12, offset = 0, style='padding:0px;background-color:#EBF5FB;',
                 # 
                 # 
                 #                DTOutput(session$ns(ids)) %>% withSpinner()
                 #         )
                 #         # )
                 #       )
                 #     )
                 #   )
                 #   
                 #   
                 # }
                 # 

                 # Map(function(i){
                 #   output[[i]] <-renderText(i)
                 # },paste0("txt_",crop))
                 
                 
                 # trigegr to reload data from the "mtcars" table
                 # session$userData$mtcars_trigger <- reactiveVal(0)
                 
                 # Read in "mtcars" table from the database
                 # cars <- reactive({
                   
                   out <- NULL
                   
                   con=dbConnect(odbc::odbc(),"Pos")
                   sua_data=DBI::dbReadTable(con,"sua_records")
                   DBI::dbDisconnect(con)
                   
                   out <- sua_data %>% 
                     mutate(
                       uid=1:nrow(sua_data)) %>% slice(1:200)
                   
                   # out
                   
                 # })
                 
                 # car_table_prep <- reactiveVal(NULL)
                 
                 # observeEvent(cars(), {
                 #   out <- cars()
                   
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
                     dplyr::select(-uid)
                   
                   # Set the Action Buttons row to the first column of the `mtcars` table
                   out <- cbind(
                     tibble(" " = actions),
                     out
                   )
                 #   
                 #   if (is.null(car_table_prep())) {
                 #     # loading data into the table for the first time, so we render the entire table
                 #     # rather than using a DT proxy
                 #     car_table_prep(out)
                 #     
                 #   } else {
                 #     
                 #     # table has already rendered, so use DT proxy to update the data in the
                 #     # table without rerendering the entire table
                 #     replaceData(car_table_proxy, out, resetPaging = FALSE, rownames = FALSE)
                 #     
                 #   }
                 # })
                 
                 
                 # Map (function(i){
                   output[["Dtab"]] <-renderDT({
                     # req(car_table_prep())
                     # out <- car_table_prep()
                     
                     datatable(
                       isolate(out) ,
                       # filter = 'top',
                       rownames = FALSE,
                       colnames = c('Model', names(sua_data)),
                       selection = "none",
                       editable = list(target = "cell", disable = list(columns = c(0,2))),
                       class = "compact stripe row-border nowrap",
                       # Escape the HTML in all except 1st column (which has the buttons)
                       escape = -1,
                       extensions = c("Buttons","RowGroup","FixedHeader","KeyTable"),
                       options = list(
                         keys = TRUE,
                         autoWidth = TRUE,
                         fixedHeader = TRUE,
                         pageLength = nrow(out),
                         rowGroup = list(dataSrc = 1),
                         scrollX = TRUE,
                         dom = 'Bftip',
                         autoFill = TRUE,
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
                           list(targets = 0, orderable = FALSE),
                           list(visible=FALSE, targets=1)
                         ),
                         drawCallback = JS("function(settings) {
          // removes any lingering tooltips
          $('.tooltip').remove()
        }")
                       )
                     )
                     
                   })
                 # },crop)
                 
                   # proxy5 = dataTableProxy('Dtab')
                   
                   
                   dff <- reactiveValues(
                     data=NA
                   )
                   
                   
                   observe({
                     
                     dff$data=out
                   })
                   
                   observeEvent(input$Dtab_cell_edit, {
                     out <<- editData(out, input$Dtab_cell_edit,rownames = FALSE)
                   })
                   
                   output$downloadResults <- downloadHandler(
                     filename = function(){paste("userTest.csv.csv", sep = "")},
                     content = function(file){write.csv(as.data.frame(out[,2:length(names(out))]), file, row.names = FALSE)}
                   )
                 
               })
}
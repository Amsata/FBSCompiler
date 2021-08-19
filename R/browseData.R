browseData <- function(id,input,output,session,domain){
  
  itemss=reactive({
    input$si_sua_items
  })
  years=reactive({
    as.numeric(input$si_years)
  })
  out <- NULL
  
  dff0<-reactiveVal(NULL)
  
  data <- NULL
  observeEvent(input$compile_btn,{
    req(input$si_sua_items)
    req(input$si_years)
    sua_data=DBI::dbGetQuery(conn=con,
                             statement=getQuery(domain = domain,
                                                fbs_items=itemss(),
                                                years = years()
                                                )
                             )
    
    if(nrow(sua_data)!=0){
      out=render_wide(sua_data,"SUA")
      dff0(out)
      data<<-dff0()
    }
    
    
  })
  
  
  
  
  # Map (function(i){
  output[["Dtab"]] <-renderDT({
    req(dff0())
    datatable(
      isolate(data) ,
      # filter = 'top',
      rownames = FALSE,
      # colnames = c('Model', names(sua_data)),
      selection = "none",
      editable = list(target = "cell", disable = list(columns = c(0,2))),
      class = "compact stripe row-border nowrap",
      # Escape the HTML in all except 1st column (which has the buttons)
      escape = -1,
      extensions = c("Buttons","RowGroup","FixedHeader","KeyTable"),
      options = list(
        keys = TRUE,
        autoWidth = FALSE,
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
  
  observeEvent(input$Dtab_cell_edit, {
    data <<- editData(data, input$Dtab_cell_edit,rownames = FALSE)
  })
  
  observeEvent(dff0(),{
    out=data[,2:length(names(data))]
    out=long_format(data[,2:length(names(data))])
    output$downloadResults <- downloadHandler(
      filename = function(){paste("userTest.csv.csv", sep = "")},
      content = function(file){write.csv(long_format(data[,2:length(names(data))]), file, row.names = FALSE)}
    )
  })
  
}
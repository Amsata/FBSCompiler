

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {

  login_module_server("login",parent_session=session)
  
  home_page_module_server("home",parent_session=session)
  
  production_module_server("prod",parent_session=session)
  
  settings_module_server("settings",parent_session=session)
  
  sua_unbalanced_module_server("suaUn",parent_session = session)
  # analytics_module_server("suaUn",parent_session = session)

  
  

})

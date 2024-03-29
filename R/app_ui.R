#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'
#' @importFrom shiny selectizeInput tags fluidRow div plotOutput
#' @importFrom shinydashboard dashboardPage dashboardHeader dashboardSidebar
#' dashboardBody valueBoxOutput box
#' @importFrom DT DTOutput
#' @noRd
app_ui <- function(request) {
  golem_add_external_resources()
  shinydashboard::dashboardPage(skin="green",
    shinydashboard::dashboardHeader(title = "SoyFungiGCN"),
    shinydashboard::dashboardSidebar(
      shiny::selectizeInput('gene_id', 'Enter gene ID (Wm82.a2.v1)', 
                            choices=NULL,
                            options = list(
                              placeholder = 'Glyma.01G000400',
                              onInitialize = I('function() { this.setValue(""); }')
                              )),
      shiny::tags$p(style="text-align: justify; padding-left: 10px; 
             padding-right: 10px;",
             "The input gene IDs must be based on the Wm82.a2.v1 assembly. 
             Your input gene will not be present in the network if its 
             median expression across samples is lower than 5 TPM."),
      shiny::tags$div(
        align = "center",
        shiny::tags$img(
          src = "www/logo.png", width = "70%", align = "center"
        )
      )
      # shiny::tags$img(src="www/logo.png", width=163, height=180,
      #                 style="display: block; margin-left: auto; margin-right: auto;")
    ),
    shinydashboard::dashboardBody(
      shiny::fluidRow(
        shinydashboard::valueBoxOutput("module"),
        shinydashboard::valueBoxOutput("degree"),
        shinydashboard::valueBoxOutput("hub_status")
      ),
      shiny::fluidRow(
        shinydashboard::box(
          title = "Module enrichment",
          solidHeader = TRUE,
          width = 12,
          collapsible = TRUE,
          shiny::div(DT::DTOutput("mod_enrich"), style = "font-size: 90%;")),
      ),
      shiny::fluidRow(
        shinydashboard::box(
          title="Network visualization",
          solidHeader = TRUE,
          width=12,
          collapsible = TRUE, collapsed = TRUE,
          footer="The plot might take a while to load. If your input gene is not labeled in the plot, it means it only makes weak connections, resulting in its removal during the filtering step.",
          shiny::plotOutput("netviz_static"))
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @importFrom shiny tags
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon("logo.png"),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'SoyFungiGCN'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}


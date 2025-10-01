library(shiny)
library(dplyr)
library(shinydashboard)
library(DT)
library(readr)
library(ggplot2)
library(plotly)
library(forecast)
library(zoo)

midata <- read.csv("D:/shinny/recaudacion/muestraFinal.csv")
# Define la interfaz de usuario de la aplicación
ui <- dashboardPage(
  dashboardHeader(title = "vidaNATURE"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Datos", tabName = "Datos", icon = icon("database"),
               menuSubItem("INTRODUCCION", tabName = "datos1"),
               menuSubItem("DATA", tabName = "datos2"),
               menuSubItem("VARIABLES", tabName = "datos3")
      ),
      menuItem("Gráficos", tabName = "graficos", icon = icon("chart-bar")),
      menuItem("Estadísticas", tabName = "estadisticas", icon = icon("calculator")),
      menuItem("Predicción", tabName = "prediccion", icon = icon("line-chart")),
      menuItem("Ayuda y Soporte", tabName = "ayuda", icon = icon("question-circle"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$style(
        HTML("
          /* color fondo */
          .content-wrapper {
            background-color: hue;
          }
          
          /* Cambiar el color del encabezado */
          .skin-blue .main-header .logo {
            background-color: green !important;
          }
          
          /* Cambiar el color del menú lateral */
          .main-sidebar {
            background-color: green !important;
          }
        ")
      )
    ),
    tabItems(
      tabItem(tabName = "datos1",
              fluidPage(
                titlePanel("Enseñar a Cuidar el Medio Ambiente, es Enseñar a Valorar la Vida."),
                fluidRow(
                  column(width = 4,
                         tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Logo_UNAP.png/831px-Logo_UNAP.png", height = "100px", width = "100px",
                                  style = "display: block; margin-left: auto; margin-right: auto;")),
                        # tags$p("Texto descriptivo", style = "font-family: 'Arial'; font-size: 14px;")),
                  column(width = 4,
                         tags$h2("Ingresos Realizados con Fines de Preservacion de Areas Naturales Protegidas", style = "font-family: 'Arial'; font-size: 28px; font-weight: bold; text-align: center; color: green;"),
                         tags$p("Nuestro planeta alberga una diversidad asombrosa de ecosistemas y seres vivos. Las áreas naturales son refugios de vida silvestre, fuentes de agua, pulmones verdes y escenarios de belleza indescriptible.
                                Es hora de despertar nuestra conciencia y actuar. Proteger las áreas naturales es preservar nuestra herencia natural para las generaciones futuras.", style = "font-family: 'Verdana'; font-size: 16px; text-align: center;")),
                    
                  column(width = 4,
                         tags$img(src = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQExozkCM_kziLiKFk1o_gFsfry2mqcVIRmeYXyFW5PZA&s", 
                                  height = "100px", width = "100px", style = "display: block; margin-left: auto; margin-right: auto;"))
                ),
                fluidRow(
                  column(width = 12,
                         tags$img(src = "https://www.actualidadambiental.pe/wp-content/uploads/2020/10/especial-acr-spda-700x415.jpg", height = "500px", width = "1600px",
                                  style = "display: block; margin-left: auto; margin-right: auto;"))
                )
              )
      ),
      tabItem(tabName = "datos2",
              fluidPage(
                titlePanel("Previsualizacion de la Data General - Subsección 2"),
                mainPanel(
                  dataTableOutput("data_table")
                )
              )
      ),
      tabItem(tabName = "datos3",
              fluidPage(
                titlePanel("Variables en unidad_dependencia"),
                mainPanel(
                  fluidRow(
                    column(width = 6, 
                           tableOutput("variable_table") , style = "display: block; margin-left: auto; margin-right: auto;"),
                    column(width = 6,
                           tags$div(
                             style = "width: 450px; height: 450px; background-image: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(1, 0, 0, 0)), url('https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhHkgKH_G3Sxs46gMUl0MQNLjG9g6m98eHcULLlZGuXvuPljLuzayKl5HiyqrxGHp23S5aG-wn8KhRXrQvcNUovoyspy6VSyxV4cHQRh0-ks5OJV3Wfcno-IkTQBAf1iLVjdCgSSWXHnncjKw8TEdpXgoC2tl2e08lgxNaYxx42PQONmByT0uJUzsaZAMbX/w320-h283/imagencuidatumundo.png'); background-size: cover; background-position: center;",
                             style = "display: block; margin-left: 250px; margin-right: auto;"
                           )
                           
                    ),
                    column(width = 12,
                           tags$div(
                            # style = "display: flex; justify-content: center; align-items: flex-end;",
                             tags$img(
                               src = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiOjicHIy3lwt2_qOfDTVbnvP6gWNmDtIjS1SEPR_CDCx_cNgHkuycmhRVwDZTVQlOy097aEDsxbs9Y0c1dP5ez0A32VYQaVxc95yXqJ7FpznX3dp4f-TE2llbl4kbrzLjrvZvkbajrVCLVpiTYx-Y2lN-7Gwb7g_9kzhuB0UUjJ6FGYXkX-YxNFyjmVqLb/s1743/imagen3datos1.png",
                               height = "400px",
                               width = "1500px",
                               style = "display: block; margin-left: auto; margin-right: auto;"
                             )
                           )
                    )
                  )
                )
              )
      ),
      tabItem(tabName = "graficos",
              selectInput("filtro_unidad", "Selecciona una unidad o dependencia:",
                          choices = unique(midata$UNIDAD_DEPENDENCIA),
                          selected = NULL),
              tabsetPanel(
                tabPanel("Gráficos",
                         fluidRow(
                           column(width = 6, plotlyOutput("grafico_lineas"), style = "margin-bottom: 20px;"),
                           column(width = 6, plotlyOutput("grafico_barras"), style = "margin-bottom: 20px;")
                         ),
                         fluidRow(
                           column(height = 15, width = 6, plotlyOutput("grafico_pastel"), style = "margin-bottom: 20px;"),
                           column(width = 6, plotlyOutput("grafico_dispersion"), style = "margin-bottom: 20px;")
                         ),
                         fluidRow(
                           column(width = 6, plotlyOutput("grafico_boxplot"), style = "margin-bottom: 20px;")
                         ),
                         fluidRow(
                           column(width = 12, h2("..."))
                         )
                ),
                tabPanel("general",
                         
                         fluidRow(
                           column(width = 6, plotlyOutput("grafico_histograma"), style = "margin-bottom: 20px;"),
                           column(width = 6, plotlyOutput("grafico_dispercion"), style = "margin-bottom: 20px;")
                         ),
                         fluidRow(
                           column(width = 6,
                                  tags$p("Este grafico representa visualmente, la comparacion de todas las unidades operaciones de las regiones en estudio
                                          con el monto total recaudado entre el periodo de enero de 2021 al inicios del 2023. En donde se registro mayor 
                                         recaudacion, claramente se observa en Areas ubicadas en Ica o todas las Areas Naturales dependientes de Ica.", style = "font-family: 'Verdana'; font-size: 16px; text-align: center;")),
                           column(width = 5,
                                  tags$p("Las unidades que se encargar de monitorear estas Areas Naturales, muchas veces las recaudacion obtenidas se quedaban 
                                         por debajo de un monto espero, de esta manera excediendo en cierta cantidad. en este aspecto de tenemos a todas las Areas Naturales Protegidas dependientes de 
                                         Madre de Dios.", style = "font-family: 'Verdana'; font-size: 16px; text-align: center;")),
                           
                         )
                )
              )
      ),
      tabItem(tabName = "estadisticas",
              fluidPage(
                titlePanel("Estadísticas"),
                mainPanel(
                  tableOutput("summary_table")
                )
              )
      ),
      tabItem(tabName = "prediccion",
              selectInput("unidad_dependencia", "Variable UNIDAD_DEPENDENCIA:",
                          choices = unique(midata$UNIDAD_DEPENDENCIA)),
              tabsetPanel(
                tabPanel("predicciones",
                         fluidRow(
                           column(width = 6, plotlyOutput("line_chart"), style = "margin-bottom: 20px;"),
                           column(width = 6, plotlyOutput("grafico_prediccion"), style = "margin-bottom: 20px;")
                         ),
                         plotlyOutput("grafico_prediccion_barras")
                ),
                tabPanel("predicciones2",
                         h2("En proceso")
                )
              )
      ),
      tabItem(tabName = "ayuda",
              h2("Ayuda y Soporte"),
              fluidRow(
                column(6,
                       
                       p("¡Bienvenido a esta seccion!",style = "font-size: 20px;"), 
                       p("Si tienes algun problema o quieras darnos alguna sugerencia sobre 
                       esta aplicación, por favor no dudes en contactarnos.
                       Estamos aquí para ayudarte a resolver cualquier problema o duda que puedas tener y asegurarnos 
                       de que tengas una buena informacion.

                      Además, si encuentras algún error o problema técnico en la aplicación, por favor háznoslo saber. 
                      Queremos asegurarnos de que la aplicación funcione sin problemas y que ademas la informacion sea de calidad
                       para todos usuarios visitantes de esta web. 
                      Tu sugerencia es muy valiosa para nosotros.",style = "font-size: 20px;"),

                      p("¡Gracias por visitar esta web!",style = "font-size: 20px;"),
                       p(HTML("<a href='https://forms.gle/yzLjh43p4Z6hkK5w6'>Enlace, si tienes alguna duda o sugerencia</a>")),
                      tags$img(src = "https://soporteinformatico.com.mx/wp-content/uploads/2019/07/image-21_606x606.png", height = "400px", width = "400px",
                               style = "display: block; margin-left: auto; margin-right: auto;")
                       # Agrega el contenido de las preguntas frecuentes
                ),
                
                column(6,
                       h3(HTML("<strong>Desarrollado Por:</strong>"), style = "text-align: center; font-size: 30px; font-family: 'Arial'; color: darkblue;"),
                       tags$div(style = "text-align:center;",
                                tags$img(src = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRpxBVgPySzej8P9L-TThzJM6FpOEk7Q97NIJz0I4m6DTZS7uZj86Of1W3FOVCwlJ4FNZMCRjdV7L3UB94WvT02Ewtm1WASltvzgONHjbTX4v79XEJRRcorGd2QZiwichV2zegXywesr0HZneDAlU20L7grwDvqGRGoFiTr1ZYKCMVo_dPIjLmCUME7l86/w320-h296/alex.png", 
                                         width= "260px",
                                         height= "260px",
                                         style = "border-radius: 80%;  margin-left: 1px; mergin-right: 50;")),
                       p("Alex Cruz A.", style = "text-align: center; font-size: 25px; font-family: 'Arial';"),
                       p(HTML("<a href='https://www.linkedin.com/in/alex-raul-cruz-01a9b6230'><i class='fab fa-linkedin'></i> LINKEDIN</a>"), style = "text-align: center;"),
                       p(HTML("<a href='https://instagram.com/1alex_c?igshid=MzNlNGNkZWQ4Mg=='><i class='fab fa-instagram'></i> INSTAGRAM</a>"), style = "text-align: center;"),
                       tags$div(style = "text-align:center;",
                                tags$img(src = "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi06ZdzmXz6QikxJCCE7U0-sxoOv7qJJ6SrqueHXa_DkbccUDdytXtx7uS8fttayPdV8p-BFc2kEpit2e0l7pFcukUXfRmG7UklH4NOWJ_xa-NFcPrWV1hCGqxOKNY-ERthVwPrj8ifJJ67aNk2pZ-hdVokK0dCvp1MZ40rWTleyfHSYhsZMieuYqs0elZe/s320/imagenPRESI.jpeg", 
                                         width= "245px",
                                         height= "245px",
                                         style = "border-radius: 80%;  margin-left: 1px; mergin-right: 50;")),
                       p("Edison Callata M.", style = "text-align: center; font-size: 25px; font-family: 'Arial';"),
                       #p("Facultad de Ingenieria Estadistica e Informatica", styler= "text-align: center;")
                       
                )
                
              ),
              p("Facultad de Ingenieria Estadistica e Informatica", style= "text-align: center; font-size:20px; font-family: 'Avenir Next';"),
              p("Universidad Nacional del Altiplano", style= "text-align: center; font-size:20px; font-family: 'Rabbit Hole';"),
      )
    )
  )
)




# Define el servidor de la aplicación
server <- function(input, output, session) {
  # Establecer la configuración regional adecuada
  locale_decimal <- locale(decimal_mark = ".", grouping_mark = ",")
  
  # Cargar el archivo CSV y mostrar los datos en una tabla
  midata <- read_csv("D:/shinny/recaudacion/muestraFinal.csv", locale = locale_decimal)
  
  output$data_table <- renderDataTable({
    midata
  })
  
  output$variable_table <- renderTable({
    frecuencia_nombres <- table(midata$UNIDAD_DEPENDENCIA)
    frecuencia_nombres
    
  })
  
  filtered_data <- reactive({
    if (!is.null(input$filtro_unidad)) {
      midata[midata$UNIDAD_DEPENDENCIA == input$filtro_unidad, ]
    } else {
      midata
    }
  })
  
  # Gráfico de Líneas
  output$grafico_lineas <- renderPlotly({
    filtered <- filtered_data()
    
    p <- ggplot(filtered, aes(x = FECHA_DOC_VTA, y = AFECTO)) +
      geom_line() +
      labs(x = "Fecha del documento de venta", y = "Monto afecto")
    
    ggplotly(p)
  })
  
  # Crear un gráfico de barras utilizando plotly
  output$grafico_barras <- renderPlotly({
    filtered <- filtered_data()
    
    p <- ggplot(filtered, aes(x = ANP, y = IMPORTE_TOTAL)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(x = "Área Natural Protegida", y = "Monto total")
    
    ggplotly(p)
  })
  
  # Crear un gráfico de pastel utilizando plotly
  output$grafico_pastel <- renderPlotly({
    filtered <- filtered_data()
    frecuencia_nombres <- table(filtered$UNIDAD_DEPENDENCIA)
    
    asis <- length(filtered$UNIDAD_DEPENDENCIA)
    asies <- length(unique(midata$UNIDAD_DEPENDENCIA))
    
    prop_asies <- asies / asis
    prop_otros <- 1 - prop_asies
    
    data <- c(asies, asis - asies)
    labels <- c("solo esta U.D.", "TOTAL")
    
    # Crear el gráfico de pastel utilizando plotly
    p <- plot_ly(labels = labels, values = data, type = "pie") %>%
      layout(title = "Proporción de UNIDAD_DEPENDENCIA", showlegend = TRUE)
    
    p
  })
  
  # Crear un gráfico de dispersión utilizando plotly
  output$grafico_dispersion <- renderPlotly({
    filtered <- filtered_data()
    
    p <- ggplot(filtered, aes(x = AFECTO, y = NO_AFECTO)) +
      geom_point()
    
    ggplotly(p)
  })
  
  # Crear un gráfico de boxplot utilizando plotly
  output$grafico_boxplot <- renderPlotly({
    filtered <- filtered_data()
    
    p <- ggplot(filtered, aes(x = UNIDAD_DEPENDENCIA, y = IMPORTE_TOTAL)) +
      geom_boxplot(fill = "skyblue") +
      labs(x = "Unidad o dependencia", y = "Monto total")
    
    ggplotly(p)
  })
  
  ############### PARTE GENERAL:
  #histigrama
  output$grafico_histograma <- renderPlotly({
    filtered <- filtered_data()
    # Calcular la suma de IMPORTE_TOTAL por cada valor único de UNIDAD_DEPENDENCIA
    datos_agrupados <- midata %>% 
      group_by(UNIDAD_DEPENDENCIA) %>% 
      summarize(Suma_IMPORTETOTAL = sum(IMPORTE_TOTAL))
    
    # Graficar el histograma comparando las sumas de todas las variables
    ggplot(datos_agrupados, aes(x = UNIDAD_DEPENDENCIA, y = Suma_IMPORTETOTAL, fill = UNIDAD_DEPENDENCIA)) +
      geom_bar(stat = "identity") +
      labs(x = "UNIDAD_DEPENDENCIA", y = "total de Importe") +
      theme_minimal() +
      theme(legend.position = "none",
            axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  #grafico de puntos.
  output$grafico_dispercion <- renderPlotly({
    filtered <- filtered_data()
    p <- ggplot(midata, aes(x = midata$UNIDAD_DEPENDENCIA, y = NO_AFECTO)) +
      geom_point() +
      labs(x = "UNIDAD DEPENDENCIA", y = "No afecto = CREDITO") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(p)
  })
  
  #grafico de pastel:
  ###############-----PREDICCION
  ##LINEA DE TIEMPO:
  output$line_chart <- renderPlotly({
    # Obtener la variable seleccionada por el usuario
    selected_variable <- input$unidad_dependencia
    
    # Filtrar los datos para la variable seleccionada de UNIDAD_DEPENDENCIA
    data_selected <- midata[midata$UNIDAD_DEPENDENCIA == selected_variable, ]
    
    # Crear el gráfico de línea de tiempo
    data_selected$FECHA_DOC_VTA <- as.Date(as.character(data_selected$FECHA_DOC_VTA), format = "%Y%m%d")
    
    # Ordenar el dataframe por FECHA_DOC_VTA
    data_selected <- data_selected %>%
      arrange(FECHA_DOC_VTA)
    
    f <- ggplot(data_selected, aes(x = FECHA_DOC_VTA, y = IMPORTE_TOTAL)) +
      geom_line() +
      labs(x = "Fecha", y = "Importe Total") +
      ggtitle(paste("Línea de Tiempo -", selected_variable)) +
      theme_minimal()
    
    ggplotly(f)
  })
  ## LINEA DE TIEMPO CON PREDDICION:
  output$grafico_prediccion <- renderPlotly({
    # Obtener la variable seleccionada por el usuario
    selected_variable <- input$unidad_dependencia
    
    # Filtrar los datos para la variable seleccionada de UNIDAD_DEPENDENCIA
    data_selected <- midata[midata$UNIDAD_DEPENDENCIA == selected_variable, ]
    
    # Ordenar los datos por FECHA_DOC_VTA
    data_selected <- data_selected[order(data_selected$FECHA_DOC_VTA), ]
    
    # Crear la serie de tiempo
    ts_data <- ts(data_selected$IMPORTE_TOTAL, frequency = 10)
    
    # Realizar la predicción
    forecast_data <- forecast(ts_data, h = 8)
    
    # Crear el gráfico interactivo con plot_ly()
    plot_ly() %>%
      add_lines(x = time(ts_data), y = ts_data, name = "Línea de tiempo original", color = I("blue")) %>%
      add_lines(x = time(forecast_data$mean), y = forecast_data$mean, name = "Predicción", color = I("red")) %>%
      add_ribbons(x = time(forecast_data$mean), ymin = forecast_data$lower[, "95%"], ymax = forecast_data$upper[, "95%"], name = "Intervalo de confianza", color = I("lightblue")) %>%
      layout(title = paste("Predicción de la variable", selected_variable), xaxis = list(title = "Fecha"), yaxis = list(title = "Importe Total"))
  })
  
  ## GRAFICO DE BARRAS PREDICCION:
  output$grafico_prediccion_barras <- renderPlotly({
    # Obtener la variable seleccionada por el usuario
    selected_variable <- input$unidad_dependencia
    
    # Filtrar los datos para la variable seleccionada de UNIDAD_DEPENDENCIA
    data_selected <- midata[midata$UNIDAD_DEPENDENCIA == selected_variable, ]
    
    # Ordenar los datos por FECHA_DOC_VTA
    data_selected <- data_selected[order(data_selected$FECHA_DOC_VTA), ]
    
    # Crear la serie de tiempo
    ts_data <- ts(data_selected$IMPORTE_TOTAL, frequency = 12)
    
    # Realizar la predicción
    forecast_data <- forecast(ts_data, h = 12)
    
    # Obtener las fechas para el eje x
    fechas <- time(ts_data)
    
    # Obtener los valores observados y pronosticados
    valores_observados <- ts_data
    valores_pronosticados <- forecast_data$mean
    
    # Generar las fechas pronosticadas
    fechas_pronosticadas <- seq(max(fechas) + 1, length.out = length(valores_pronosticados), by = 1)
    
    # Crear el gráfico de barras
    plot_ly() %>%
      add_trace(x = fechas, y = valores_observados, name = "Valores Observados", type = "bar", marker = list(color = "blue")) %>%
      add_trace(x = fechas_pronosticadas, y = valores_pronosticados, name = "Valores Pronosticados", type = "bar", marker = list(color = "red")) %>%
      layout(title = paste("Predicción de la variable", selected_variable), xaxis = list(title = "Fecha"), yaxis = list(title = "Importe Total"))
  })
  #######
  output$summary_table <- renderTable({
    summary_data <- by(midata$IMPORTE_TOTAL, midata$UNIDAD_DEPENDENCIA, FUN = summary)
    summary_df <- do.call(rbind, summary_data)
    
    # Obtener los nombres de variable únicos
    unique_names <- unique(midata$UNIDAD_DEPENDENCIA)
    
    # Verificar que la cantidad de nombres sea igual a la cantidad de grupos en el resumen
    if (length(unique_names) == nrow(summary_df)) {
      # Agregar los nombres de las variables a la tabla de resumen
      summary_df <- cbind(unique_names, summary_df)
      colnames(summary_df)[1] <- "Variable"
    } else {
      # Mostrar un mensaje de error si la cantidad de nombres no coincide
      return("Error: La cantidad de nombres de variable no coincide con la cantidad de grupos en el resumen.")
    }
    
    summary_df
  })
  
  
}

# Ejecuta la aplicación Shiny
shinyApp(ui, server)
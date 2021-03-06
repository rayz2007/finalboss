# UI for Shiny 201 FINAL 

# LOADING DATA and LIBRARIES
library(dplyr)
library(ggplot2)
library(plotly)
library(rsconnect)
library(shiny)
library(gdata)
library(qdap)
library(lazyeval)


# Define UI for application that draws a histogram
shinyUI(navbarPage("HIV Data",
  tabPanel(
    "Overview",
    h1('HIV/AIDS', align= "center"),
    HTML('<center><img src="hivimage.JPG" width="700"></center>'),
    h3('About'),
    p(strong('Human immunodeficiency virus or "HIV"'), 'is a virus that if left untreated can develop into aqquired immunodeficiency syndrome. 
    Unfortunately, the human body is', em('unable'), 'to completely rid itself of HIV, so it affects the carrier for life. HIV affects the body\'s immune
    system, and left untreated, reduces the number of T cells in the body, making the body more susceptible to infection. Eventually, the body
    is left completely defensless against infection and disease, which represents the onset of the AIDS stage.'), 
    span(),
    p('There is currently no cure for HIV/AIDS but can be controlled relatively effectively through the use of antiretroviral theropy.
    If taken carefully and diligently, antiretroviral medicine can significantly prolong the lives of people with HIV as well as lower
    their likelyhood of transmitting the virus to others.'),
    span(),
    p('You can learn more about HIV/AIDS from this government', a("website", href = "https://www.aids.gov/hiv-aids-basics/hiv-aids-101/what-is-hiv-aids/")),
    h3("The Data"),
    p("This project focuses on the prevalence of HIV throughout the world by country between the years of", strong('2000 and 2015'), "using 
    interactive visuals. It will find which countries had the highest overall infection rate, as well as portray how the infection to death 
    ration fluctuated throughout the decade. The top 5 most infected countries will also be analyzed for their GDP and population side to 
    reveal any underlying similarities. Understanding the weight in which HIV/AIDS affects countries around the world allows one to begin to
    identify where and why HIV/AIDS is impacting peoples lives in this century.")
    ),
    
  #creates two color coordinated maps of world 
  #hover text for nation name and deaths occured
  tabPanel(
    'World Map',
    titlePanel("World Map By Dataset"),
    
    #user can choose between prevalence map or mortality map
    radioButtons('data.var', ("Choose a dataset"),
                 choices = list("Deaths" = 1, "Prevalence" = 2), 
                 selected = 1),
    
    sidebarPanel(
      #user can choose year desired for information
      selectInput('year.var', 'Select a Year', 
                  choices = c("2000" = 2000, "2005" = 2005, "2010" = 2010, "2015" = 2015)
      )
    ),
    mainPanel(
      plotlyOutput("map")
    )
  ),
  
  #Shows linegraph of 4 points of infection trends over 15 year span (2000-2015)
  tabPanel(
    "HIV Infections Trends Per Country",
    titlePanel("HIV Infections Trends Per Country"),
     sidebarLayout(
       #sidebar gives selection of all available country data
       sidebarPanel(
         uiOutput("allCountries")
       ),
       mainPanel(
         plotlyOutput('infections')
       )
    )
  ),
 
  #creates scatterplot comparing national GDP to HIV prevalence
  tabPanel(
    "HIV Infections VS. GDP",
    titlePanel("HIV Infections Trends Compare To GDP Per Country"),
    sidebarLayout(
      sidebarPanel(
        #user can input desired year for information
        selectInput('test', 'Select a Year', 
                    choices = c("2000" = 2000, "2005" = 2005, "2010" = 2010, "2015" = 2015)
        )
      ),
      mainPanel(
        plotlyOutput('gdp')
      )
    )
  ),
  #make pie chart of countries in top 10 mortality
  tabPanel(
    'Highest Mortality Chart',
    titlePanel("Pie Chart of Top 10 Highest Recorded Mortality"),
    #user can input desired year for information
    sidebarPanel(
      selectInput('years', 'Select a Year', 
                  choices = c("2000" = 2000, "2005" = 2005, "2010" = 2010, "2015" = 2015)
      )
    ),
    mainPanel(
      plotlyOutput("pie")
    )
  )

))


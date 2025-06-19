# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

# Find out more about building applications with Shiny here:
# https://shiny.posit.co/

# load libraries
library(shiny)
library(bslib)
library(dplyr)
library(DT)
library(openxlsx)
library(rsconnect)


# load dataset
data <- read.csv("DEseq2_lfc_summary_TSS_remove_batch.csv")
str(data)


# Define UI for application that draws a histogram
# UI
ui <- fluidPage(
  titlePanel(
    "Transcriptional and Epigenetic Landscapes in Cellular Quiescence"
  ),

  sidebarLayout(
    sidebarPanel(
      textInput(
        "Gene_name",
        "Enter Gene Name:",
        placeholder = "e.g. SPAC1F8.04c"
      ),
      actionButton("search", "Search")
    ),

    mainPanel(
      DTOutput("result_table")
    )
  )
)

# Server
server <- function(input, output) {
  gene_result <- eventReactive(input$search, {
    req(input$Gene_name)

    data %>%
      filter(Gene_name == input$Gene_name) %>%
      select(
        Geneid,
        Gene_name,
        Chr,
        Start,
        Chromosome,
        RNA_expression,
        log2FoldChange_RNAPolIIS5,
        padj_RNAPolIIS5,
        log2FoldChange_RNAPolIIS2,
        padj_RNAPolIIS2,
        log2FoldChange_H3K4me3,
        padj_H3K4me3,
        log2FoldChange_H3K9ac,
        padj_H3K9ac,
        log2FoldChange_H3K9me2,
        padj_H3K9me2,
        log2FoldChange_H3K9me3,
        padj_H3K9me3,
        log2FoldChange_H2A.Z,
        padj_H2A.Z,
        log2FoldChange_H3,
        padj_H3
      )
  })

  output$result_table <- renderDT({
    datatable(gene_result(), options = list(scrollX = TRUE))
  })
}

# 运行App
shinyApp(ui, server)

rsconnect::setAccountInfo(
  name = 'shengyuan',
  token = '47D27D0488E02E8200775637E9EF8F4B',
  secret = '<SECRET>'
)

library(rsconnect)
rsconnect::deployApp('path/to/your/app')

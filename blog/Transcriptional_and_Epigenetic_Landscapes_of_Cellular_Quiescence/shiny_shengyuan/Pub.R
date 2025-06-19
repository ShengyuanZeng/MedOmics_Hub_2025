##
rsconnect::setAccountInfo(
  name = 'shengyuan',
  token = '47D27D0488E02E8200775637E9EF8F4B',
  secret = '<SECRET>'
)

library(rsconnect)
rsconnect::deployApp(
  '"MedOmics_Hub_2025/blog/Transcriptional_and_Epigenetic_Landscapes_of_Cellular_Quiescence/shiny_shengyuan"'
)

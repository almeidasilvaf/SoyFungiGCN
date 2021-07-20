# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
rm(list=ls(all.names = TRUE))

# Load required objects
# data(genes_modules)
# data(hubs)
# data(scaled_degree)
# genes <- genes_modules$Genes
# plotdata <- vroom::vroom(system.file("extdata", "shiny_netviz_data.tsv",
#                                      package="SoyFungiGCN"),
#                          delim="\t", show_col_types = FALSE)
# plotdata <- as.data.frame(plotdata)
# mod_enrich <- as.data.frame(vroom::vroom(
#     system.file("extdata", "shiny_enrichment.tsv", package="SoyFungiGCN"),
#     delim="\t", show_col_types = FALSE))

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app()

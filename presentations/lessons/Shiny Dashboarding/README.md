Dashboards in Shiny
===================

Phabricator task: [T108732](https://phabricator.wikimedia.org/T108732)

This lesson is aimed at training the Wikidata team to develop a metrics dashboard in R/Shiny.

## Requirements

```{r}
install.packages(c("rmarkdown", "knitr", "shiny", "shinydashboard"))
```

## Extras

```{r}
install.packages("DT")
```

### Visualization

```{r}
install.packages(c("ggplot2", "ggvis", "metricsgraphics", "leaflet", "dygraphs", "networkD3"))
```

#### DiagrammeR and V8

Installing **libv8** (on Mac): `brew tap homebrew/versions; brew install v8-315`

For installing **libv8** on other platforms, see [these instructions](https://github.com/jeroenooms/v8#installation).

```{r}
install.packages(c("DiagrammeR", "htmltools", "V8"))
```

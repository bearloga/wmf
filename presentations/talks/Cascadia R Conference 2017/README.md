# Open knowledge in R with Wikimedia APIs

<a title="By Wikimedia Foundation (Wikimedia Foundation) [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3AWmf_logo_horiz_K.svg"><img width="64" alt="Wmf logo horiz K" src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Wmf_logo_horiz_K.svg/64px-Wmf_logo_horiz_K.svg.png"/></a> <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" /></a>

## Abstract

[Wikimedia Foundation](https://wikimediafoundation.org/wiki/Home)'s APIs include daily and monthly counts of [Wikipedia](https://www.wikipedia.org/) article [pageviews](https://wikitech.wikimedia.org/wiki/Analytics/AQS/Pageviews) and a [SPARQL endpoint](https://www.mediawiki.org/wiki/Wikidata_query_service/User_Manual#SPARQL_endpoint) for [Wikidata Query Service](https://query.wikidata.org/). Additionally, the [MediaWiki](https://www.mediawiki.org/wiki/Manual:What_is_MediaWiki%3F) software comes with an [API](https://www.mediawiki.org/wiki/API:Main_page), so MediaWiki-powered wikis (such as [Project Gutenberg](https://www.gutenberg.org/wiki/Main_Page)) can also be queried. This talk demonstrates how to use existing R packages (e.g. [pageviews](https://cran.r-project.org/package=pageviews), [WikipediR](https://cran.r-project.org/package=WikipediR), [WikidataR](https://cran.r-project.org/package=WikidataR)) to access open knowledge and includes a brief tutorial on querying [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page) with [SPARQL](https://en.wikipedia.org/wiki/SPARQL).

## Dependencies

This is a list of known dependencies:

- **LaTeX**
    - [XeLaTeX](http://xetex.sourceforge.net/)
    - [Metropolis theme](https://github.com/matze/mtheme) ([beamertheme-metropolis](https://ctan.org/pkg/beamertheme-metropolis) on CTAN)
- **R** (>= 3.2.0)
    - Presentation: [R Markdown](http://rmarkdown.rstudio.com/), [knitr](https://yihui.name/knitr/)
    - Essentials: [httr](https://github.com/hadley/httr), [curl](https://github.com/jeroen/curl), [jsonlite](https://github.com/jeroen/jsonlite)
    - API wrappers:
        - [pageviews](https://github.com/ironholds/pageviews) for getting counts of article pageviews
        - [WikipediR](https://github.com/Ironholds/WikipediR) for getting content of MediaWiki articles
        - [WikidataR](https://github.com/Ironholds/WikidataR) for finding and retrieving items and properties
        - [WikidataQueryServiceR](https://github.com/bearloga/WikidataQueryServideR) for querying Wikidata using SPARQL
        - [SPARQL](https://cran.r-project.org/package=SPARQL) and specifying the endpoint URL via:
          `url = "https://query.wikidata.org/bigdata/namespace/wdq/sparql"`

<hr />

This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

library(ggplot2)

hist(trees$Height, col = "gray40",
     main = "Histogram of Height of Black Cheery Trees",
     xlab = "Height (ft)")

hist(trees$Height, col = "gray70",
     main = "Histogram & Smooth Density of Height of Black Cheery Trees",
     xlab = "Height (ft)", freq = FALSE, border = FALSE)
lines(density(trees$Height, adj = 1), lwd = 2)

ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.3, adjust = 2) +
  theme_bw(base_size = 12) +
  labs(x = "Sepal Length (cm)", title = "Distribution of Sepal Length of Species of Iris flowers")

ggplot(data = iris, aes(y = Sepal.Length, x = Species)) +
  geom_boxplot() +
  theme_bw(base_size = 12) +
  labs(y = "Sepal Length (cm)", title = "Distribution of Sepal Length of Species of Iris flowers")

ggplot(data = iris, aes(y = Sepal.Length, x = Species)) +
  geom_violin() +
  theme_bw(base_size = 12) +
  labs(y = "Sepal Length (cm)", title = "Distribution of Sepal Length of Species of Iris flowers")

ggplot(data = iris, aes(y = Sepal.Length, x = Species)) +
  geom_boxplot() +
  theme_bw(base_size = 12) +
  labs(y = "Sepal Length (cm)", title = "Distribution of Sepal Length of Species of Iris flowers")

ggplot(data = iris, aes(y = Sepal.Length, x = Species)) +
  geom_violin(fill = "gray80", color = NA, adjust = 2) +
  geom_boxplot(width = 0.2) +
  theme_bw(base_size = 12) +
  labs(y = "Sepal Length (cm)", title = "Distribution of Sepal Length of Species of Iris flowers")

ggplot(data = trees, aes(x = Girth, y = Volume)) +
  geom_smooth(method = "lm", se = FALSE) +
  geom_point() +
  theme_bw(base_size = 12) +
  labs(title = "Girth and Volume of Black Cheery Trees",
       x = "Tree diameter (in)", y = "Volume of Timber (cubic ft)")

ggplot(data = iris, aes(y = Sepal.Length, x = Petal.Length, color = Species, shape = Species)) +
  geom_point(size = 2) +
  theme_bw(base_size = 12) +
  labs(y = "Sepal Length (cm)", x = "Petal Length (cm)",
       title = "Relationship Between Sepal & Petal Lengths of Iris flowers") +
  theme(legend.position = "bottom")

air_passengers <- data.frame(passengers = as.numeric(AirPassengers), month = 1:12,
                             year = unlist(sapply(1949:1960, rep, times = 12, simplify = FALSE)))
air_passengers$date <- lubridate::ymd(paste(air_passengers$year, air_passengers$month, "1", sep = "-"))
ggplot(data = air_passengers, aes(y = passengers, x = date)) +
  geom_line(color = "gray50") +
  geom_point(size = 0.8) +
  theme_bw(base_size = 12) +
  labs(x = "Time", y = "Passengers (thousands)",
       title = "Monthly totals of international airline passengers",
       subtitle = "1949 to 1960")

mosaicplot(t(margin.table(HairEyeColor, c(1, 3))),
           color = c("black", "brown", "red", "yellow"),
           main = "Mosaic Plot of Men and Women's Hair Colors")
mosaicplot(margin.table(HairEyeColor, c(1, 2)), shade = TRUE,
           main = "Shaded Mosaic Plot of Hair and Eye Colors")
mosaicplot(HairEyeColor,
           main = "Mosaic Plot of Hair and Eye Colors in Women and Men")

# https://learnr.wordpress.com/2010/01/26/ggplot2-quick-heatmap-plotting/
library(reshape2); library(plyr)
base_size <- 12
nba <- read.csv("http://datasets.flowingdata.com/ppg2008.csv")
nba$Name <- with(nba, reorder(Name, PTS))
colnames(nba) <- c("Name", "Games", "Minutes", "Points",
                   "Field goals made", "Field goal attempts", "Field goal %",
                   "Free throws made", "Free throw attempts", "Free throw %",
                   "Three-pointers made", "Three-point attempts", "Three-point %",
                   "Offensive rebounds", "Defensive rebounds", "Total rebounds",
                   "Assists", "Steals", "Blocks", "Turnovers", "PF")
nba$PF <- NULL
nba.m <- melt(nba)
nba.m <- ddply(nba.m, .(variable), transform, rescale = scale(value))
ggplot(nba.m, aes(variable, Name)) +
  geom_tile(aes(fill = rescale), color = "white") +
  scale_fill_gradient(low = "white", high = "steelblue") +
  theme_grey(base_size = base_size) +
  labs(x = "", y = "", title = "NBA per game performance of top 50 scorers", subtitle = "2008-2009 season") +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  theme(legend.position = "none",
       axis.ticks = element_blank(), axis.text.y = element_text(color = "black"),
       axis.text.x = element_text(size = base_size * 0.8, angle = 330, hjust = 0, color = "black"))

plot(mtcars, main = "Scatterplot Matrix of 'Motor Trend' car road tests (1974)")

## Network Graphs via http://kateto.net/network-visualization
install.packages("igraph")
install.packages("network") 
install.packages("sna")
install.packages("ndtv")

# network of hyperlinks and mentions among news sources
nodes <- readr::read_csv("https://raw.githubusercontent.com/kateto/R-Network-Visualization-Workshop/master/Data/Dataset1-Media-Example-NODES.csv")
links <- readr::read_csv("https://raw.githubusercontent.com/kateto/R-Network-Visualization-Workshop/master/Data/Dataset1-Media-Example-EDGES.csv")
links <- aggregate(links[,3], links[,-3], sum)
links <- links[order(links$from, links$to),]
colnames(links)[4] <- "weight"
rownames(links) <- NULL
# links between media venues and consumers.
nodes2 <- readr::read_csv("https://raw.githubusercontent.com/kateto/R-Network-Visualization-Workshop/master/Data/Dataset2-Media-User-Example-NODES.csv")
links2 <- readr::read_csv("https://raw.githubusercontent.com/kateto/R-Network-Visualization-Workshop/master/Data/Dataset2-Media-User-Example-EDGES.csv")
links2 <- as.matrix(links2)

library(igraph)
net <- graph.data.frame(links, nodes, directed=T)
net <- simplify(net, remove.multiple = F, remove.loops = T)
plot(net, edge.arrow.size = .5, edge.color = "orange", main = "Directed Network Graph",
     vertex.color="orange", vertex.frame.color="#ffffff",
     vertex.label=V(net)$media, vertex.label.color="black")
title(sub = "Links and mentions between news sources")

plot(net, layout = layout.circle(net), vertex.label=V(net)$media, edge.arrow.size = 0,
     edge.color = "orange", vertex.color="orange", vertex.frame.color="#ffffff", vertex.label.color="black",
     main = "Undirected Network Graph (Circular Layout")
title(sub = "Links and mentions between news sources")

op = par(mar = c(0.5, 10, 0.5, 3))
arcplot(as.matrix(links[, 1:2]), labels = V(net)$media, horizontal = FALSE, col.labels = "black")
title(main = "Arc Diagram Plot", sub = "Links and mentions between news sources")
par(op)

library(ggcounty) # devtools::install_github("hrbrmstr/ggcounty")
# built-in US population by FIPS code data set
data(population, package = "ggcounty")
# define appropriate (& nicely labeled) population breaks
population$brk <- cut(population$count, 
                      breaks=c(0, 100, 1000, 10000, 100000, 1000000, 10000000), 
                      labels=c("0-99", "100-1K", "1K-10K", "10K-100K", 
                               "100K-1M", "1M-10M"),
                      include.lowest=TRUE)

# get the US counties map (lower 48)
us <- ggcounty.us()
# start the plot with our base map
gg <- us$g
# add a new geom with our population (choropleth)
gg <- gg + geom_map(data=population, map=us$map,
                    aes(map_id=FIPS, fill=brk), 
                    color="white", size=0.125)
# define nice colors
gg <- gg + scale_fill_manual(values=c("#ffffcc", "#c7e9b4", "#7fcdbb", 
                                      "#41b6c4", "#2c7fb8", "#253494"), 
                             name="Population", guide = guide_legend(nrow = 1))
# plot the map
gg +
  ggtitle("U.S. population by county",
          subtitle = "A choropleth is a map shaded/patterned according to some statistical variable.") +
  ggthemes::theme_map(base_size = 14) +
  theme(legend.position = "bottom")

library(dplyr)
data(population, package = "ggcounty")
population$brk <- cut(population$count, 
                      breaks=c(0, 100, 1000, 10000, 100000, 1000000, 10000000), 
                      labels=c("0-99", "100-1K", "1K-10K", "10K-100K", 
                               "100K-1M", "1M-10M"),
                      include.lowest=TRUE)

temp <- population %>%
  sample_frac(0.25) %>%
  group_by(brk) %>%
  summarize(n = n()) %>%
  mutate(prop = n/sum(n))
temp$se <- sqrt((temp$prop * (1-temp$prop))/temp$n)
temp$lower <- pmax(0, temp$prop + qnorm(0.025) * temp$se)
temp$upper <- pmin(1, temp$prop + qnorm(0.975) * temp$se)

temp %>%
  ggplot(aes(x = brk, y = prop)) +
  geom_bar(stat = "identity", position = "dodge", fill = "cornflowerblue") +
  labs(y = "Counties in U.S.", x = "Population") +
  geom_errorbar(aes(ymax = upper, ymin = lower), width = 0.25) +
  scale_y_continuous(labels = scales::percent_format()) +
  ggthemes::theme_tufte(base_size = 14, base_family = "Gill Sans")

population %>%
  group_by(brk) %>%
  summarize(n = n()) %>%
  mutate(prop = n/sum(n)) %>%
  ggplot(aes(x = "", y = n, fill = brk)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(y = "Counties in U.S.", x = NULL) +
  scale_fill_brewer("Population", type = "qual", palette = "Set1") +
  geom_text(aes(label = sprintf("%.0f (%.1f%%)", n, 100*prop), vjust = -1), position = position_dodge(width = 1)) +
  ggthemes::theme_tufte(base_size = 14, base_family = "Gill Sans")

population %>%
  group_by(brk) %>%
  summarize(n = n()) %>%
  mutate(prop = n/sum(n)) %>%
  ggplot(aes(x = factor(1), y = prop, fill = brk)) +
  geom_bar(stat = "identity", position = "stack", width = 1) +
  scale_fill_brewer("Population", type = "qual", palette = "Set1") +
  # geom_text(aes(label = sprintf("%.1f%%", 100*prop), y = cumsum(prop))) +
  coord_polar(theta = "y") +
  ggthemes::theme_tufte(base_size = 12, base_family = "Gill Sans") +
  labs(x = NULL, y = NULL, title = "Pie Chart of Counties in U.S. by Population") +
  theme(axis.title = element_blank(), axis.ticks = element_blank(), axis.text = element_blank())

population %>%
  rename(Population = brk) %>%
  group_by(Population) %>%
  summarize(Counties = n()) %>%
  mutate(Proportion = Counties/sum(Counties)) %>%
  knitr::kable(digits = 3, format = "html")

library(gcookbook) # install.packages("gcookbook")
library(cowplot)

p1 <- ggplot(uspopage, aes(y = Thousands, x = Year, fill = AgeGroup)) +
  geom_area(color = "black") +
  scale_y_continuous("Number of people in thousands", labels = polloi::compress) +
  scale_fill_discrete(breaks = rev(levels(uspopage$AgeGroup))) +
  ggtitle("Age distribution of population in the United States, 1900-2002") +
  ggthemes::theme_tufte(base_size = 12, base_family = "Gill Sans")
p2 <- ggplot(uspopage, aes(y = Thousands, x = Year, fill = AgeGroup)) +
  geom_area(color = "black", position = "fill") +
  scale_y_continuous("Proportion", labels = scales::percent_format()) +
  scale_fill_discrete(breaks = rev(levels(uspopage$AgeGroup))) +
  ggtitle("Age distribution of population in the United States, 1900-2002") +
  ggthemes::theme_tufte(base_size = 12, base_family = "Gill Sans")
plot_grid(p1, p2, nrow = 1)

set.seed(0)
x <- sample(1:100, 500, replace = TRUE)
slope <- 0.01; intercept <- runif(1, 0, 1); err.std <- runif(1, 0.01, 0.1)
noise <- rnorm(length(x), 0, sd = err.std)
y <- intercept + slope * x + noise
plot(x, y)
df <- data.frame(x = x, y = 10^y)
p1 <- ggplot(df, aes(x = y)) + geom_histogram(aes(y = ..density..), fill = "gray70") + geom_density(adjust = 2) + theme_gray() + ggtitle("Distribution of y is right skewed")
p2 <- ggplot(df, aes(x = log10(y))) + geom_histogram(aes(y = ..density..), fill = "gray70") + geom_density(adjust = 2) + theme_gray() + ggtitle("Distribution of transformed y is Normally distributed")
p3 <- ggplot(df, aes(x = x, y = y)) + geom_point() + ggtitle("Not a linear relationship between x and y") + theme_gray() + geom_smooth(se = FALSE, method = "lm", color = "#e91d63", size = 2)
p4 <- ggplot(df, aes(x = x, y = log10(y))) + geom_point() + ggtitle("Linear relationship between x and transformed y") + theme_gray() + geom_smooth(se = FALSE, method = "lm", color = "#e91d63", size = 2)
plot_grid(plotlist = list(p1, p2, p3, p4))

library(radarchart) # install.packages("radarchart")
df <- data.frame(Label = c("Writing", "Child-friendly", "Acting", "Art Direction", "Rewatchability", "Fun"),
                 `X-Men: Apocalypse` = c(2, 1, 3, 3, 4, 5),
                 `Man From U.N.C.L.E.` = c(4, 0, 5, 4, 2, 4),
                 `Zootopia` = c(5, 5, 5, 5, 2, 5))
chartJSRadar(scores = df, colMatrix = col2rgb(RColorBrewer::brewer.pal(3, "Set1")), showToolTipLabel = TRUE)

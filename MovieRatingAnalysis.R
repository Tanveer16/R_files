## section 6

moviedata <- read.csv(choose.files())
moviedata
head(moviedata)
colnames(moviedata) <- c("Film","Genre","CriticRating","AudienceRating","Budget","Year")
head(moviedata)
summary(moviedata)

factor(moviedata$Year)
moviedata$Year <- factor(moviedata$Year)
summary(moviedata)

## ------------aesthetics
install.packages("ggplot2")
library(ggplot2)
?ggplot

ggplot(data = moviedata, aes(x=CriticRating,y=AudienceRating))

## ----add geometries

ggplot(data = moviedata, aes(x=CriticRating,y=AudienceRating)) +
  geom_point()

##---- add color
ggplot(data = moviedata, aes(x=CriticRating,y=AudienceRating,colour=Genre)) +
  geom_point()

##------ add size
ggplot(data = moviedata, aes(x=CriticRating,y=AudienceRating,colour=Genre,size=Budget)) +
  geom_point()


##-----------Working with layers

p <- ggplot(data = moviedata, aes(x=CriticRating,y=AudienceRating,colour=Genre,size=Budget))
p

## ----adding point..  plotting with layers
p + geom_point()


## ------adding lines
p + geom_line()

## multiple layers
p + geom_point()

###----- histograms 

s <- ggplot(data = moviedata, aes(x=Budget))
s + geom_histogram(binwidth = 10)
s + geom_histogram(binwidth = 10,fill='Green')

s + geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")


###- ---- density charts
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position = "Stack") 


## additional tips of layers
head(moviedata)
t <- ggplot(data=moviedata,aes(x=AudienceRating))
t + geom_histogram(binwidth = 10, fill='White',colour='Black')

## ALTERNATE WAY FOR ABove histogram
q <- ggplot(data=moviedata)
q + geom_histogram(binwidth = 10, aes(x=AudienceRating),alpha=0.5,fill='white',colour='Blue')

## you can change variables in second way

q + geom_histogram(binwidth = 10, aes(x=CriticRating),alpha=0.5,fill='white',colour='Red')


##.......  using statistical transformations

?geom_smooth

u <- ggplot(data = moviedata,aes(x = CriticRating,y = AudienceRating,
                                 colour=Genre))
u + geom_point()

u + geom_point()+geom_smooth()
u + geom_point(alpha=0.4)+geom_smooth(fill=NA,size=1)


## box plots

v <- ggplot(data = moviedata,aes(x = Genre,y = AudienceRating,
                                 colour=Genre))
v + geom_boxplot(size=1.2) + geom_point()

## using jitter
v + geom_boxplot(size=1.2) + geom_jitter(size=0.8)
v + geom_jitter(size=0.8) + geom_boxplot(alpha=0.5)  ##changing layers, now boxplotis placed above jitters


## using facets
head(moviedata)
vv <- ggplot(data=moviedata,aes(x=Budget))
vv + geom_histogram(binwidth = 10,aes(fill=Genre),
                    colour='Black') ##so far this is without facets, now we want to see histogram for all genres

vv + geom_histogram(binwidth = 10,aes(fill=Genre),
                    colour='Black') + 
  facet_grid(Genre~.,scales = "free")

vv + geom_histogram(binwidth = 10,aes(fill=Genre),
                    colour='Black') + 
  facet_grid(Genre~.,scales = "free")

## ----------applying to scatters
w <- ggplot(data = moviedata,aes(x = CriticRating,y = AudienceRating,
                                      colour=Genre))
w + geom_point(alpha=0.5)+
  geom_smooth()+
  facet_grid(Genre~.)

w + geom_point(alpha=0.5)+
  geom_smooth()+
  facet_grid(Genre~Year)

w + geom_point(aes(size=Budget),alpha=0.6)+
  geom_smooth()+
  facet_grid(Genre~Year)

## improving co-ordinates or axes now
m <- ggplot(data = moviedata, aes(x=CriticRating,y=AudienceRating,
                                  size=Budget,
                                  colour=Genre))
m + geom_point()

m + geom_point() +
  xlim(50,100)  ####removed all points below 50 on x axis

m + geom_point() +
  xlim(50,100) + ylim(50,100)

##xlim, ylim filters data from viz instead use coord-cartesian which zooms in desired area

##lets take our w variable 


w + geom_point(aes(size=Budget),alpha=0.6)+
  geom_smooth()+
  facet_grid(Genre~Year)

w + geom_point(aes(size=Budget),alpha=0.6)+
  geom_smooth()+
  facet_grid(Genre~Year) +
  coord_cartesian(ylim = c(0,100))

s + geom_histogram(binwidth = 10,aes(fill=Genre),
                   colour="Black") + 
  xlab("Money axis") + ylab("No of Movies") +
  theme(axis.title.x = element_text(colour = "Dark Green",size=25),
        axis.title.y = element_text(colour="Red",size=25),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size = 15))

##--------------updating legends

s + geom_histogram(binwidth = 10,aes(fill=Genre),
                   colour="Black") + 
  xlab("Money axis") + ylab("No of Movies") +
  theme(axis.title.x = element_text(colour = "Dark Green",size=25),
        axis.title.y = element_text(colour="Red",size=25),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size = 15),
        legend.title = element_text(size=15),
        legend.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1,1))


##----------- adding title

s + geom_histogram(binwidth = 10,aes(fill=Genre),
                   colour="Black") + 
  xlab("Money axis") + ylab("No of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour="Dark Green",size=20),
        axis.title.y = element_text(colour="Red",size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size = 15),
        
        legend.title = element_text(size=15),
        legend.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(colour = "DarkBlue",
                                  size=20,
                                  family = "Courier"))

# Q1

#find the intersect between gdp and ed datasets, where there is a numeric value under gdp$Gross.domestic.product.2012
new_gdp <- gdp[5:194,]
new_gdp <- mutate(new_gdp, GDPValue = as.numeric(as.character(Gross.domestic.product.2012)))
index <- which((new_gdp$X %in% ed$CountryCode))


# Q3

# arrange data frame by rank of gdp in descending order and find 13th lowest rank country
d <- new_gdp %>% 
    select(X, X.2, GDPValue) %>%
    arrange(desc(GDPValue))

d[13,"X.2"]


# Q4

# group gdp ranking by High:Income OECD and High Income: non-OECD and calcuate the average of eahc group
# to complete task, join the two data sets new_gdp and ed by common country code (new_gdp$X, ed$CountryCode)
# and then group and average on joined dataset

# change name of X in new_gdp to CountryCode for the join
colnames(new_gdp)[1] = "CountryCode"
jdata <- inner_join(new_gdp, ed, by = "CountryCode")

gdata <- group_by(jdata, Income.Group) %>%
        summarise(mean(GDPValue)) %>%
        print


# Q5

# cut the joined data (jdata) by quantile GDP ranking, make table of Income.Group
# how many countries in lower middle income among the 38 highest nations.

jdata$GDPQuantile <- cut(jdata$GDPValue, quantile(jdata$GDPValue, probs = seq(0,1,0.2)))
    table(jdata$GDPQuantile, jdata$Income.Group)
    
    
    
    
    
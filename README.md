# R client for the COLOURlovers API #

[![Build Status](https://travis-ci.org/leeper/colourlovers.png?branch=master)](https://travis-ci.org/leeper/colourlovers)

The **colourlovers** package connects R to the [COLOURlovers](http://www.colourlovers.com/) API. COLOURlovers is a social networking site for sharing colors, color palettes, and color-rich visual designs. The social networking features of the site mean that COLOURlovers provides not only rich, original color palettes to use in R graphics but also provides ratings and community evaluations of those palettes, helpings R graphics designers to utilize visually pleasing color combinations.

## License ##

The **colourlovers** package is released under GPL-2, while the COLOURlovers community-generated data returned by the API is available under the [Creative Commons Attribution-NonCommercial-ShareAlike 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/) license.

## Installation ##

You can <!--find a stable release on [CRAN](http://cran.r-project.org/web/packages/colourlovers/index.html), or--> install the latest development version from GitHub using [Hadley's](http://had.co.nz/) [devtools](http://cran.r-project.org/web/packages/devtools/index.html) package:
```
# install.packages("devtools")
library("devtools")
install_github("leeper/colourlovers")
```

## Functionality ##

The API functionality is broken down into five categories: colors, palettes, patterns, lovers, and statistics. The next sections provide examples of each.

### Get Colors ###

### Get Palettes ###

### Get Patterns (Designs) ###

### Get Lovers (Users) ###

**colourlovers** provides two functions for viewing information about COLOURlovers use. One, `cllovers` (in plural form), serves as a limited search function for identifying users. The function provides an argument `set` to identify "new" or "top"-rated users, sorted by one or more attributes.

```
> cllovers(set='top', fmt='json')
Lover username:      Estefaniamartial 
Registered:          2012-11-07 21:50:45 
Last active:         2013-04-15 15:54:55 
Rating:              16777215 
Location:             
Colors:              146 
Palettes:            1 
Patterns:            163 
Comments made:       0 
Lovers:              4 
Comments on profile: 0 
URL:                 http://www.colourlovers.com/lover/Estefaniamartial 
API URL:             http://www.colourlovers.com/api/lover/Estefaniamartial 

Lover username:      GRR 
Registered:          2012-06-02 23:41:18 
Last active:         2012-07-03 00:00:10 
Rating:              16777215 
Location:             
Colors:              0 
Palettes:            0 
Patterns:            0 
Comments made:       22 
Lovers:              1 
Comments on profile: 2 
URL:                 http://www.colourlovers.com/lover/GRR 
API URL:             http://www.colourlovers.com/api/lover/GRR 

...
```

The other function, `cllover` (in singular form), pulls the same information for a named user.

```
> cllover('COLOURlovers', fmt='json')
Lover username:      colourlovers 
Registered:          2007-09-11 02:44:32 
Last active:         2011-07-21 12:26:10 
Rating:              0 
Location:             
Colors:              0 
Palettes:            0 
Patterns:            0 
Comments made:       0 
Lovers:              0 
Comments on profile: 0 
URL:                 http://www.colourlovers.com/lover/colourlovers 
API URL:             http://www.colourlovers.com/api/lover/colourlovers
```


### Get Statistics ###

**colourlovers** provides a function, `clstats`, to return basic counts of available colors, palettes, patterns, and lovers. There is no obvious R application for this information, but is provided for the sake of completeness.

```
> clstats('colors')
Total colors: 7207630
> clstats('palettes')
Total palettes: 3217973
> clstats('patterns')
Total patterns: 4106345
> clstats('lovers')
Total lovers: 4116021
```

## Using colourlovers in R graphics ##

COMING SOON
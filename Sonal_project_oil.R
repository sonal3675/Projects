{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Loading respositories"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Loading required package: pacman\n"
     ]
    }
   ],
   "source": [
    "\n",
    "\n",
    "if (!require(pacman)) install.packages(\"pacman\")\n",
    "\n",
    "pacman::p_load(\"tidyverse\",\"sf\",\"rvest\",\"stringr\",\"scales\",\"xml2\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# loading data from Wikipedia table"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col></th><th scope=col>Country</th><th scope=col>Oil Production(bbl/day)[1]</th><th scope=col>Oil Production per capita(bbl/day/ million people)[5]</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>-                  </td><td>World Production   </td><td>80,622,000         </td><td>10,798             </td></tr>\n",
       "\t<tr><td>01                 </td><td>United States[6]   </td><td>12,000,000         </td><td>35,922             </td></tr>\n",
       "\t<tr><td>02                 </td><td>Russia             </td><td>11,200,000         </td><td>73,292             </td></tr>\n",
       "\t<tr><td>03                 </td><td>Saudi Arabia (OPEC)</td><td>10,460,710         </td><td>324,866            </td></tr>\n",
       "\t<tr><td>04                 </td><td>Iraq (OPEC)        </td><td>4,451,516          </td><td>119,664            </td></tr>\n",
       "\t<tr><td>05                 </td><td>Iran (OPEC)        </td><td>3,990,956          </td><td>49,714             </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|llll}\n",
       "  & Country & Oil Production(bbl/day){[}1{]} & Oil Production per capita(bbl/day/ million people){[}5{]}\\\\\n",
       "\\hline\n",
       "\t -                   & World Production    & 80,622,000          & 10,798             \\\\\n",
       "\t 01                      & United States{[}6{]}    & 12,000,000              & 35,922                 \\\\\n",
       "\t 02                  & Russia              & 11,200,000          & 73,292             \\\\\n",
       "\t 03                  & Saudi Arabia (OPEC) & 10,460,710          & 324,866            \\\\\n",
       "\t 04                  & Iraq (OPEC)         & 4,451,516           & 119,664            \\\\\n",
       "\t 05                  & Iran (OPEC)         & 3,990,956           & 49,714             \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "|  | Country | Oil Production(bbl/day)[1] | Oil Production per capita(bbl/day/ million people)[5] |\n",
       "|---|---|---|---|\n",
       "| -                   | World Production    | 80,622,000          | 10,798              |\n",
       "| 01                  | United States[6]    | 12,000,000          | 35,922              |\n",
       "| 02                  | Russia              | 11,200,000          | 73,292              |\n",
       "| 03                  | Saudi Arabia (OPEC) | 10,460,710          | 324,866             |\n",
       "| 04                  | Iraq (OPEC)         | 4,451,516           | 119,664             |\n",
       "| 05                  | Iran (OPEC)         | 3,990,956           | 49,714              |\n",
       "\n"
      ],
      "text/plain": [
       "     Country             Oil Production(bbl/day)[1]\n",
       "1 -  World Production    80,622,000                \n",
       "2 01 United States[6]    12,000,000                \n",
       "3 02 Russia              11,200,000                \n",
       "4 03 Saudi Arabia (OPEC) 10,460,710                \n",
       "5 04 Iraq (OPEC)         4,451,516                 \n",
       "6 05 Iran (OPEC)         3,990,956                 \n",
       "  Oil Production per capita(bbl/day/ million people)[5]\n",
       "1 10,798                                               \n",
       "2 35,922                                               \n",
       "3 73,292                                               \n",
       "4 324,866                                              \n",
       "5 119,664                                              \n",
       "6 49,714                                               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "\n",
    "data_oil <- read_html(\"https://en.wikipedia.org/wiki/List_of_countries_by_oil_production\") %>%\n",
    "  html_nodes(\"table\") %>%\n",
    "  .[[1]] %>%\n",
    "  html_table()\n",
    "head(data_oil)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Data manipulation \n",
    "#### Renaming variables to our ease"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>'Ranking'</li>\n",
       "\t<li>'Country'</li>\n",
       "\t<li>'Oil_production_bbl/day'</li>\n",
       "\t<li>'Oil_production_per_captia_bbl/day/million'</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Ranking'\n",
       "\\item 'Country'\n",
       "\\item 'Oil\\_production\\_bbl/day'\n",
       "\\item 'Oil\\_production\\_per\\_captia\\_bbl/day/million'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Ranking'\n",
       "2. 'Country'\n",
       "3. 'Oil_production_bbl/day'\n",
       "4. 'Oil_production_per_captia_bbl/day/million'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"Ranking\"                                  \n",
       "[2] \"Country\"                                  \n",
       "[3] \"Oil_production_bbl/day\"                   \n",
       "[4] \"Oil_production_per_captia_bbl/day/million\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "\n",
    "colnames(data_oil)\n",
    "colnames(data_oil) <- c(\"Ranking\", \"Country\",\"Oil_production_bbl/day\",\"Oil_production_per_captia_bbl/day/million\")\n"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "#### Making a new dataframe excluding the observation for the entire world"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "\n",
    "data_oil_countries <- data_oil[2:nrow(data_oil),]\n",
    "sapply(data_oil_countries,class)\n",
    "head(data_oil)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "#### Removing commas"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>'12000000'</li>\n",
       "\t<li>'11200000'</li>\n",
       "\t<li>'10460710'</li>\n",
       "\t<li>'4451516'</li>\n",
       "\t<li>'3990956'</li>\n",
       "\t<li>'3980650'</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item '12000000'\n",
       "\\item '11200000'\n",
       "\\item '10460710'\n",
       "\\item '4451516'\n",
       "\\item '3990956'\n",
       "\\item '3980650'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. '12000000'\n",
       "2. '11200000'\n",
       "3. '10460710'\n",
       "4. '4451516'\n",
       "5. '3990956'\n",
       "6. '3980650'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"12000000\" \"11200000\" \"10460710\" \"4451516\"  \"3990956\"  \"3980650\" "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>'35922'</li>\n",
       "\t<li>'73292'</li>\n",
       "\t<li>'324866'</li>\n",
       "\t<li>'119664'</li>\n",
       "\t<li>'49714'</li>\n",
       "\t<li>'2836'</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item '35922'\n",
       "\\item '73292'\n",
       "\\item '324866'\n",
       "\\item '119664'\n",
       "\\item '49714'\n",
       "\\item '2836'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. '35922'\n",
       "2. '73292'\n",
       "3. '324866'\n",
       "4. '119664'\n",
       "5. '49714'\n",
       "6. '2836'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"35922\"  \"73292\"  \"324866\" \"119664\" \"49714\"  \"2836\"  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "\n",
    "data_oil_countries <- data_oil_countries %>% mutate(Ranking=as.integer(Ranking))\n",
    "data_oil_countries <- data_oil_countries %>% mutate(`Oil_production_bbl/day`=str_replace_all(`Oil_production_bbl/day`,\",\",\"\"))\n",
    "head(data_oil_countries$`Oil_production_bbl/day`)\n",
    "data_oil_countries <- data_oil_countries %>% mutate(`Oil_production_per_captia_bbl/day/million`=str_replace_all(`Oil_production_per_captia_bbl/day/million`,\",\",\"\"))\n",
    "head(data_oil_countries$`Oil_production_per_captia_bbl/day/million`)\n",
    "\n"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "#### Creating indicator variable for OPEC members"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "###### The Organization of the Petroleum Exporting Countries (OPEC, /ˈoʊpɛk/ OH-pek) is an intergovernmental organisation of 14 nations, founded in 1960 in Baghdad by the first five members. As of September 2018, the then 15 member countries accounted for an estimated 44 percent of global oil production and 81.5 percent of the world's \"proven\" oil reserves, giving OPEC a major influence on global oil prices that were previously determined by the so called \"Seven Sisters” grouping of multinational oil companies. The stated mission of the organisation is to \"coordinate and unify the petroleum policies of its member countries and ensure the stabilization of oil markets, in order to secure an efficient, economic and regular supply of petroleum to consumers, a steady income to producers, and a fair return on capital for those investing in the petroleum industry.\"\n"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "###### The organization is also a significant provider of information about the international oil market. The current OPEC members are the following: Algeria, Angola, Ecuador, Equatorial Guinea, Gabon, Iran, Iraq, Kuwait, Libya, Nigeria, the Republic of the Congo, Saudi Arabia (the de facto leader), United Arab Emirates, and Venezuela. Indonesia and Qatar are former members."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>Ranking</th><th scope=col>Country</th><th scope=col>Oil_production_bbl/day</th><th scope=col>Oil_production_per_captia_bbl/day/million</th><th scope=col>OPEC</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>01                 </td><td>United States[6]   </td><td>12,000,000         </td><td>35,922             </td><td>0                  </td></tr>\n",
       "\t<tr><td>02                 </td><td>Russia             </td><td>11,200,000         </td><td>73,292             </td><td>0                  </td></tr>\n",
       "\t<tr><td>03                 </td><td>Saudi Arabia (OPEC)</td><td>10,460,710         </td><td>324,866            </td><td>1                  </td></tr>\n",
       "\t<tr><td>04                 </td><td>Iraq (OPEC)        </td><td>4,451,516          </td><td>119,664            </td><td>1                  </td></tr>\n",
       "\t<tr><td>05                 </td><td>Iran (OPEC)        </td><td>3,990,956          </td><td>49,714             </td><td>1                  </td></tr>\n",
       "\t<tr><td>06                 </td><td>China              </td><td>3,980,650          </td><td>2,836              </td><td>0                  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|lllll}\n",
       " Ranking & Country & Oil\\_production\\_bbl/day & Oil\\_production\\_per\\_captia\\_bbl/day/million & OPEC\\\\\n",
       "\\hline\n",
       "\t 01                      & United States{[}6{]}    & 12,000,000              & 35,922                  & 0                      \\\\\n",
       "\t 02                  & Russia              & 11,200,000          & 73,292              & 0                  \\\\\n",
       "\t 03                  & Saudi Arabia (OPEC) & 10,460,710          & 324,866             & 1                  \\\\\n",
       "\t 04                  & Iraq (OPEC)         & 4,451,516           & 119,664             & 1                  \\\\\n",
       "\t 05                  & Iran (OPEC)         & 3,990,956           & 49,714              & 1                  \\\\\n",
       "\t 06                  & China               & 3,980,650           & 2,836               & 0                  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "| Ranking | Country | Oil_production_bbl/day | Oil_production_per_captia_bbl/day/million | OPEC |\n",
       "|---|---|---|---|---|\n",
       "| 01                  | United States[6]    | 12,000,000          | 35,922              | 0                   |\n",
       "| 02                  | Russia              | 11,200,000          | 73,292              | 0                   |\n",
       "| 03                  | Saudi Arabia (OPEC) | 10,460,710          | 324,866             | 1                   |\n",
       "| 04                  | Iraq (OPEC)         | 4,451,516           | 119,664             | 1                   |\n",
       "| 05                  | Iran (OPEC)         | 3,990,956           | 49,714              | 1                   |\n",
       "| 06                  | China               | 3,980,650           | 2,836               | 0                   |\n",
       "\n"
      ],
      "text/plain": [
       "  Ranking Country             Oil_production_bbl/day\n",
       "1 01      United States[6]    12,000,000            \n",
       "2 02      Russia              11,200,000            \n",
       "3 03      Saudi Arabia (OPEC) 10,460,710            \n",
       "4 04      Iraq (OPEC)         4,451,516             \n",
       "5 05      Iran (OPEC)         3,990,956             \n",
       "6 06      China               3,980,650             \n",
       "  Oil_production_per_captia_bbl/day/million OPEC\n",
       "1 35,922                                    0   \n",
       "2 73,292                                    0   \n",
       "3 324,866                                   1   \n",
       "4 119,664                                   1   \n",
       "5 49,714                                    1   \n",
       "6 2,836                                     0   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "data_oil_countries <- data_oil_countries %>% mutate(OPEC=if_else(str_detect(Country,\"OPEC\"),1,0))\n",
    "head(data_oil_countries)\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "3.5.2"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 2
}

if (!require("pacman")) {
  install.packages("pacman")
}
## pacman::p_load(plyr, stringr, RODBC, RODBCext, sendmailR, tools)
## pacman::p_load(plyr, stringr, sendmailR, tools)
##pacman::p_load(stringr, argparse, stats, tibble)
pacman::p_load(stringr, argparser, xml2)


##################################################################################################################################################
##################################################################################################################################################
## init
##################################################################################################################################################
##################################################################################################################################################
setwd("/_gitcarlos/SyncXmlStringFiles")


## Remove all data loaded into the workspace. Make it easier to debug
rm(list=ls(all=TRUE))


##################################################################################################################################################
##################################################################################################################################################
# Parse command line arguments
# create parser object
aparser <- argparser::arg_parser("Synchronize the XML string files")

# specify our desired options 
# by default ArgumentParser will add an help option 
aparser <- argparser::add_argument(parser=aparser, short="i1", arg="inputfile1",    help="First input file")
aparser <- argparser::add_argument(parser=aparser, short="o1", arg="outputfile1",   help="First output file")

aparser <- argparser::add_argument(parser=aparser, short="i2", arg="inputfile2",    help="Second input file")
aparser <- argparser::add_argument(parser=aparser, short="o2", arg="outputfile2",   help="Second output file")


# get command line options, if help option encountered print help and exit,
# otherwise if options not found on command line then set defaults, 

# Uncomment to use command line
argv <- parse_args(aparser)

# test data
#args <- argparser::parse_args(aparser, c(
#  "values/strings.xml",      # input file 1
#  "values/strings.2.xml",    # output file 1
#  "values-en/strings.xml",   # input file 2
#  "values-en/strings.2.xml"  # output file 2
#))

##################################################################################################################################################
##################################################################################################################################################
## Load our files
i1 <- xml2::read_xml(args$inputfile1)
i2 <- xml2::read_xml(args$inputfile2)


idf1 <- data.frame(
  "name" = xml_attr(xml_children(i1), "name"),
  "translatable" = xml_attr(xml_children(i1), "translatable"),
  "text" = xml_text(xml_children(i1)),
  "xml" = as.character(xml_children(i1)),
  stringsAsFactors = FALSE
)


idf2 <- data.frame(
  "name" = xml_attr(xml_children(i2), "name"),
  "translatable" = xml_attr(xml_children(i2), "translatable"),
  "text" = xml_text(xml_children(i2)),
  "xml" = as.character(xml_children(i2)),
  stringsAsFactors = FALSE
)



if (any(duplicated(idf1$name)) || any(duplicated(idf2$name))) stop("duplcate string names")



rm(list = c("i1", "i2"))


odf1 <- rbind(idf1, idf2[!(idf2$name %in% idf1$name),])
odf2 <- rbind(idf2, idf1[!(idf1$name %in% idf2$name),])


odf1 <- odf1[order(odf1$name),]
odf2 <- odf2[order(odf2$name),]


## We have the strings and know the format. It's just easier to write it out as a text
##  file rather than trying to build a new XML file.
o1 <- c("<?xml version=\"1.0\" encoding=\"utf-8\"?>", "<resources>", odf1$xml, "</resources>")
o2 <- c("<?xml version=\"1.0\" encoding=\"utf-8\"?>", "<resources>", odf2$xml, "</resources>")


write(o1, file = args$outputfile1)
write(o2, file = args$outputfile2)

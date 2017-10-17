## Synopsis

Synchronize/merge two Android strings.xml language files. For example, your English and Spanish strings.xml files get out of sync.
* Entries existing in one but not the other will be copied over.
* Entries will be sorted.


## Code Example


Prior to synchronizing/merging


| English strings.xml | Spanish strings.xml |
| ------ | ------ |
| &lt;string name="action_calc"&gt;Calculator&lt;/string&gt; | &lt;string name="action_calc"&gt;Calculadora&lt;/string&gt; |
|  | &lt;string name="action_tool"&gt;Herramienta&lt;/string&gt; |
| &lt;string name="action_config"&gt;Configuration&lt;/string&gt; |  |


After synchronizing/merging. NOTE: Entries sorted by "name"


| English strings.xml | Spanish strings.xml |
| ------ | ------ |
| &lt;string name="action_calc"&gt;Calculator&lt;/string&gt; | &lt;string name="action_calc"&gt;Calculadora&lt;/string&gt; |
| &lt;string name="action_config"&gt;Configuration&lt;/string&gt; | &lt;string name="action_config"&gt;Configuration&lt;/string&gt; |
| &lt;string name="action_tool"&gt;Herramienta&lt;/string&gt; | &lt;string name="action_tool"&gt;Herramienta&lt;/string&gt; |



## Motivation

I was tasked with translating an Android app whose language resources were out of sync. Each strings.xml language file contained hundreds of entries. Some entries existed in one file but not the other file. Merging them by hand was too time consuming.



## Usage

rscript syncXmlStringFiles.R input1 output1 input2 output2

The input files are loaded into the app. The contents merged. Then sorted. Then written to the output files.

inputX and outputX can be the same. If they are, then the file is overwritten.


## Tests

You can use command line arguments or hard coded paths to file during your testing and development my modifying the lines below:

```
# Uncomment to use command line
argv <- parse_args(aparser)

# test data
#args <- argparser::parse_args(aparser, c(
#  "values/strings.xml",      # input file 1
#  "values/strings.2.xml",    # output file 1
#  "values-en/strings.xml",   # input file 2
#  "values-en/strings.2.xml"  # output file 2
#))
```



## Contributors

Carlos Klapp

## License

MIT License

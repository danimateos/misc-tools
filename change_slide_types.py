#! /usr/bin/env python

import json
import sys

inpath = sys.argv[1]
outpath = sys.argv[2]

infile = open(inpath)
notebook = json.load(infile)

for cell in notebook["cells"]:

    # Only start slides with title 1 and title 2 cells.
    if cell["cell_type"] == "markdown" and (cell["source"][0].startswith("# ") or cell["source"][0].startswith("## ")):

        if "slideshow" not in cell["metadata"]:
            cell["metadata"]["slideshow"] = {"slide_type": "slide"}
        else:
            cell["metadata"]["slideshow"]["slide_type"] == "slide"
            
    else:
        if "slideshow" not in cell["metadata"]:
            cell["metadata"]["slideshow"] = {"slide_type": "fragment"}
        else:
            cell["metadata"]["slideshow"]["slide_type"] == "fragment"
            
    
with open(outpath, 'w') as out:

    json.dump(notebook, out)

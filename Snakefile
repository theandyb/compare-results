docs, = glob_wildcards("doc/{file}.md")

rule all:
	input:
		expand("doc/{file}.html", file=docs)

rule buildDocs:
	input:
		md="doc/{file}.md"
	output:
		"doc/{file}.html"
	shell:
		"pandoc {input.md} -f markdown -t html --css=pandoc.css -s -o {output}"

# Define the Pandoc command
PANDOC = pandoc

# Define the template file
TEMPLATE = template.phtml

# Define the input and output file extensions
INPUT_EXT = .md
OUTPUT_EXT = .html

# Define the output directory
OUTPUT_DIR = site

# Define the input directory
INPUT_DIR = pages

# Define the Pandoc options
PANDOC_OPTS = --template=$(TEMPLATE) --shift-heading-level-by=-1

# Get a list of all .md files in the current directory
MARKDOWN_FILES := $(wildcard $(INPUT_DIR)/*$(INPUT_EXT))

# Generate the list of HTML files by replacing the input file extension with the output file extension
HTML_FILES := $(patsubst $(INPUT_DIR)/%$(INPUT_EXT),$(OUTPUT_DIR)/%$(OUTPUT_EXT),$(MARKDOWN_FILES))

# Default target: convert all .md files to HTML and move them to the output directory
all: $(OUTPUT_DIR) $(HTML_FILES)

# Rule to create the output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Rule to convert a .md file to HTML and move it to the output directory
$(OUTPUT_DIR)/%$(OUTPUT_EXT): $(INPUT_DIR)/%$(INPUT_EXT)
	$(PANDOC) -s $< -o $@ $(PANDOC_OPTS)

# Clean target: remove the output directory and all generated HTML files
clean:
	rm -rf $(HTML_FILES)

preview:
	live-server $(OUTPUT_DIR)

# Phony targets
.PHONY: all clean preview

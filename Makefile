BF_REPO_BASE := https://raw.githubusercontent.com/betaflight/firmware-presets/master

INDEXER_FILES := \
  indexer/IndexContent.js \
  indexer/PresetsFolder.js \
  indexer/check.js \
  indexer/PresetsFile.js \
  indexer/Settings.js \
  indexer/indexer.js

INDEX_OUTPUTS := \
  index.json \
  index_hash.txt

all: $(INDEX_OUTPUTS)

clean:
	rm $(INDEX_OUTPUTS)

dist-clean:
	rm $(INDEXER_FILES) $(INDEX_OUTPUTS)

$(INDEX_OUTPUTS): indexer $(INDEXER_FILES) $(PRESETS)
	node indexer/check.js
	node indexer/indexer.js

PRESETS := $(shell find presets -type f -name \*.txt)

indexer:
	mkdir -v indexer

$(INDEXER_FILES):
	curl -L -o $@ $(BF_REPO_BASE)/$(@)


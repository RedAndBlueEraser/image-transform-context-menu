.PHONY: all firefox chrome clean

OUTPUT_DIR := bin

BUILD_DIR         := build
BUILD_DIR_FIREFOX := $(BUILD_DIR)/firefox
BUILD_DIR_CHROME  := $(BUILD_DIR)/chrome

SOURCE_FILES    := manifest.json background.js content.js LICENSE
SOURCE_FOLDERS  := _locales licenses
ICONS_SVG_FILES := img/*.svg
ICONS_PNG_FILES := img/*.png

all: clean firefox chrome

firefox: $(SOURCE_FILES) $(SOURCE_FOLDERS) $(ICONS_SVG_FILES)
	mkdir -p $(BUILD_DIR_FIREFOX)
	cp $(SOURCE_FILES) $(BUILD_DIR_FIREFOX)
	for folder in $(SOURCE_FOLDERS); do echo $$folder; cp -r $$folder $(BUILD_DIR_FIREFOX); done
	mkdir -p $(BUILD_DIR_FIREFOX)/img
	cp $(ICONS_SVG_FILES) $(BUILD_DIR_FIREFOX)/img
	cd $(BUILD_DIR_FIREFOX) && zip firefox.xpi -qr *
	mkdir -p $(OUTPUT_DIR)
	mv $(BUILD_DIR_FIREFOX)/firefox.xpi $(OUTPUT_DIR)/firefox.xpi

chrome: $(SOURCE_FILES) $(SOURCE_FOLDERS) $(ICONS_PNG_FILES) tools/make-chrome.sh
	mkdir -p $(BUILD_DIR_CHROME)
	cp $(SOURCE_FILES) $(BUILD_DIR_CHROME)
	for folder in $(SOURCE_FOLDERS); do echo $$folder; cp -r $$folder $(BUILD_DIR_CHROME); done
	mkdir -p $(BUILD_DIR_CHROME)/img
	cp $(ICONS_PNG_FILES) $(BUILD_DIR_CHROME)/img
	./tools/make-chrome.sh '$(BUILD_DIR_CHROME)'
	mkdir -p $(OUTPUT_DIR)
	cp -r $(BUILD_DIR_CHROME) $(OUTPUT_DIR)/chrome

clean:
	rm -rf $(BUILD_DIR) $(OUTPUT_DIR)

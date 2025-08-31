all:
	@echo "make build      Build the site once, into the site/ folder."
	@echo "make watch      Build into the site/ folder whenever files change."
	@echo "make serve      Serve the site/ folder on http://0.0.0.0:8000"
	@echo "make deploy     Deploy whatever is in the site/ folder"

html := $(patsubst src/%.md,site/%.html,$(shell find src -name '*.md' -type f))

.PHONY: build
build: site_repo public $(html)

.PHONY: deploy
deploy:
	@if [ ! -d "site/.git" ]; then \
		echo "Error: site/ directory is not a git repository." >&2; \
		echo "Please run 'make build' first to set it up." >&2; \
		exit 1; \
	fi
	cd ./site && git add -A && git commit -m "Updated site - $$(date)" && git push origin main

.PHONY: watch
watch:
	watchman-make -p 'src/**/*.md' 'public/**' template.html -t build

.PHONY: serve
serve:
	cd ./site && python3 -m http.server

.PHONY: public
public:
	mkdir -p site
	@echo "Cleaning site directory, preserving .git"
	@find site -mindepth 1 -maxdepth 1 ! -name '.git' -exec rm -rf {} +
	cp -rv public/* public/.nojekyll site

site/%.html: src/%.md
	mkdir -p "$$(dirname "$@")"
	pandoc -t html5 --template template.html "$<" -o "$@"


.PHONY: site_repo
site_repo:
	@if [ ! -d "site/.git" ]; then \
		echo "Cloning main branch into site/ directory..."; \
		rm -rf site; \
		URL=$$(git remote get-url origin); \
		git clone -b main $$URL site; \
	fi
	@echo "Fetching and resetting site directory to origin/main";
	cd ./site && git fetch && git checkout main && git reset --hard origin/main


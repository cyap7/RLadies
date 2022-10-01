# R Ladies Brisbane: Making your Workflow work for you

**Chloe Yap, 28 Sept 2022**

This repo contains my slides from the evenings as well as demo code to demonstrate these principles.

## Set-up:

- `220928_RLadies.pdf`: slides
- `scripts/`: scripts used in my talk
  - `RLadies_demo.Rmd`: RMarkdown with demo code
  - `common_qc.R`: called within `RLadies_demo.Rmd`
  - `mtcars1.html`: output from `RLadies_demo.Rmd`
  - `logo_gallery.png`: comes with the `epurate` package which is used for the Rmarkdown template
  - `example_driver_sh/`: directory containing example .sh driver script code
    - `driver_script.sh`: driver script (Shell), which calls ...
      - `extract_CGN.sh`: ie. process 1
      - `convert_cgn_gr.sh`: ie. process 2 which is a wrapper for ...
        - `convert_cgn_gr.R`
- `data/`: data (`mtcars1.txt` just a saved version of the usual mtcars to demonstrate some principles)
- `output/`: output from the analysis
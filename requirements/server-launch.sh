#!/bin/bash
jupyter-lab --notebook-dir='lab' --allow-root --ip=0.0.0.0 --no-browser --ServerApp.token='' --port=8888
mkdocs serve

#!/bin/bash
PREFIX=$(date '+%Y%m%d_%H%M%S')
docker exec -i notebooks bash -c "cd /home/jovyan/work/notebooks && tar cvzf - \
  Knowledge_Graph.ipynb \
  LOCAL_*.ipynb \
  PythonRelatedSnippetsOrInformation.ipynb \
  Global-2000/Analysis_of_Forbes_Top_2000_Companies_2024.ipynb \
  data/Largest-Companies.csv \
  data/judge_dataset.jsonl \
" | pv > ${PREFIX}_books.tar.gz


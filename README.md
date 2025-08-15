This is jupyter lab with ollama and jupyter ai extension    
  rclone configuration still missing
  see https://github.com/jupyter/docker-stacks/tree/main/images/minimal-notebook
  see https://github.com/jupyter/docker-stacks/blob/main/images/base-notebook/Dockerfile
  see https://github.com/jupyter/docker-stacks/blob/main/images/docker-stacks-foundation/Dockerfile
  see https://github.com/krallin/tini#why-tini

![Alt text](pictures/ai_jupyterlab.png)

Notes
  - `tar --owner=1000 --group=100 -cf ../c.tar .bash_aliases .jupyter/ rclone.shr`
  - `tar --numeric-owner -tvf c.tar`


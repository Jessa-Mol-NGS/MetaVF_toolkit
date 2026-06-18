FROM anaconda/miniconda:latest

# Accept ToS via environment variable, create environment, and set it as default
ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS=true

ADD ./env/MetaVF_tookit.yaml /tmp/MetaVF_tookit.yaml

RUN conda config --add channels conda-forge
RUN conda env create -f /tmp/MetaVF_tookit.yaml -n MetaVF_toolkit

ADD . /app
WORKDIR /app

ENV PATH=/app:$PATH

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "MetaVF_toolkit", "/bin/bash", "-c"]

ENTRYPOINT ["conda", "run", "-n", "MetaVF_toolkit", "python3", "metaVF.py"]
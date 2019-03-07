FROM jupyter/scipy-notebook

USER 0

RUN pip install \
    bonobo==0.6.3 \
    bonobo[jupyter] \
    IMDbPY==6.6 \
    pandas-profiling==1.4.1 

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    jupyter nbextension enable --py --sys-prefix bonobo.contrib.jupyter

USER 0

FROM python:3
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y r-base
RUN apt-get install -y r-cran-ggplot2

RUN mkdir /work
COPY install.R /work
WORKDIR /work

RUN R CMD BATCH install.R
COPY . /work

RUN pip install dexy==2.0.8
RUN dexy setup && dexy

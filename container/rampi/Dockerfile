FROM python:3
# TODO: move to Alpine
# FROM 3.10.0-alpine3.13
ENV FLASK_ENV=development
ENV FLASK_APP=ram-webserver.py
COPY files/ram-webserver.py ./
COPY files/requierments.txt ./
#RUN apt-get install flask
#RUN python -m pip install flask ramapi
RUN pip3 install -r requierments.txt
ENTRYPOINT ["/usr/local/bin/flask","run","--host=0.0.0.0"]

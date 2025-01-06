FROM python:3
ENV FLASK_ENV=development
ENV FLASK_APP=ram-webserver.py
COPY files/ram-webserver.py ./
COPY files/requierments.txt ./
RUN pip3 install -r requierments.txt
ENTRYPOINT ["/usr/local/bin/flask","run","--host=0.0.0.0"]

FROM python:3.9-slim
WORKDIR /app
COPY ./src .
RUN pip install --no-cache-dir -r requirements.txt
RUN mkdir /txt-files
# I move the txt-files here  so in case txt-file will be change
# Then it will use cached layers
COPY txt-files /txt-files
EXPOSE 8000
CMD ["python3", "py-word-counter.py"]




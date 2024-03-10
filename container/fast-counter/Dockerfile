FROM python:3.9-slim
WORKDIR /app
COPY ./src .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8000
CMD ["python3", "counter.py"]

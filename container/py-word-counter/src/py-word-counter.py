import os
from collections import Counter
from fastapi import FastAPI

app = FastAPI()

def count_words_in_files(folder_path):
    word_counter = Counter()
    
    # Iterate over all files in the folder
    for filename in os.listdir(folder_path):
        if filename.endswith(".txt"):
            file_path = os.path.join(folder_path, filename)
            with open(file_path, 'r') as file:
                # Read all lines from the file and split them into words
                words = file.read().split()
                # Update the word counter with the words from this file
                word_counter.update(words)
    
    return word_counter

def most_common_words(folder_path, n):
    word_counter = count_words_in_files(folder_path)
    # Find the n most common words
    most_common = word_counter.most_common(n)
    return most_common

@app.get("/health-check")
async def health_check():
    return {"status": "OK"}


@app.get("/most_common_words/{n}")
async def get_most_common_words(n: int):
    folder_path = '../txt-files'
    most_common = most_common_words(folder_path, n)
    return {"most_common_words": most_common}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
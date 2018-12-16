import glob
import os
import random

def get_chunks(data_prefix):
  return glob.glob(data_prefix + "*.gz")

print("Starting splitter")

num_chunks = 1000000
num_test = 105000
num_train = 905000
path = "data-*/"

chunks = []
for d in glob.glob(path):
  chunks += get_chunks(d)

random.shuffle(chunks)
n_test = len(chunks) // 10

print("{}, {}".format(n_test, len(chunks) - n_test))

for i in range(n_test):
  path, filename = os.path.split(chunks[i])
  os.makedirs("input/test/" + path, exist_ok=True)
  os.rename(chunks[i], "input/test/" + chunks[i])

for i in range(n_test, len(chunks)):
  path, filename = os.path.split(chunks[i])
  os.makedirs("input/train/" + path, exist_ok=True)
  os.rename(chunks[i], "input/train/" + chunks[i])

print("Trimming test")
chunks = []
for d in glob.glob("input/test/data-*/"):
  chunks += get_chunks(d)

print("sorting {} chunks...".format(len(chunks)), end='')
chunks.sort(key=os.path.getmtime, reverse=True)
print("[done]")
delet = chunks[num_test:]
print("Deleting {}/{}".format(len(delet), len(chunks)))

for f in delet:
  os.remove(f)


print("Trimming train")
chunks = []
for d in glob.glob("input/train/data-*/"):
  chunks += get_chunks(d)

print("sorting {} chunks...".format(len(chunks)), end='')
chunks.sort(key=os.path.getmtime, reverse=True)
print("[done]")
delet = chunks[num_train:]
print("Deleting {}/{}".format(len(delet), len(chunks)))

for f in delet:
  os.remove(f)

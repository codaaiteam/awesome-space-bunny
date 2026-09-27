"""Token streaming from Space Bunny Alpha (pip install openai)."""
import os
from openai import OpenAI

client = OpenAI(base_url="https://spacebunnymodel.com/api/v1", api_key=os.environ["SPACE_BUNNY_API_KEY"])

stream = client.chat.completions.create(
    model="space-bunny-alpha",
    stream=True,
    messages=[{"role": "user", "content": "Write a short poem about a stealth model."}],
)
for chunk in stream:
    delta = chunk.choices[0].delta.content or ""
    print(delta, end="", flush=True)
print()

"""Space Bunny Alpha with the OpenAI Python SDK (pip install openai).
Free key: https://spacebunnymodel.com/get-jev  ->  export SPACE_BUNNY_API_KEY=sb_live_..."""
import os
from openai import OpenAI

client = OpenAI(
    base_url="https://spacebunnymodel.com/api/v1",
    api_key=os.environ["SPACE_BUNNY_API_KEY"],
)

resp = client.chat.completions.create(
    model="space-bunny-alpha",
    messages=[{"role": "user", "content": "Explain a 1M-token context window in 3 bullets."}],
)
print(resp.choices[0].message.content)

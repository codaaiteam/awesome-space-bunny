// Space Bunny Alpha with the OpenAI npm SDK (npm i openai).
// Free key: https://spacebunnymodel.com/get-jev  ->  export SPACE_BUNNY_API_KEY=sb_live_...
import OpenAI from "openai";

const client = new OpenAI({
  baseURL: "https://spacebunnymodel.com/api/v1",
  apiKey: process.env.SPACE_BUNNY_API_KEY,
});

const res = await client.chat.completions.create({
  model: "space-bunny-alpha",
  messages: [{ role: "user", content: "Explain a 1M-token context window in 3 bullets." }],
});
console.log(res.choices[0].message.content);

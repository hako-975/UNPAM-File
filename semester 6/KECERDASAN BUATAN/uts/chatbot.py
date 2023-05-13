import openai
import gradio

openai.api_key = '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'

messages = [{"role": "system", "content": "You are a lecturer"}]


def CustomChatGPT(input):
    messages.append({"role": "user", "content": input})
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=messages
    )
    ChatGPT_reply = response["choices"][0]["message"]["content"]
    messages.append({"role": "assistant", "content": ChatGPT_reply})
    return ChatGPT_reply


demo = gradio.Interface(fn=CustomChatGPT, inputs="text",
                        outputs="text", title="Chatbot Mahasiswa UNPAM")
demo.launch(share=True)

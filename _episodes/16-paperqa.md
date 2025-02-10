---
title: "How to use PaperQA with SuperPOD"
teaching: 20
exercises: 0
questions:
- "How to use PaperQA"
objectives:
- "paperqa on SuperPOD"
keypoints:
- "paperqa, Ollama, SuperPOD"
---

# PaperQA
- Large Language Models (LLMs) generalize well across language tasks, but suffer from hallucinations and uninterpretability, making it difficult to assess their accuracy without ground-truth.
- Retrieval-Augmented Generation (RAG) models have been proposed to reduce hallucinations and provide provenance for how an answer was generated. Applying such models to the scientific literature may enable large-scale, systematic processing of scientific knowledge.
- PaperQA, is a RAG agent for answering questions over the scientific literature.
- PaperQA is an agent that performs information retrieval across full-text scientific articles, assesses the relevance of sources and passages, and uses RAG to provide answers. Viewing this agent as a question answering model, we find it exceeds performance of existing LLMs and LLM agents on current science QA benchmarks. To push the field closer to how humans perform research on scientific literature, we also introduce LitQA, a more complex benchmark that requires retrieval and synthesis of information from full-text scientific papers across the literature. Finally, we demonstrate PaperQA's matches expert human researchers on LitQA.

## Open-source version
- By default paperqa use OpenAI GPT and it might cost you some token
- However, in this page, we are using the open source LLMs which are free and can be used via Ollama platform

## Requirement:

- **Ollama**: Ollama provides access to a diverse collection of pre-built models, including Llama 3.2, Phi 3, Mistral, and Gemma 2, among others. Users can easily download and run these models for various applications. 
- **cuda**: The model runs with GPU supported library cuda
- **paperqa**: model to be downloaded from https://github.com/Future-House/paper-qa

## Ollama installed on SuperPOD
- Although user can run Ollama on their personal PCs but with very large LLM model like LLAMA3 with 70B or 450B, you would need a strong GPU as A100 in SuperPOD
- The model like LLAMA3 450B can easily consumes 200gb storage of your PCs, so we have that saved locally for user to just load and run it
- Ollama version 4 has been pre-installed as module on SuperPOD, making it easier to work with

## How to installa and use paperqa on SuperPOD

### Step 1: request a compute node with 1 GPU:

```bash
$ srun -A Allocation -N1 -G1 --mem=64gb --time=12:00:00 --pty $SHELL
```

### Step 2: Load Ollama model:

```bash
$ module load ollama
```

### Step 3: Export path to Ollama model

Here we use Ollama models from STARS Project storage. Please inform me if you need access to that location.

```bash
$ export OLLAMA_MODELS=/projects/tuev/oit_rts_star/oit_rts_star_storage/Ollama_models
```

### Step 4: Serve Ollama

```bash
$ ollama serve &
```

### Step 5: Now Ollama has been loaded and served. Let's check the local models:

```bash
$ ollama list
```

You should see the screen like this:

![image](https://github.com/user-attachments/assets/bef9b961-8672-4d7f-9c3e-220ad1fde389)

If there are any other models that you want us to download, please email me: tuev@smu.edu

### Step 6: Download Ollama model

You can download any LLM model that you downloaded previously to chat:

```bash
$ ollama pull llama3:70
```

### Step 7: Install paperqa from source

paperqa can be installed with pip

```bash
$ pip install paper-qa>=5
```

### Step 8: Run paper-qa using CLI

- The fastest way to test PaperQA2 is via the CLI. First navigate to a directory with some papers and use the pqa cli:

```bash
$ pqa ask 'What manufacturing challenges are unique to bispecific antibodies?'
```

- PaperQA2 is highly configurable, when running from the command line, pqa --help shows all options and short descriptions. For example to run with a higher temperature:

```bash
$ pqa --temperature 0.5 ask 'What manufacturing challenges are unique to bispecific antibodies?'
```

- There are more way to run paperqa via CLI, please refer to their github page: https://github.com/Future-House/paper-qa

### Step 9: Using via Python library

- You can find lots of example in their github page.
- In this, we show the script that using llama3:70b llm that we use for one real project:

```python
from paperqa import Settings, ask
from paperqa.settings import AgentSettings
import os

os.environ['OPENAI_API_KEY'] = "ollama"


local_llm_config = dict(
    model_list=[
        dict(
            model_name='ollama/llama3:70b',
            litellm_params=dict(
                model='ollama/llama3:70b',
                api_base="http://localhost:11434",
            ),
        )
    ]
)

answer = ask(
    "How do marketing activities drive firm revenues?",
    settings=Settings(
        llm='ollama/llama3:70b',
        llm_config=local_llm_config,
        summary_llm='ollama/llama3:70b',
        summary_llm_config=local_llm_config,
        embedding='ollama/mxbai-embed-large',
        agent=AgentSettings(
            agent_llm='ollama/llama3:70b', 
            agent_llm_config=local_llm_config
        ),
        paper_directory="net_pdfs"
    ),
)
```

### Step 10: Stop Ollama model

```bash
$ killall ollama
```


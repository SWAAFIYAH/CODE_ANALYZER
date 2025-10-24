import from byllm{ Model }

glob myllm = Model(model_name = "llama3");


walker init {
    can start with root entry{
    report self ("Codebase Genius Backend is running!");}
    }


walker AnalyzeCode{
    has code : str;
        can start with root entry{
        report("code analysis started");

        payload = {
            "payload":"llama3",
            "prompt":"Generate a detailed summary and documentation for the following code:\n" + code
        };

                # Send request to local Ollama API

                response = std.http.post("http://127.0.0.1:11434/api/generate", body=payload);

                        # Extract and report result

                        if response.status == 200{
                            result = status.json()["response"];
                            report(result);
                        }
                        else
                        {
                              report("Failed to connect to LLM: " + str(response.status));

                        }


    }

   
}

 with entry{
        root spawn AnalyzeCode(code="printf('hello world')");
    }
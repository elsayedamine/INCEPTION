from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

def run_code(lang, code):
    if lang == "python":
        cmd = ["python3", "-c", code]
    elif lang == "bash":
        cmd = ["bash", "-c", code]
    else:
        return "error"

    # Captures the output securely inside your backend container environment
    return subprocess.run(cmd, capture_output=True, text=True, timeout=5).stdout

@app.route("/")
def home():
    return open("index.html").read()

# Match the route explicitly to your proxy location endpoint
@app.route("/run", methods=["POST"])
@app.route("/playground/run", methods=["POST"])
def run():
    data = request.get_json()
    return jsonify({"output": run_code(data["language"], data["code"])})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
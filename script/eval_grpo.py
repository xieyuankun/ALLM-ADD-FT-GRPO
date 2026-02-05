import json

def extract_label(text):
    if not text:
        return None
    text = text.strip().lower()
    if "<answer>" in text and "</answer>" in text:
        start = text.find("<answer>") + len("<answer>")
        end = text.find("</answer>")
        content = text[start:end].strip()
        if content in ["real", "fake"]:
            return content
    if text in ["real", "fake"]:
        return text
    cleaned = text.replace(" ", "")
    if cleaned in ["real", "fake"]:
        return cleaned
    return None

def calculate_acc(response_file):
    total_count = 0
    correct_count = 0

    with open(response_file, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                data = json.loads(line)

                standard_label = extract_label(data.get("labels", ""))
                if not standard_label:
                    for msg in data.get("messages", []):
                        if msg.get("role") == "assistant":
                            standard_label = extract_label(msg.get("content", ""))
                            if standard_label:
                                break

                predicted_label = extract_label(data.get("response", ""))
                if not predicted_label:
                    for msg in data.get("messages", []):
                        if msg.get("role") == "assistant":
                            predicted_label = extract_label(msg.get("content", ""))
                            if predicted_label:
                                break

                if standard_label not in ["real", "fake"] or predicted_label not in ["real", "fake"]:
                    continue

                total_count += 1
                if standard_label == predicted_label:
                    correct_count += 1
            except Exception:
                continue

    acc = correct_count / total_count if total_count > 0 else 0.0
    print(f"Accuracy: {acc:.4f} ({correct_count}/{total_count})")

if __name__ == "__main__":
    response_file = "your_ckpt_path/infer_result/.jsonl"
    calculate_acc(response_file)

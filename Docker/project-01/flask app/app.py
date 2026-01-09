from flask import Flask, request, render_template_string

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def add_numbers():
    result = None
    if request.method == 'POST':
        try:
            num1 = float(request.form.get('num1', 0))
            num2 = float(request.form.get('num2', 0))
            result = num1 + num2
        except ValueError:
            result = "Invalid input"

    html = '''
    <!doctype html>
    <title>Add Numbers</title>
    <h1>Add Two Numbers</h1>
    <form method=post>
      <input type=number step="any" name=num1 placeholder="First Number" required>
      +
      <input type=number step="any" name=num2 placeholder="Second Number" required>
      <input type=submit value=Add>
    </form>
    {% if result is not none %}
        <h2>Result: {{ result }}</h2>
    {% endif %}
    '''
    return render_template_string(html, result=result)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')